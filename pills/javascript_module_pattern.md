# JavaScript module pattern

A design pattern to encapsulate and share your JavaScript code.

## Immediately Invoked Function Expression (IIFE)

Let's start by talking about a part of the module pattern: the Immediately Invoked Function Expression (or IFFE, pronounced "iffy").  At its simplest, it looks like this:

```js
(function() {
  console.log("hi");
})();
```

### How does this code work?

There's the anonymous function declaration.  This function prints `hi`.

```js
function() {
  console.log("hi");
}
```

There are the mysterious parentheses than wrap the anonymous function.  These are just to [keep the JavaScript syntax checker happy](http://benalman.com/news/2010/11/immediately-invoked-function-expression/).

```js
(function() {
  console.log("hi");
})
```

There are the final set of parentheses after the wrapping parentheses.  These run the anonymous function.

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

This code does the same thing the IIFE does.  But it's more verbose. And it creates an unnecessary variable that no one needs called `printHi`.

### Why?

It's kind of useless to wrap just a call to `console.log` in an IIFE.  The `console.log` would be fine on its own, without an IFFE.  So why do we use IFFEs? To hide stuff.

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

Using an IIFE to wrap all this code keeps the details of creating the greeting private.  None of the rest of the program has to worry about `exclaim` or what it is.  All the details of exclaiming hi are gathered together and hidden.

What does "hidden" mean? It means none of the rest of the code can access any variables inside the IIFE.

```js
(function () {
  var EXCLAMATION_MARK_COUNT = 5

  function exclaim(string) {
    return string + "!".repeat(EXCLAMATION_MARK_COUNT);
  };

  console.log(exclaim("hi"));
})();

// throws a ReferenceError
exclaim();

// would throw a ReferenceError, if not for the previous reference error
console.log(EXCLAMATION_MARK_COUNT);
```

## The module pattern

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

// returns "hi!!!!!"
exclaim("hi");

// throws a ReferenceError
console.log(EXCLAMATION_MARK_COUNT);
```

So we can access `exclaim`, but `EXCLAMATION_MARK_COUNT` is hidden.  Cool.  We've made available the function we want people to use, but hidden some implementation details that we don't want to bother them with.

How have we made `exclaim` available? Grab the code and paste it into your browser console.  (Make sure to use your browser console or a JS file you load in the browser.  Running this code in node will behave slightly differently.  See the [Using modules in node](#using-modules-in-node) section below.)

Use `console.log` to see the data stored in variables.  Follow the flow of this data through the program.  Notice how the value of `this` is `window`, the place where all globals are stored.  What value does `exports` have? What happens when `exclaim` is added as an attribute to `exports`?

As an experiment, try changing `exports` to `blahblah` in all the places it appears in the code snippet above.  Does the code still work?

Have you investigated? You probably found that `this` and `exports` are the global object.  This means that adding `exclaim` onto `exports` is effectively making `exclaim` globally available.  That's why we can call `exclaim("hi")`.

## Using modules in the browser

Let's put this module pattern into practice.

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

We can now use `exclaim()` in `app.js` to say `howdy!!!!!`.

```js
// app.js

console.log(exclaim("howdy"));
```

## Using modules in node

We've used our `exclaim` module in our browser code.  Now we want to use it in node.  For example, in our tests that we run with node.  This is pretty easy:

```js
// exclaim-test.js

var exclaim = require("./exclaim").exclaim;

if (exclaim("hi") !== "hi!!!!!") {
  throw new Error("Exclaiming hi should equal hi!!!!!");
} else {
  console.log(".");
}
```

Play around with this code.  What value does `exclaim` have? Why does `require("./exclaim")` have `.exclaim` after it?

So the module pattern we used with exclaim works in both the browser and in node.  Cool!

### How does `exclaim` export its API in node?

```js
(function(exports) {
  var EXCLAMATION_MARK_COUNT = 5

  function exclaim(string) {
    return string + "!".repeat(EXCLAMATION_MARK_COUNT);
  };

  exports.exclaim = exclaim;
})(this);
```

Remind yourself what `this` (at the top level) and `exports` are in the browser.  Things are a little different in node.  `this` at the top level points at a special object that node provides called `exports`.  Anything that you attach to `exports` will be available when you require the module.  In this case, `exclaim` is attached to `exports`, which means that you can write `var exclaim = require("./exclaim").exclaim;` in another file to get hold of the `exclaim` function.

> The values of `this` in the browser (`window`) and `this` in node (`exports`) are different.  But they are similar enough that they can both be massaged by this pattern to let us write code that will work in both environments.

Run the code above in node.  Play around, `console.log` some variables to understand how all this stuff works.

## What if one module needs to require another module?

What if `exclaim` needs to use code from another module to do its work? In the rewrite below, the programmer has pretty pointlessly abstracted out the code that produces the repeated exclamation marks.

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

In the browser, this code works fine.  `repeat` is a global variable, so all is well.

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

But this code doesn't work in node.  Here is one way we can rewrite `exclaim` to support node and the browser.  There are other ways, but this one is simple and clear.

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

We have injected the `repeat` function into `exclaim`.  To support this, here are the slightly rewritten `app.js` and node test file `exclaim-test.js`:

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

## There are many ways to implement the module pattern

Different people use different ways to achieve the module pattern.  For example, here is another way to put exclaim as a module pattern:

```js
var exclaim = (function() {
  var EXCLAMATION_MARK_COUNT = 5

  function exclaim(string) {
    return string + "!".repeat(EXCLAMATION_MARK_COUNT);
  };

  return { exclaim: exclaim };
})();
```

The way the pattern is achieved isn't very important.  The important part is achieving the goal of encapsulation.

## Build tools

The module pattern is a hack to deal with the fact that earlier browser JavaScript specifications don't provide a standard way to import code from a module.  Using `require` is much nicer.  Some people use build tools like Webpack and Browserify to let them use require in browser JavaScript code.  These tools take all the JavaScript files in a project and lightly rewrite the code to turn the `require` expressions into code that will work in the browser.

However, while using a build tool can solve this problem, it adds another layer of complexity to your setup.

## Resources

- [JavaScript module pattern workshop](https://github.com/makersacademy/skills-workshops/tree/master/week-7/javascript-module-pattern-workshop). Includes a whole app example of using the module pattern.
