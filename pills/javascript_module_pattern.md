# JavaScript module pattern

A design pattern to encapsulate your JavaScript code.

## Immediately Invoked Function Expression (IIFE)

Let's start by talking about a part of the module pattern: the Immediately Invoked Function Expression (or IIFE, pronounced "iffy").  At its simplest, it looks like this:

```js
(function() {
  console.log("hi");
})();
```

### How does this code work?

First, there's an anonymous function declaration.  This function prints `hi`.

```js
function() {
  console.log("hi");
}
```

Second, there are a set of mysterious parentheses that wrap the anonymous function.  These are just to [keep the JavaScript syntax checker happy](http://benalman.com/news/2010/11/immediately-invoked-function-expression/).

```js
(function() {
  console.log("hi");
})
```

Third, there are a final set of parentheses after the wrapping parentheses.  These run the anonymous function.

```js
(function() {
  console.log("hi");
})();
```

To understand this, imagine we instead had this code:

```js
function printHi() {
  console.log("hi");
};

printHi();
```

This code does the same thing the IIFE does.  But it's more verbose. And it creates an unnecessary variable, `printHi` that no one needs.

### Why?

It's pointless to wrap just a call to `console.log` in an IIFE.  We use IIFEs to hide variable and function declarations.  Calling `console.log` doesn't declare any variables, so it doesn't need to be wrapped in an IIFE.

Imagine we wanted to formulate a more complex greeting than just `hi`.

```js
(function () {
  var EXCLAMATION_MARK_COUNT = 5

  function exclaim(string) {
    return string + "!".repeat(EXCLAMATION_MARK_COUNT);
  };

  console.log(exclaim("hi"));
})();
```

Using an IIFE to wrap all this code keeps the details of creating the greeting private.  None of the rest of the program has to worry about `exclaim` or what it is.  All the details of exclaiming `hi` are gathered together and hidden.

What does "hidden" mean? It means none of the rest of the code can access any variables or functions inside the IIFE.  Look what happens when we try to use `exclaim` and `EXCLAMATION_MARK_COUNT` outside the IIFE:

```js
(function () {
  var EXCLAMATION_MARK_COUNT = 5

  function exclaim(string) {
    return string + "!".repeat(EXCLAMATION_MARK_COUNT);
  };
})();

// throws a ReferenceError
exclaim("hi");

// would throw a ReferenceError, if not for the ReferenceError thrown
// by the previous line
console.log(EXCLAMATION_MARK_COUNT);
```

## Using the module pattern in the browser

The module pattern is basically just an IIFE.  But it uses a bit of extra code to export (or expose, or make available to the outside, or show) functions and variables that are part of the public interface of the module.

Here is a tiny module:

```js
(function(exports) {
  var EXCLAMATION_MARK_COUNT = 5

  function exclaim(string) {
    return string + "!".repeat(EXCLAMATION_MARK_COUNT);
  };

  exports.exclaim = exclaim;
})(this);
```

To explore this code, let's try and use the exclaim function:

```js
(function(exports) {
  var EXCLAMATION_MARK_COUNT = 5

  function exclaim(string) {
    return string + "!".repeat(EXCLAMATION_MARK_COUNT);
  };

  exports.exclaim = exclaim;
})(this);

// prints "hi!!!!!"
console.log(exclaim("hi"));

// throws a ReferenceError
console.log(EXCLAMATION_MARK_COUNT);
```

So we can access `exclaim`, but `EXCLAMATION_MARK_COUNT` is hidden.  Cool.  We've made available the function we want people to use, but hidden some implementation details that we don't want to bother them with.  We've also prevented our hidden variables from clashing with variables in the rest of our program.  For example, we could have two modules, each of which define and keep private their own `EXCLAMATION_MARK_COUNT`.

### How does `exports` work?

How have we made `exclaim` available? Grab the code and paste it into your browser console.  (Make sure to use your browser console or a JS file you load in the browser.)

Use `console.log` to print the data stored in variables like `this` and `exports`.  Follow the flow of this data through the program.  Some points to help you:

* Notice how the value of `this` is `window`, the place where all globals are stored.

* What value does `exports` have?

* What happens when `exclaim` is added as an attribute to `exports`?

* As an experiment, try changing `exports` to `blahblah` in all the places it appears in the code snippet above.  Does the code still work?

Have you investigated? You probably found that `this` and `exports` are the global object.  This means that adding `exclaim` onto `exports` is effectively making `exclaim` globally available.  That's why we can call `exclaim("hi")`.

### Using the module

Let's use this module.

```js
// index.html

<html>
  <head>
    <script src="app.js"></script>
  </head>
  <body></body>
</html>
```

```js
// app.js

console.log("howdy");
```

We have a new file, `app.js`, that prints `howdy`.  We have an `index.html` file that sources `app.js`.  This runs `app.js` in the browser.

If we want to use our exclaim module, we can just source it in `index.html`.  When we include `exclaim.js` in `index.html`, the code in `exclaim.js` is run.  This sets up the module and makes `exclaim()` globally available to all our JavaScript code.

```js
// exclaim.js

(function(exports) {
  var EXCLAMATION_MARK_COUNT = 5

  function exclaim(string) {
    return string + "!".repeat(EXCLAMATION_MARK_COUNT);
  };

  exports.exclaim = exclaim;
})(this);
```

```js
// index.html

<html>
  <head>
    <script src="exclaim.js"></script>
    <script src="app.js"></script>
  </head>
  <body></body>
</html>
```

We can now use `exclaim()` in `app.js` to say `howdy!!!!!`:

```js
// app.js

console.log(exclaim("howdy"));
```

### What if one module needs to require another module?

In the rewrite below, the programmer wants to abstract out the code that can repeat the exclamation marks.  They create a new module, `repeat`.

```js
// repeat.js

(function(exports) {
  function repeat(string, count) {
    return string.repeat(count);
  };

  exports.repeat = repeat;
})(this);
```

```js
// exclaim.js

(function(exports) {
  var EXCLAMATION_MARK_COUNT = 5;

  function exclaim(string) {
    return string + repeat("!", EXCLAMATION_MARK_COUNT);
  };

  exports.exclaim = exclaim;
})(this);
```

This works great.  `repeat` is available because it's a global variable, so all is well.

```js
// index.html

<html>
  <head>
    <script src="repeat.js"></script>
    <script src="exclaim.js"></script>
    <script src="app.js"></script>
  </head>
  <body></body>
</html>
```

## Using the module pattern in Node.js

(What is Node.js? See the [Node.js](./node.md) :pill:.  If you're just working on a frontend-only app, you don't need to worry about how to use the module pattern in Node.js.)

What happens if we want to use our `exclaim` module in Node.js? Well, it depends which version of the exclaim module we're talking about: the one that contained the repeat functionality, or the one that used the separate repeat module.

### A module that doesn't include any other modules

This version of `exclaim` contains the repeat functionality.

```js
(function(exports) {
  var EXCLAMATION_MARK_COUNT = 5

  function exclaim(string) {
    return string + "!".repeat(EXCLAMATION_MARK_COUNT);
  };

  exports.exclaim = exclaim;
})(this);
```

This version that we wrote for the browser works perfectly, without any changes, in Node.js.  Look:

```js
// exclaim-test.js

var exclaim = require("./exclaim").exclaim;

if (exclaim("hi") !== "hi!!!!!") {
  throw new Error("Exclaiming hi should equal hi!!!!!");
} else {
  console.log(".");
}
```

Cool!

Play around with this code.  Some questions:

* What value does `exclaim` have?

* Why does `require("./exclaim")` have `.exclaim` after it?

#### How does this work?

```js
(function(exports) {
  var EXCLAMATION_MARK_COUNT = 5

  function exclaim(string) {
    return string + "!".repeat(EXCLAMATION_MARK_COUNT);
  };

  exports.exclaim = exclaim;
})(this);
```

Remind yourself what `this` (at the top level) and `exports` are in the browser.  Things are a little different in Node.js.  `this` at the top level points at a special object that node provides called `exports`.  Anything that you attach to `exports` will be available when you require the module.  In this case, `exclaim` is attached to `exports`, which means that you can write `var exclaim = require("./exclaim").exclaim;` in another file to get hold of the `exclaim` function.

> The values of `this` in the browser (`window`) and `this` in Node.js (`exports`) are different.  But they are similar enough that they can both be massaged by this pattern to let us write code that will work in both environments.

Run the code above in Node.js.  Play around. `console.log` some variables to understand how all this stuff works.

### A module that requires other modules

This version of the `exclaim` module breaks out the `repeat` functionality into a separate module.

```js
// repeat.js

(function(exports) {
  function repeat(string, count) {
    return string.repeat(count);
  };

  exports.repeat = repeat;
})(this);
```

```js
// exclaim.js

(function(exports) {
  var EXCLAMATION_MARK_COUNT = 5;

  function exclaim(string) {
    return string + repeat("!", EXCLAMATION_MARK_COUNT);
  };

  exports.exclaim = exclaim;
})(this);
```

This version of the `exclaim` module won't work in Node.js.  The behaviour of the browser that makes `repeat` available as a global doesn't work in Node.js

Here is one way we can rewrite `exclaim` to support Node.js and the browser.  There are other ways, but this one is simple and clear.

```js
// exclaim.js

(function(exports) {
  var EXCLAMATION_MARK_COUNT = 5;

  function exclaim(repeat, string) {
    return string + repeat("!", EXCLAMATION_MARK_COUNT);
  };

  exports.exclaim = exclaim;
})(this);
```

We have injected the `repeat` function into `exclaim`.  To support this, here are the slightly rewritten `app.js` and Node.js test file `exclaim-test.js`:

```js
// app.js

console.log(exclaim(repeat, "howdy"));
```

```js
// exclaim-test.js

var repeat = require("./repeat").repeat;
var exclaim = require("./exclaim").exclaim;

if (exclaim(repeat, "hi") !== "hi!!!!!") {
  throw new Error("Exclaiming hi should equal hi!!!!!");
} else {
  console.log(".");
}
```

## Other ways to achieve the module pattern

Different developers use different syntaxes to achieve the module pattern.  In this article, we've explored one of those ways.  The way the pattern is achieved isn't very important.  The important part is achieving the goal of encapsulation.

## Build tools

The module pattern is a hack to deal with the fact that earlier browser JavaScript specifications don't provide a standard way to import code from a module.  Using `require` is much nicer.  Some people use build tools like Webpack and Browserify to let them use require in browser JavaScript code.  These tools take all the JavaScript files in a project and lightly rewrite the code to turn the `require` expressions into code that will work in the browser.

However, while using a build tool can solve this problem, it adds another layer of complexity to your setup.

## Resources

- [JavaScript module pattern workshop](https://github.com/makersacademy/skills-workshops/tree/master/week-7/javascript-module-pattern-workshop). Includes a whole app example of using the module pattern.
