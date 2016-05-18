# Walkthrough - Setting up and running protractor

[Back to the Challenge](../09_protractor.md)

## Setting up your app

Create an index page at `app/index.html` and put in the code below:

```html
<!doctype html>
<html lang="en" ng-app="toDoApp">
  <head>
    <meta charset="utf-8">
    <script src="bower_components/angular/angular.js"></script>
    <script src="js/app.js"></script>
    <title>Todos App</title>
  </head>
  <body>
    <p>Hello world<p>
  </body>
</html>
```

Create an `app/js` directory.

Create an app file at `app/js/app.js` and put in the code below:

```javascript
var toDoApp = angular.module('toDoApp', []);
```

## Setting up Protractor

Follow the instructions in :pill: [Protractor](../pills/protractor.md) up to and including the "Running your test" section.

## Adding a test that checks for "Hello world"

Add this code to the file at `test/e2e/app.spec.js':

```javascript
describe("app", function() {
  it("should say 'Hello world' on the page", function() {
    browser.get('/');
    expect($$("p").first().getText()).toEqual("Hello world");
  });
});
```

## Running your new test

Run the tests with:

    $ npm run protractor test/protractor.conf.js

You should see all dots to indicate that your tests have passed!

[Forward to the Challenge Map](../00_challenge_map.md)
