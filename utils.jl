using Dates

function hfun_datetext(date=locvar("rss_pubdate"))
    datetext = "$(monthname(date)) $(day(date)), $(year(date))"
    return datetext
end

# Based on https://github.com/JuliaLang/www.julialang.org/blob/master/utils.jl
function hfun_blogposts()
    curyear = year(Dates.today())
    io = IOBuffer()
    for year in curyear:-1:2020
        ys = "$year"
        for month in 12:-1:1
            ms = "0"^(month < 10) * "$month"
            base = joinpath("blog", ys, ms)
            isdir(base) || continue
            posts = filter!(p -> endswith(p, ".md"), readdir(base))
            days = zeros(Int, length(posts))
            lines = Vector{String}(undef, length(posts))
            for (i, post) in enumerate(posts)
                ps = splitext(post)[1]
                url = "/blog/$ys/$ms/$ps/"
                surl = strip(url, '/')
                title = pagevar(surl, :title)
                rss = pagevar(surl, :rss)
                date = pagevar(surl, :rss_pubdate)
                datetext = hfun_datetext(date)
                days[i] = day(date)
                lines[i] =
                    """
                    ~~~
                    <div class="card border-dark mb-4">
                      <div class="card-body">
                        <h4 class="card-title"><a href="$url">$title</a></h5>
                        <p class="card-text">$rss</p>
                        <p class="card-text"><small class="text-muted">$datetext</small></p>
                      </div>
                    </div>
                    ~~~
                    """
            end
            # Sort by day
            foreach(line -> write(io, line), lines[sortperm(days, rev=true)])
        end
    end
    # markdown conversion adds `<p>` beginning and end but
    # we want to avoid this to avoid an empty separator
    r = Franklin.fd2html(String(take!(io)), internal=true)
    return r
end
