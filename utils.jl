using Dates

function hfun_m1fill(vname)
    var = vname[1]
    return pagevar("index", var)
end

function lx_baz(com, _)
    # keep this first line
    brace_content = Franklin.content(com.braces[1]) # input string
    # do whatever you want here
    return uppercase(brace_content)
end

# Based on https://github.com/JuliaLang/www.julialang.org/blob/master/utils.jl
function hfun_blogposts()
    curyear = Dates.Year(Dates.today()).value
    io = IOBuffer()
    for year in curyear:-1:2020
        ys = "$year"
        year < curyear && write(io, "\n**$year**\n")
        for month in 12:-1:1
            ms = "0"^(1-div(month, 10)) * "$month"
            base = joinpath("blog", ys, ms)
            isdir(base) || continue
            posts = filter!(p -> endswith(p, ".md"), readdir(base))
            days    = zeros(Int, length(posts))
            lines = Vector{String}(undef, length(posts))
            for (i, post) in enumerate(posts)
                ps    = splitext(post)[1]
                url = "/blog/$ys/$ms/$ps/"
                surl = strip(url, '/')
                title = pagevar(surl, :title)
                pubdate = pagevar(surl, :published)
                rss = pagevar(surl, :rss)
                date = Date(pubdate, dateformat"U d, Y")
                days[i] = day(date)
                lines[i] =
                    """~~~
                    <div class="card border-dark mb-4">
                      <div class="card-body">
                        <h4 class="card-title text-title"><a href="$url">$title</a></h5>
                        <p class="card-text">$rss</p>
                        <p class="card-text"><small class="text-muted">$pubdate</small></p>
                      </div>
                    </div>
                    ~~~
                    """
            end
            # sort by day
            foreach(line -> write(io, line), lines[sortperm(days, rev=true)])
        end
    end
    # markdown conversion adds `<p>` beginning and end but
    # we want to avoid this to avoid an empty separator
    r = Franklin.fd2html(String(take!(io)), internal=true)
    return r
end
