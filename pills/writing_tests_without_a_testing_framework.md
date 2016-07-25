# Writing tests without a testing framework

## What is a test?

A test does two things:

1. Sets some conditions up.
2. Checks that some things are true.

## What are test frameworks for?

A test framework does a few things:

1. Gives you library functions to help you isolate the part of your code you want to test from the rest of your code.
2. Gives you useful assertion functions that help you check specific things are true.
3. Gives you a standard way to describe what a test or group of tests are doing.
4. Gives you a structure to organise your tests.
5. Gives you a way to run all your tests.

## Writing tests without a testing framework

All of these things are either optional for test code, or can be achieved with adhoc code.  For example:

```js
// box-tests.js

function testCanInstantiateANewBox() {
  var box = new Box();

  if (!(box instanceof Box)) {
    throw new Error("The box was not an instance of Box");
  }
};

testCanInstantiateANewBox();
```

This is pretty janky:

* We have to use a three line block of code to assert something.
* We have to supply a custom description of the error in case the assertion fails.
* We have to use camel case to describe what the test is testing.
* We have to instantiate the test function as a first step and call it as a second step.

But it works.

## Writing nicer tests without a testing framework

It's fine to potter along for quite a while writing test code in the style above.  We could make a whole file of test functions and end up with app that is just as robust and well-tested as an app tested with a test framework.

But we could also reduce the eye-watering by abstracting some of the ugliness.  Here is one easy but big improvement:

```js
// tiny-assertion-library.js

function isTrue(assertionToCheck) {
  if (!assertionToCheck) {
    throw new Error("Assertion failed: " + assertionToCheck + " is not truthy");
  }
};
```

Now our test becomes:

```js
var assert = require("./tiny-assertion-library").assert;

function testCanInstantiateANewBox() {
  var box = new Box();
  assert(box instanceof Box);
};

testCanInstantiateANewBox();
```

> We're assuming we're running our tests in node.

Ten or twenty more lines of test framework code would get us most of the way to having 80% of the `describe`, `it`, mocking, asserting test framework deliciousness that we're used to.

What would you abstract next?
