# Writing tests without a testing framework

## What is a test?

A test does two things:

1. Sets some conditions up.
2. Checks that some things are true.

## What are testing frameworks for?

A testing framework gives you:

1. Library functions to help you isolate the part of your code you want to test from the rest of your code.
2. Assertion functions that help you check specific things are true.
3. A standard way to describe what a test or group of tests is doing.
4. A structure to organise your tests.
5. A way to easily run lots of tests.

## Writing tests without a testing framework

All of these things are either optional for test code, or can be easily achieved with adhoc code.  For example:

```js
// circle-tests.js

function testCircleRadiusDefaultsTo10() {
  var circle = new Circle();

  if (circle.radius() !== 10) {
    throw new Error("Circle size is not 10");
  }
};

testCircleRadiusDefaultsTo10();
```

You could write this code in a file that you run with [node](node.md).  Or you could create an HTML page that uses a script tag to include your test file, and open the HTML page in a browser to run your tests.

This is pretty ugly.

* We have to use a three line block of code to assert one thing.
* We have to supply a custom error description in case the assertion fails.
* We have to use camel case to describe what the test is testing.
* We have to instantiate the test function as a first step and call it as a second step.

But it works.

## Writing nicer tests without a testing framework

It's fine to potter along for quite a while writing test code in this style.  We could make a whole file of test functions and end up with app that is just as robust and well-tested as an app tested with a testing framework.

But we could also reduce the eye-watering agony by abstracting some of the ugliness.  Here is one easy but big improvement:

```js
// assert.js

function isTrue(assertionToCheck) {
  if (!assertionToCheck) {
    throw new Error("Assertion failed: " + assertionToCheck + " is not truthy");
  }
};
```

Now our test becomes:

```js
// circle-tests.js

var assert = require("./assert");

function testCircleRadiusDefaultsTo10() {
  var circle = new Circle();
  assert.isTrue(circle.radius === 10);
};

testCircleRadiusDefaultsTo10();
```

> We're assuming we're running our tests in node.

Ten or twenty more lines of testing framework code would get us most of the way to having 80% of the `describe`, `it`, mocking and asserting framework deliciousness that we're used to.

What would you abstract next?
