#A basic Node server

Many thanks to [Spike](http://github.com/spike01) for the original design of this component

**As with all Makers Academy materials, there may be subtle errors in the following materials. Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.**

**There is a very, very condensed version of this walkthrough in the :pill:[JS Acceptance test pill](https://github.com/makersacademy/course/blob/master/pills/js_acceptance_tests.md), for ye of little patience**

So, now that we can write unit tests and automate various tasks, it's time to take Node out on to the web. For this, we will be using the [Express framework](http://expressjs.com/), which has the same lightweight design philosophy as Sinatra. However, as Makers, we'll be wanting to write some tests first.  

##Testing with `webdriverio`

To test, we will need some kind of programmable browser. These fall into two categories: browsers without a visual interface (headless, such as Capybara in Ruby) and with (head..ful? ...in most cases, this will be Selenium). For this walkthrough, we will be using `webdriverio`, which is based on Selenium (much like Protractor) and provides us with the ability to automate page navigation in a real browser.  

We will also be using Mocha (Node's most popular test harness) and Chai (an expectation library).  

> __Why so many different packages?__    
> As stated before, part of the Node philosophy is to have lots of small modules that do one thing well, and that can be easily combined and recombined. In this case, Mocha is a test harness/test runner, meaning that it only provides the ability to run tests, nothing more. Chai only provides expectations, such as "should", "assert" or "expect". You should already have a Selenium standalone server available from the Angular tutorial, but otherwise we can use a different package to acheive the same result: selenium-standalone. Webdriver, as stated above, simply provides more user-friendly bindings to write your tests with.

First of all: set up a new project with `npm init` (or adapt an exisiting one). Get Grunt set up with as much or little configuration as wanted - JSHint and watch are definitely recommended to speed up development. Then, we will need to install quite a few packages:

```shell
npm install --save-dev mocha
npm install --save-dev chai
npm install --save-dev selenium-standalone 
npm install --save-dev webdriverio
```

Make sure you follow all the instructions for [selenium-standalone](https://www.npmjs.com/package/selenium-standalone) if for some reason you don't have the JDK installed yet. Have a Selenium server running somewhere in the background.

And finally, for Grunt:

```shell
npm install --save-dev grunt-webdriver
```

Configure your Gruntfile (the code below omits any other tasks you may have set up, make sure your syntax is valid when adding the `grunt-webdriver` task.

`Gruntfile.js`
```javascript
module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    webdriver: {
      test: {
        configFile: './test/wdio.conf.js'
      }
    }
  })

  grunt.loadNpmTasks('grunt-webdriver');

  grunt.registerTask('default', ['webdriver']);
};
```

Make a `test` directory and create the config file with `wdio config` [docs](http://webdriver.io/guide/testrunner/gettingstarted.html).

Add a `homepageFeature.js` file to the `test` directory. Let's write the first failing test:

`homepageFeature.js`
```javascript
var chai = require('chai');
var expect = chai.expect;

describe('homepage', function () {

  it('hello worlds', function(done) {
    browser
      .url('http://localhost:3000')
      .getText('body', function(err, text) {
        expect(text).to.equal('Hello world')
      })
      .call(done);
    });

});
```

Run your tests with `grunt`.

We get an error, which should be expected as we don't have a server:

```shell
Uncaught AssertionError: expected 'This webpage is not available\nERR_CONNECTION_REFUSED\nReload\nDetails' to equal 'Hello world'
```

> __"Wait a second, where do you `require('webdriverio)`?"__  
> Good point. One thing that hasn't been mentioned is that `grunt-webdriver` contains quite a bit of magic, which is great for moving quickly, but maybe not for understanding. If we were to write these tests without the Grunt task, we would have to require and configure Webdriver manually in our test file - check the `webdriverio` documentation to see how to do this

At this stage, this test will be red for a little while, as we will need to set up Express. 

##Express

Can you guess how we install Express?

```shell
npm install --save express
```

Make a new `server.js` file and add the following:

`server.js`
```javascript
var express = require('express');
var app = express();
var server = require('http').createServer(app);

server.listen(3000, function(){
  console.log("Server listening on port 3000");
});

module.exports = server;
```

Check that everything is "working" (in other words, giving an expected error) by running `npm start` and pointing your browser at [http://localhost:3000](http://localhost:3000) - You should see something the lines of "Cannot GET /", which means that Express is up and running.

At this point, start a new Terminal/iTerm window - your server doesn't start automagically, so you will have to manually run it in the background to run tests (or maybe find a way to use Grunt...?) 

The test should still fail as we aren't sending anything to the browser - let's fix that:

`server.js`
```javascript
var express = require('express');
var app = express();
var server = require('http').createServer(app);

app.get('/', function(request, response){
  response.send("Hello world")
});

server.listen(3000, function(){
  console.log("Server listening on port 3000");
});

module.exports = server;
```

Restart your server and run your test - it should go green!

##Tasks

* Try the above as an athletic workout - there are effectively two workouts here - one for Webdriver and one for express - you can cross train between them! :-)
* Try experimenting with different routes with Express - you'll notice it's a lot like Sinatra in many ways
* See what happens if you replace `response.send` with `response.json` - can you see what this would be very useful for?
* Write more tests and see if you can pass them! The documentation for Webdriver is [here](http://www.webdriver.io/guide.html)
* If you want to see some examples of other testing frameworks, check out [Leo's node-mocha example](https://github.com/pitchinvasion/node-mocha) and Tony's [express-cucumber example](https://github.com/antonydenyer/express-cucumber). Remember to run `npm install` if you clone them to install dependencies. Leo's tests run with `npm test`, and Tony's with `make cucumber`.
* Go to [the npm site](https://www.npmjs.com/browse/depended) and explore the packages there.
* Have a look at how to use `response.render` - if you have any problems, don't worry, everything will be explained in the next walkthrough


###Resources
* [Mocha](http://mochajs.org/)  
* [Chai](http://chaijs.com/)  
* [Selenium](http://www.seleniumhq.org/)
* [Webdriver](https://github.com/webdriverio/webdriverio)
* [grunt-webdriver](https://github.com/webdriverio/grunt-webdriver)
* [Video of Spike on Node Servers](https://www.youtube.com/watch?v=h5qyuyYIwt8) (slightly out of date, now that we use Selenium)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/node/basic_node_server.md)
