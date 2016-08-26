# Mocking in JavaScript

Some testing frameworks provide functions that help the user implement mocks.  It's also straightforward to create mocks without a framework.

Here are some techniques.

## Make a function return a specific value

The `weather.isStormy()` function uses a random number generator to decide whether to return `true` or `false`.  The test wants to check that a plane can land when the weather is not stormy.  However, the `weather.isStormy()` function will sometimes return `true`, making the test fail.  To solve this problem, the test replaces the `weather.isStormy()` function with a function that always returns `false`.

```js
// weather.js (an excerpt of the full file)

Weather.prototype.isStormy = function() {
  return Math.random() < 0.5;
};

// plane.js code not shown

// airport.js code not shown

// airport-tests.js

function testCanLandPlaneIfWeatherIsNotStormy() {
  var weather = new Weather();

  weather.isStormy = function() {
    return false;
  };

  var plane = new Plane();
  var airport = new Airport(weather);

  airport.land(plane);
};
```

## Use a fake version of an object in a test

When the `land()` function is called on `airport`, one of the things it does is call `land()` on `plane`.  This test is trying to test `airport.land()`, not `plane.land()`. To stop bugs in `plane.land()` affecting this test, the test now has code that uses a `PlaneDouble` in place of a `Plane`.  When the test runs, `planeDouble.land()` gets called (and does nothing, so it can't cause any errors).

```js
// weather.js code not shown

// plane.js code not shown

// airport.js code not shown

// airport-tests.js

function testCanLandPlaneIfWeatherIsNotStormy() {
  function PlaneDouble() {};

  PlaneDouble.prototype = {
    land: function() {}
  };

  var weather = new Weather();

  weather.isStormy = function() {
    return false;
  };

  var planeDouble = new PlaneDouble();
  var airport = new Airport(weather);

  airport.land(planeDouble);
};
```

## Check that a function got called

It's good that the previous version of the test isolates itself from the details of the `plane.land()` function.  But the test does want to check that `airport.land()` calls `plane.land()`.  The test now augments `PlaneDouble` so it records the number of times `planeDouble.land()` gets called.  It checks the value is `1`.

```js
// airport-tests.js

function testCanLandPlaneIfWeatherIsNotStormy() {
  function PlaneDouble() {
    this.landCallCount = 0;
  };

  PlaneDouble.prototype = {
    land: function() {
      this.landCallCount++;
    }
  };

  var weather = new Weather();

  weather.isStormy = function() {
    return false;
  };

  var planeDouble = new PlaneDouble();
  var airport = new Airport(weather);

  airport.land(planeDouble);

  if (planeDouble.landCallCount !== 1) {
    throw new Error("plane.land() should have been called once");
  }
};
```
