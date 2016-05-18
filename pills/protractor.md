# Protractor

Protractor is an end to end testing (feature-testing) framework for Angular.

The documentation is not always the clearest, so this pill aims to act as a cheatsheet for common things you may want to do with Protractor.

## Installing Protractor

### Prerequisites

#### :pill: [Install node](node.md)

#### :pill: [Install npm](npm.md)

### Initialising your project to use npm

    $ npm init

All the defaults are fine.

### http-server

[http-server](https://www.npmjs.com/package/http-server) serves static files (eg HTML, CSS and JavaScript) from a directory at a local URL (eg `http://localhost:8080`).

It's replacement for running your web app by opening the `index.html` file in a web browser.  Serving the web app files using `http-server` means they are available at a URL that can be accessed by Protractor.

### Installing http-server

    $ npm install http-server --save

`--save` adds `http-server` to your project's dependencies.  This lets people who download your project easily install the necessary dependencies and get the project running.

### Setting up a node script alias to http-server

Edit the `package.json` file in the root of your project.  Add an npm script alias for `start` that will run `http-server`:

```json
{
  "scripts": {
    // ...

    "start": "cd app && ../node_modules/http-server/bin/http-server"

    // ...
  },
}
```

This alias assumes that your web app code is in a folder called `app`.

### Running http-server

    $ npm run start

### Checking that your app is available

Go to `http://localhost:8080` in your browser.  You should see your Angular app.

#### Installing Java Development Kit

[Install the JDK](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

Check it's installed by typing

    $ java -version

You should see a version number.

### Installing Protractor from npm

    $ npm install protractor --save

### Selenium

A program that gets commands like "click this button" from your tests and passes them onto your browser.

### Browser driver library

A library that lets your web browser understand the commands that Selenium sends.  There's one library for Chrome, one for Safari...

### webdriver-manager

The Protractor installation includes a program called `webdriver-manager`.  This program lets you install Selenium and a browser driver library.  It also lets you start the Selenium server.

### Setting up a node script alias to webdriver-manager

Edit the `package.json` file in the root of your project.  Add an npm script alias for `webdriver-manager`:

    "webdriver-manager": "./node_modules/protractor/bin/webdriver-manager"

### Installing Selenium and the Chrome browser driver

In a new terminal tab:

    $ npm run webdriver-manager update

### Starting the Selenium server

    $ npm run webdriver-manager start

You can check the Selenium server is running by going to `http://localhost:4444/wd/hub`.  This URL will also show you what's going on inside the server.

### Creating the Protractor config file

Create a `test` directory in the root of your project.  This will hold the Protractor config file and also your tests.

    $ mkdir test

Create a file at `test/protractor.conf.js` and put this in it:

```javascript
exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['e2e/*.js'],
  baseUrl: 'http://localhost:8080'
}
```

`seleniumAddress` indicates the URL at which the Selenium server can be found.

`specs` lists patterns that match the names of your test files.

`baseUrl` indicates the URL at which you are serving your Angular application.

### Writing a minimal test

Create a directory at `test/e2e`.

    $ mkdir test/e2e

Create a file at `test/e2e/app.spec.js` and put this in it:

```javascript
describe("app", function() {
  it("should get home page title", function() {
    browser.get('/');
    expect(browser.getTitle()).toEqual("YOUR APP TITLE HERE!!!!!!!!!");
  });
});
```

The Angular convention is to put your feature tests in an `e2e` directory.

The `describe` and `it` syntax is from the Jasmine framework. `browser` is a global created by Protractor, which is used for browser-level commands such as navigation with `browser.get`.

### Setting up a node script alias to webdriver-manager

Edit the `package.json` file in the root of your project.  Add an npm script alias for `webdriver-manager`:

    "protractor": "./node_modules/protractor/bin/protractor"

### Running your test

In a new terminal tab:

    $ npm run protractor test/protractor.conf.js

You should see a Chrome browser window open up and navigate to the app, then close itself (this should be very fast!).  You should also see a dot to indicate that the test passed.

If you don't see a dot, when you solve the problem, tell Mary what happened so she can improve this pill.

[Written with the help of Yasmin's [notes on setting up Angular, Karma and Protractor](https://github.com/yasgreen93/setting_up_angular_notes). Thanks, Yasmin!]

## Selecting elements in a web page

The most common selectors are

```js
element(by.css('#some-id')) // For finding one element
element.all(by.css('.some-class')) // For finding multiple elements
```

This is quite verbose, fortunately the two can be shortened to:

```js
$('#some-id') // For finding one element
$$(by.css('.some-class')) // For finding multiple elements
```
> Note $ is not a jQuery command, just a shortcut for `element(by.css('#some-id'))`

### Other selectors

> A lot of these examples are taken from [this blog](http://luxiyalu.com/protractor-locators-selectors/) with the mistakes corrected

```js
$('#some-id')                // element(by.id('#some-id'))
$('.some-class')             // element(by.className('.some-class'))
$('tag-name')               // element(by.tagName('tag-name'))
$('[ng-message=required]')   // remember to leave out the double quotes around the value of attribute
$('#parent #child')          // select one child inside parent
$('input').sendKeys('hello') // input a value in form
$('button').click()          // click a button
$$('ul li')                   // select all children inside parent - note the two $$ symbols, equivalent of `element.all`
$$('ul li').first()           // select first of children
$$('ul li').last()            // select last of children
$$('ul li').get(index)        // select index-th of children
$$('ul li').count()           // count the number of elements
```

## Protractor Commands

> A lot of these examples are taken from [this cheatsheet](https://gist.github.com/javierarques/0c4c817d6c77b0877fda)

```js
browser.get('yoururl'); // Load address, can also use '#yourpage'
browser.navigate().back();
browser.navigate().forward();
browser.sleep(10000); // if your test is outrunning the browser
browser.waitForAngular(); // if your test is outrunning the browser
browser.getLocationAbsUrl() // get the current address
browser.ignoreSynchronization = true; // If true, Protractor will not attempt to synchronize with the page before performing actions
```

Here's a trick how to wait for something to become present/visible:

```javascript

browser.wait(function() {
   return $('#create').isPresent();
}, 5000);

$('create').click();
```

## Further Resources

- [Debugging Protractor](https://github.com/angular/protractor/blob/master/docs/debugging.md)
- [Protractor Docs](https://angular.github.io/protractor/#/)
- [Protractor
  Locators](https://github.com/angular/protractor/blob/master/docs/locators.md)
- [Protractor API Reference](http://angular.github.io/protractor/#/api)
