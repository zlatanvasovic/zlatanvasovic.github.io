---
layout: post
title: Code organization
---

One of the most important things for the new project is **organization of code**.

You don't need to think a lot when organize code for desktop app, or something like that. Same is with web apps and sites.

## Directories

### Hard-programmed project

Easy.

`/benchmark` or `/test` - app testing  
`/bin` - binary scripts  
`/lib` - code libraries  
`/src` - source code  

Put all config files in root directory.

### On the Web

You can use `/assets` for JS, CSS, and other things. You can also organize that separately (see directories below).

`/js` - JavaScript  
`/css` - CSS  
`/img` - images  
`/font` - fonts

Put pages in root directory.

## Language shorthands

One more tip - **don't use long names for specific code directory**. It's better to use the shortest and the most semantic file extension of the language. *P.S. Here is a few exceptions.*

A few examples:
- C - `c`
- Node.js - `node`
- Objective C - `objc`
- Python - `py`
- Ruby - `rb`
- Shell - `script` (it's better to use `/bin`)

## Writing

First, you need to have an style guide.

Use includes instead of writing same code more times. Most of langauges have it.

Also add comments to your code. It's easier to edit.

For other search web with *&lt;language&gt; styleguide*.
