# Protractor for GitHub Profiles

## What is Protractor?

From the [official Protractor website](http://angular.github.io/protractor/#/) (yes, go read it... all of it.):

>"Protractor is an end-to-end test framework for AngularJS applications. Protractor runs tests against your application running in a real browser, interacting with it as a user would."

At a slightly more detailed level, Protractor provides a set of Angular-specific bindings for Selenium ([what is Selenium?](http://www.seleniumhq.org/)), as well as a specially integrated test runner, so that you don't throw your computer out of the window trying to set up normal Selenium tests for your Angular app.

## This is awesome. Why didn't we start by writing feature tests with Protractor?

Protractor is a bit different from other testing frameworks: it's built by the Angular team specifically for testing Angular apps. In other words, to get the most out of Protractor, you already need to understand a bit of Angular.

But now you know some Angular. So it's time to write some tests.

## Testing with Protractor

This tutorial is a very slightly modified version of the [official Protractor tutorial](http://angular.github.io/protractor/#/tutorial). It also assumes that you have built the [GitHub profiles app from the Angular tutorial](https://github.com/makersacademy/course/blob/master/further_javascript/angularjs.md). If you are feeling brave, feel free to close this tutorial and attempt to write some tests based on the original documentation. Else, continue.

Prerequisites
-------------

Protractor is a [Node.js](http://nodejs.org/) program. To run, you will need to have Node.js installed. You will download Protractor package using [npm](https://www.npmjs.org/), which comes with Node.js. Check the version of Node.js you have by running `node --version`. It should be greater than v0.10.0.

By default, Protractor uses the [Jasmine](http://jasmine.github.io/1.3/introduction.html) test framework for its testing interface. This tutorial assumes some familiarity with Jasmine.

This tutorial will set up a test using a local standalone Selenium Server to control browsers. You will need to have the [Java Development Kit (JDK)](http://www.oracle.com/technetwork/java/javase/downloads/index.html) installed to run the standalone Selenium Server. Check this by running `java -version` from the command line.

Setup
-----

Use npm to install Protractor globally with:

    npm install -g protractor

This will install two command line tools, `protractor` and `webdriver-manager`. Try running `protractor --version` to make sure it's working.

The `webdriver-manager` is a helper tool to easily get an instance of a Selenium Server running. Use it to download the necessary binaries with:

    webdriver-manager update

Now start up a server with:

    webdriver-manager start

This will start up a Selenium Server and will output a bunch of info logs. Your Protractor test will send requests to this server to control a local browser. Leave this server running throughout the tutorial. You can see information about the status of the server at `http://localhost:4444/wd/hub`.

Also, don't forget to `npm install --save-dev protractor` within your project - this will add it to the list of development dependencies. We will cover this in further detail later in the course if you are interested in why we do this.

Step 0 - write a test
---------------------

Protractor needs two files to run, a **spec file** and a **configuration file**.

We have existing unit tests, so it would make sense to make a separate directory for your feature tests. The usual Angular convention is to name your feature folder `e2e`, so create that within your test folder.

Let's start with a simple test that navigates to your GitHub profile app and checks the title of the page.

Type the following into `test/e2e/githubProfileFeature.js`:

```javascript
describe('Github Profile finder', function() {
  it('has a title', function() {
    browser.get('http://localhost:8080');

    expect(browser.getTitle()).toEqual('Github user search');
  });
});
```

The `describe` and `it` syntax is from the Jasmine framework. `browser` is a global created by Protractor, which is used for browser-level commands such as navigation with `browser.get`.

Now create the configuration file. Copy the following into `test/e2e/conf.js`:

```js
exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['githubProfileFeature.js']
}
```

This configuration tells Protractor where your test files (`specs`) are, and where to talk to your Selenium Server (`seleniumAddress`). It will use the defaults for all other configuration. Chrome is the default browser.

Now run the test with

    protractor test/e2e/config.js

You should see a Chrome browser window open up and navigate to the app, then close itself (this should be very fast!).

But, in fact, you won't. You should have one of two failures, depending on how closely you've been following the instructions.

* 1) `ERROR - Unable to start a WebDriver session.`

This is because you didn't leave WebDriver running in the background. Restart it with `webdriver-manager start`

* 2) The window pops up, but says "This webpage is not available"

This is because your app is not being served anywhere (especially not at the http://localhost:8080 address you specified in your test!). This is easily fixed - you can:

* create a Node server to host your app (difficulty: hard - at this stage)
* strap it to a Sinatra server (difficulty: medium)
* `npm install --save http-server`, then run `http-server` (difficulty: you just did it!)


Run your tests again. The test output should be `1 tests, 1 assertion, 0 failures`. Congratulations, you've run your first Protractor test!

Step 1 - interacting with elements
----------------------------------

Now let's modify the test to interact with elements on the page. Change the spec to the following:

```js
describe('GitHub profile finder', function() {
  it('finds profiles', function() {
    browser.get('http://localhost:8080');

    element(by.model('searchTerm')).sendKeys('spike01');
    element(by.className('btn')).click();

    expect(element(by.binding('user.login')).getText()).
        toEqual('spike0');
  });
});
```
This uses the globals `element` and `by`, which are also created by Protractor. The `element` function is used for finding HTML elements on your webpage. It returns an ElementFinder object, which can be used to interact with the element or get information from it. In this test, we use `sendKeys` to type into `<input>`, `click` to click a button, and `getText` to return the content of an element.

`element` takes one parameter, a Locator, which describes how to find the element. The `by` object creates Locators. Here, we're using three types of Locators:

  - `by.model('searchTerm')` to find the element with `ng-model="searchTerm"`. If you recall from building your app, you will see this is `<input type=text ng-model="searchTerm">`.
  - `by.class('btn')` to find the element with the given class. This finds `<button class="btn">`.
  - `by.binding('user.login')` to find the element bound to the variable `user.login`. This finds the element containing `{{user.login}}`

  [Learn more about locators and ElementFinders](/docs/locators.md).

Run the tests with

    protractor test/e2e/config.js

You should see the test fail - figure out why and fix it. Also, take a moment to think about why you should always see a test fail first before making it pass, both when doing TDD and covering a legacy app with tests (and yes, we haven't been totally  strict about this due to trying to rush you through new material!)

Step 2 - writing multiple scenarios
-----------------------------------

Let's put these two tests together and clean them up a bit. Change your spec to the following:

```js
describe('GitHub profile finder', function() {

  var searchBox = element(by.model('searchTerm'))
  var searchButton = element(by.className('btn'))

  beforeEach(function() {
    browser.get('http://localhost:8080');
  })

  it('has a title', function() {
    expect(browser.getTitle()).toEqual('Github user search');
  });

  it('finds profiles', function() {
    //Complete this test using the variables above!
    expect(element(by.binding('user.login')).getText()).toEqual('spike01');
  });

});
```

Here, we've pulled the navigation out into a `beforeEach` function which is run before every `it` block. We've also stored the ElementFinders in nice variables that can be reused. Fill out the second test using those variables, and run the tests again to ensure they pass.

Step 3 - changing the configuration
-----------------------------------

>**You may want to skip this step if you do not have Firefox installed. Or, you may use this as an opportunity to install Firefox, as you should really be checking that your apps work across multiple browsers. Especially old versions of Internet Explorer.**

Now that we've written some basic tests, let's take a look at the configuration file. The configuration file lets you change things like which browsers are used and how to connect to the Selenium Server. Let's change the browser. Change conf.js to the following:

```js
exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['githubProfileFeature.js'],
  capabilities: {
    browserName: 'firefox'
  }
}
```

Try running the tests again. You should see the tests running on Firefox instead of Chrome. The `capabilities` object describes the browser to be tested against. For a full list of options, see [the reference config file](https://github.com/angular/protractor/blob/master/docs/referenceConf.js).

You can also run tests on more than one browser at once. Change conf.js to:

```js
exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['githubProfileFeature.js'],
  multiCapabilities: [{
    browserName: 'firefox'
  }, {
    browserName: 'chrome'
  }]
}
```

Try running once again. You should see the tests running on Chrome and Firefox simultaneously, and the results reported separately on the command line.

Step 4 - lists of elements
--------------------------

Let's go back to the test files. Feel free to change the configuration back to using only one browser.

Sometimes, you will want to deal with a list of multiple elements. You can do this with `element.all`, which returns an ElementArrayFinder. In our application, the results from GitHub are iterated over with `ng-repeat`. Let's make a search and try to find a specific item in the list. Change the second test to:

```js
it('finds profiles', function() {

  searchBox.sendKeys('spike');
  searchButton.click();

  var profiles = element.all(by.repeater('user in searchResult.items'));
  expect(profiles.get(0).getText()).toEqual('spike01'); //This won't pass!
});
```

We use `element.all` with the `by.repeater` Locator to get an ElementArrayFinder. In our spec, we assert that the search has found the correct user using the `get(0)` method. Fix the test so that the expectation passes.

`ElementArrayFinder` has many methods in addition to `get`. Let's use `last` to get an ElementFinder that matches the last element found by the Locator. Change the test to:
```js
  it('finds the last Spike', function() { //this is a silly test, but roll with it
    searchBox.sendKeys('spike');
    searchButton.click();

    var profiles = element.all(by.repeater('user in searchResult.items'));
    expect(profiles.last().getText()).toEqual('spike01'); //This is, again, wrong.
  });
```

Fix the test so that it correctly expects the last user, then try to count how many Spikes (or other name) your app can find

ElementArrayFinder also has methods `each`, `map`, `filter`, and `reduce` which are analogous to JavaScript Array methods. [Read the API for more details](http://angular.github.io/protractor/#/api?view=ElementArrayFinder).

Where to go next
----------------

* This should get you started writing tests. To learn more, see the documentation: [Table of Contents](http://angular.github.io/protractor/#/toc).
* Discuss the different approaches taken by Capybara and Protractor (assuming you are [using Capybara properly](http://www.elabs.se/blog/51-simple-tricks-to-clean-up-your-capybara-tests)) - are they mutually exclusive? Do you think one works better than the other?
* Hmm, these test seem awful coupled to the GitHub API. What if you didn't want to hit the API every time you run your tests? What if the results from the API change? What if you only had arms the same length as a T-Rex (typing would be hard)?
* BDD ALL THE THINGS with your newfound Protractor skillz. Aww yeah.
