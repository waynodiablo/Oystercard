## About Node

* Stable version: 0.12
* Previous stable version: 0.10
* Most people are using this version
* io.js: https://iojs.org
* Documentation (bookmark this): https://nodejs.org/api/


## Node’s Internals

* Binary dependencies:
  * V8: JavaScript runtime
  * libuv: Event loop, asynchronous networking and file system operations, optimised for Windows, Mac OS X, and Unix
  * zlib, OpenSSL, HTTP Parser, C-Ares (DNS)
* Internal C and C++:
  * Bootstrapping the Node process
  * Handling for processes, OS streams, TTY
* Core modules:
  * Found in the lib/ folder
  * Written in JavaScript, uses some native bindings through process.binding
  * Includes: assert, buffer, dns, http and https, net, stream, timers


## The module system

* Load a file with var example = require('./example.js');
  * The extension can be omitted: Node will try .js, .json, and then .node
  * This means you can load data from JSON files very easily, which is ideal for configuration files in web development
* Modules are cached, so repeatedly requiring require('app.js') will return the same exported object
* Modules have their own scope, so even though functions have global scope in JavaScript they'll only be available in the current file unless exported
* Useful technique: folders as modules


## Making a module

1. Create a new file called example.js
2. "Export" the objects you're interested with "module.exports"
3. If the module only needs to do one thing, you can export a function

### Exporting multiple things:

```javascript
module.exports.fib = fib;
module.exports.jortSort = jortSort;

function fib(n) {
  return function(n, a, b) {
    return n>0 ? arguments.callee(n-1, b, a + b) : a;
  }(n, 0, 1);
}

function jortSort(array) {
  var originalArray = array.slice(0);
  array.sort(function(a, b) { return a - b; });
  for (var i = 0; i < originalArray.length; ++i) {
    if (originalArray[i] !== array[i]) return false;
  }
  return true;
}
```

Usage:

```javascript
var stuff = require('./stuff');
stuff.fib(4);
stuff.jortSort([33, 2, 44, 1, 92]);
```

### Exporting a single function:

```
module.exports = function(n) {
  return function(n, a, b) {
    return n>0 ? arguments.callee(n-1, b, a + b) : a;
  }(n, 0, 1);
};
```

Usage:

```
var fib = require('./fib');
fib(4);
```

## The module system: npm

* The npm command comes with Node and can be used to install modules
* npm search express
* Searches npm for “express"
* The modules are generally installed per-project, but you can install global modules for useful command-line tools
* When you load a module, you just call require('module_name') and Node will search ./node_modules and the global node_modules folder

Example:

```shell
$ npm install express
$ node
> var express = require('express');
```

### Globals

* Log messages with console (console.log, console.error, console.trace)
* Command-line arguments are in the process.argv array
* Process object: process.exit(code), process.on('SIGHUP', cb)

### Buffers

* Handle binary data
* A Buffer is a bit like an array of integers but uses raw memory outside the V8 heap
* Convert between different encodings
* ascii, utf8, utf16le, base64, hex

Example:

```javascript
var buf = new Buffer('string');
var encoded = buf.toString('base64');
```
### Events

* The 'events' module provides the EventEmitter class
* Create instances of EventEmitter to act as message buses
* Inherit from EventEmitter to make  your own event handling classes
* Several important objects are based on EventEmitter for networking and file system operations
* Idiom: Event names are written in camelCase
* Idiom: Emitting 'error' events causes an exception to be raised if there's no listener 
* Idiom: Lots of things use events which is useful for architecture: for example, the Express "app" object

```javascript
var EventEmitter = require('events').EventEmitter;
var messageBus = new EventEmitter();

// Add a listener
messageBus.on('notify', function(message) {
  console.log('Event received with message:', message);
});

messageBus.emit('notify');
```

## Streams

* An object that represents a stream of values
* Can be readable, writeable, or both
* They're best learned by practicing
  * Try Stream Adventure https://github.com/substack/stream-adventure
* All stream objects inherit from EventEmitter
* You'll find them in the networking API, HTTP API, and file system
* In Express, the request object is a stream, which means you can stream POST data (from forms, file uploads, etc.)
* The stream API is simple to use, but it's hard to actually write stream classes yourself

The "pipe" method lets you pipe streams a bit like in the terminal:

```javascript
var r = fs.createReadStream('file.txt');
var z = zlib.createGzip();
var w = fs.createWriteStream('file.txt.gz');
r.pipe(z).pipe(w);
```

## Other core modules

* fs: Asynchronous and synchronous file system modules
* net: Networking, which includes TCP, UDP, and HTTP client and server
* assert: Useful for testing

## Testing

* You should use a test runner: Mocha is popular and has a simple API
* The built-in assertions are OK and would be what I'd teach, but many people use other APIs like Chai http://chaijs.com
* I also think this is where people should be taught about npm scripts
  * You can add a property to the package.json file for the test script so you can run tests with npm test


![Tracking pixel](https://githubanalytics.herokuapp.com/course/node/alexyoung/node_intro.md)
