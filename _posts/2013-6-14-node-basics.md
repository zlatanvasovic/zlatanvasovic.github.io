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

I will use serving of HTML5 page with colored console log as example. Find the code on <https://gist.github.com/ZDroid/d235063f07d0fd1dbeb1>.

Just run `node serve.js` and visit your server at <http://localhost:5555> (or <http://127.0.0.1:5555>). **:)**

## Experiments

You can test node in many ways, but npm modules are the most funny way for experimenting. You can find all modules in [registry](https://npmjs.org/).

If you want to use WebSockets protocol (`ws:`) for node server, you need [**socket.io**](http://socket.io), one of the most popular modules.

----

If you want more, visit [nodejs.org](http://nodejs.org).
