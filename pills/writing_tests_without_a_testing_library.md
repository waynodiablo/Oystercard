# Writing tests without a testing library

## What is a test?

A test does two things:

1. Sets some conditions up.
2. Checks that some things are true.

## What are testing libraries for?

A testing library supplies:

1. Mocking functions to help isolate the part of the code being tested.
2. Assertion functions that help check that specific things are true.
3. A standard way to describe what a test or group of tests is doing.
4. A way to organise tests.
5. An easy way to run lots of tests.

## Writing tests without a testing library

All of these things are either optional for test code, or can be easily achieved with adhoc code.  For example, here is some code that tests a circle object:

```js
// circle-tests.js

(function(exports) {
  function testCircleRadiusDefaultsTo10() {
    var circle = new Circle();

    if (circle.radius !== 10) {
      throw new Error("Circle size is not 10");
    }
  };

  testCircleRadiusDefaultsTo10();
})(this);
```

Here is the code for the implementation of `Circle`:

```js
// circle.js

(function(exports) {
  function Circle() {
    this.radius = 10;
  };

  exports.Circle = Circle;
})(this);
```

To run these tests:

* Create an HTML page.
* Create the `circle.js` file.
* Use a script tag to include `circle.js` in `index.html`.
* Create the `circle-tests.js` file.
* Use a script tag to include `circle-tests.js` in `index.html`.
* Open the HTML page in a browser.

This is pretty ugly.

* It takes three lines of code to assert one thing.
* A custom error description must be supplied.
* The description of the test has to be expressed as a function name.
* The test function is instantiated as a first step and called as a second step.

But it works.

## Writing nicer tests without a testing library

It's fine to potter along for quite a while writing test code in this style.  It would be possible to make a whole file of test functions like this and have an app that is just as robust and well-tested as an app tested with a testing library.

But the eye-watering agony could be reduced by abstracting some of the ugliness.  Here are a few lines that can be used to greatly improve the test code:

```js
// assert.js

var assert = {
  isTrue: function(assertionToCheck) {
    if (!assertionToCheck) {
      throw new Error("Assertion failed: " + assertionToCheck + " is not truthy");
    }
  };
};
```

Now our test becomes:

```js
// circle-tests.js

function testCircleRadiusDefaultsTo10() {
  var circle = new Circle();
  assert.isTrue(circle.radius === 10);
};

testCircleRadiusDefaultsTo10();
```

Ten or twenty more lines of testing library code would supply 80% of the standard `describe`, `it`, mocking and asserting library deliciousness.

What would you abstract next?

## Extracting a testing library

If you want, you can go all the way and make your test helper code into its own testing library.

Here are some things to consider:

* How can you move your test helper code into its own repo?

* How can you allow your notes app to access your test library repo?

* How can you write tests for your test library? (!)

* What API should your test library have?

* How will you publish your library? npm?
