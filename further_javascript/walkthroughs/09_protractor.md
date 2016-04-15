# Walkthrough - Setting up and running protractor

[Back to the Challenge](../09_protractor.md)

Before starting, ensure you have the [Java Development Kit (JDK)](http://www.oracle.com/technetwork/java/javase/downloads/index.html) installed - this is used to run the Selenium server protractor uses. Check this by running `java -version` from the command line.

## Setup

Use npm to install Protractor globally with:

    npm install -g protractor

This will install two command line tools, `protractor` and `webdriver-manager`. Try running `protractor --version` to make sure it's working.

The `webdriver-manager` is a helper tool to easily get an instance of a Selenium Server running. Use it to download the necessary binaries with:

    webdriver-manager update

Now start up a server with:

    webdriver-manager start

This will start up a Selenium Server and will output a bunch of info logs. Your Protractor test will send requests to this server to control a local browser. Leave this server running throughout the tutorial. You can see information about the status of the server at `http://localhost:4444/wd/hub`.

Also, don't forget to `npm install --save-dev protractor` within your project - this will add it to the list of development dependencies, similar to what we did when installing bower, ensuring that others who use this project know that protractor is required

## Configuration

Now create the protractor configuration file. Create a `test` folder and copy the following into `test/protractor-conf.js`:

```js
exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['e2e/*.js']
}
```

This configuration tells Protractor where your test files (`specs`) are, and where to talk to your Selenium Server (`seleniumAddress`). It will use the defaults for all other configuration. Chrome is the default browser.

## Writing a test

With our configuration setup, we're ready to write our first test. The usual Angular convention is to name your feature folder `e2e`, so create that within your test folder, then type the following into type the following into `test/e2e/todoFeatures.js`:

```javascript
describe('Todos tracker', function() {
  it('has a title', function() {
    browser.get('http://localhost:8080');
    expect(browser.getTitle()).toEqual('Todos App');
  });
});
```

The `describe` and `it` syntax is from the Jasmine framework. `browser` is a global created by Protractor, which is used for browser-level commands such as navigation with `browser.get`.

Now run the test with

    protractor test/protractor-conf.js

You should see a Chrome browser window open up and navigate to the app, then close itself (this should be very fast!).

But, in fact, you won't. You should have one of two failures, depending on how closely you've been following the instructions.

* 1) `Error: ECONNREFUSED connect ECONNREFUSED 127.0.0.1:4444`

This is because you didn't leave WebDriver running in the background. Restart it with `webdriver-manager start`

* 2) The window pops up, but says "This webpage is not available"

This is because your app is not being served anywhere (especially not at the http://localhost:8080 address you specified in your test!). This is easily fixed, by installing http-server, by running the commands `npm install --save http-server`, `npm install http-server -g`.

Now go into your app directory and run `http-server`, and then re-run your tests. You should see a new failure.

## Passing the test

All being well you should have an error along the lines of

```
    Failed: Angular could not be found on the page http://localhost:8080/ :
retries looking for angular exceeded

```
with the browser just showing a list of the directories in your app directory.

You need to create an `index.html` page, and load in `angular.js` which
Protractor needs before it can do anything else. Copy into `app/index.html`

```html
<!doctype html>
<html lang="en" ng-app>
  <head>
    <meta charset="utf-8">
    <script src="bower_components/angular/angular.js"></script>
    <title>Todos App</title>
  </head>
  <body>
    <p>Hello world<p>
  </body>
</html>
```

Now rerun your tests. They should be passing finally!

[Forward to the Challenge Map](../00_challenge_map.md)
