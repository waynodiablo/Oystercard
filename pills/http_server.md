# http-server

A small library that runs a local server to serve static assets like HTML, CSS and JavaScript.  It's useful for serving a frontend website locally.

## Prerequisites

[Node](node.md) and [npm](npm.md) installed.

## Running from the command line

In your project, run:

    $ cd root/of/your-project/
    $ npm install http-server --save
    $ node node_modules/http-server/bin/http-server

Browse your project at the URL in the console output.

## Running from your code

This is useful when you need to serve a version of your project for your tests to run against.

    $ cd root/of/your-project/
    $ npm install http-server --save-dev

```js
var createServer = require("http-server").createServer;
var server = createServer({ root: path.join(__dirname, "path/to/your/project/root") });
server.listen(3000);
```

## Resources

- [http-server documentation on npmjs.com](https://www.npmjs.com/package/http-server)
