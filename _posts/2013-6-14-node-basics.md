---
layout: post
title: Node basics
---

I want to share a few Node basics with you...

This tips are for Linux and OS X.

## Install

OS X users can download binary / install packages from [downloads page](http://nodejs.org/download/).

Linux users need to compile it, so I made [a script](https://github.com/ZDroid/zdsh/blob/master/script/nodeinstall.sh) for that.

You will not have a problem with **npm**, it comes with node.

## Run server

So, once when you install node, you can run a test server.

I will use serving of HTML5 page with colored console log as example.

<code><b>serve.js</b></code>
{% highlight javascript %}
#!/usr/bin/env node

var http = require('http'), // http server
    fs = require('fs');     // file system module

fs.readFile('./serve.html', function (err, html) {

  if (err) {
    res.writeHead(500);
    return res.end('Error loading index.html');
  }

  http.createServer(function(request, response) {
    response.writeHeader(200, {"Content-Type": "text/html"});
    response.write(html);
    response.end();
  }).listen(5555, '127.0.0.1');

});

// Write a run message...
var white = '\033[1;37m'
    blue  = '\033[1;34m';
    reset = '\033[0m';

console.log('\n' + white + '[HTTP] ' + reset + 'Server running ' + blue + '@ ' + reset + 'http://localhost:5555' + reset + '\n')
{% endhighlight %}

<code><b>serve.html</b></code>
{% highlight html %}
<!doctype html>
<html lang=en>
  <head>
    <meta charset=utf-8 />
    <title>serve.js</title>
    <style>
      h1 {
        text-align: center;
        color: #666;
        font: 70px "Droid Sans", Arial, sans-serif
      }
    </style>
  </head>
  <body>
    <h1>serve.js</h1>
  </body>
</html>
{% endhighlight %}

Just run `node serve.js` and visit your server at <http://localhost:5555> (or <http://127.0.0.1:5555>). **:)**

## Experiments

You can test node in many ways, but npm modules are the most funny way for experimenting. You can find all modules in [registry](https://npmjs.org/).

If you want to use WebSockets protocol (`ws:`) for node server, you need [**socket.io**](http://socket.io), one of the most popular modules.

----

If you want more, visit [nodejs.org](http://nodejs.org).
