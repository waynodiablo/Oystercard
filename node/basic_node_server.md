#A basic Node server

Many thanks to [Spike](http://github.com/Spike01) for the original design this component

**As with all Makers Academy materials, there may be subtle errors in the following materials. Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.**

So, now that we can write unit tests and automate various tasks, it's time to take Node out on to the web. For this, we will be using the [Express framework](http://expressjs.com/), which has the same lightweight design philosophy as Sinatra. However, as Makers, we'll be wanting to write some tests first.  

##Testing with `mocha-casperjs`

To test, we will need some kind of programmable browser. These fall into two categories: browsers without a visual interface (headless, such as Capybara in Ruby) and with (head..ful? ...in most cases, this will be Selenium). For this walkthrough, we will be using CasperJS, which is based on PhantomJS and provides us with Capybara-like syntax.  

We will also be using Mocha (Node's most popular test harness), Chai (an expectation library), and some packages that tie all of these elements nicely together (`mocha-casperjs` and `chai-casper`).  

> __Why so many different packages?__    
> As stated before, part of the Node philosophy is to have lots of small modules that do one thing well, and can be easily combined and recombined. In this case, Mocha is described as a test harness/test runner, meaning that it only provides the ability to run tests, nothing more. Chai only provides expectations, such as "should", "assert" or "expect", `casper-chai` provides a nice set of matchers and `mocha-casperjs` runs everything together. Oh, and we can also use `grunt-mocha-casperjs` to run everything with Grunt!

First of all: set up a new project with `npm init` (or adapt an exisiting one). Get Grunt set up with as much or little configuration as wanted - JSHint and watch are definitely recommended to speed up development. Then, we will need to install quite a few packages:

```shell
npm install --save-dev mocha
npm install --save-dev chai
npm install --save-dev phantomjs
npm install --save-dev casperjs
npm install --save-dev mocha-casperjs
npm install --save-dev casper-chai
```

You will need to install phantomjs globally as well:

```shell
npm install -g phantomjs
```

And finally, if using Grunt:

```shell
npm install --save-dev grunt-mocha-casperjs
```

Configure your Gruntfile (the code below omits any other tasks you may have set up, make sure your syntax is valid when adding the `mocha_casperjs` task.

`Gruntfile.js`
```javascript
module.exports = function(grunt) {

 grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    mocha_casperjs: {
      options: {
      },
      files: {
        src: ['test/**/*']
      }
    }
  })
  grunt.loadNpmTasks('grunt-mocha-casperjs');

  grunt.registerTask('default', ['mocha_casperjs']);
};
```

Time to run a test. This should give the following error message, which should be expected:

```shell
No tests specified. List them in the console, or add your tests to a "test" or "tests" folder in the current working directory.
```

>If you see some crazy error messages about 'Unsafe JavaScript' and '255/252 tests failing', don't worry! JavaScript is unsafe, and mocha-casperjs is freaking out because it hasn't found any tests to run.

Awesome. Make a `test` directory, and a `homepage_features.js` file. Let's write the first test:

`homepage_features.js`
```javascript
describe('homepage', function(){
  before(function(){
    casper.start('http://localhost:3000/');
  });

  it('hello worlds', function(){
    casper.then(function(){
      expect("body").to.have.text("Hello world");
    });
  });

});
```

Next error, which should be expected as we don't have a server:

```shell
1) homepage hello worlds:
     AssertionError: expected 'body' to be Hello world, but it was ""
```

> __"Wait a second, where are all the `require` statements?"__  
> Good point. One thing that hasn't been mentioned is that `mocha-casperjs` contains quite a bit of magic, which is great for moving quickly and writing nice tests. If you want to see some examples of other testing frameworks, check out [Leo's node-mocha example](https://github.com/pitchinvasion/node-mocha) and Tony's [express-cucumber example](https://github.com/antonydenyer/express-cucumber). Remember to run `npm install` if you clone them to install dependencies. Leo's tests run with `npm test`, and Tony's with `make cucumber`.

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

At this point, start a new Terminal/iTerm window - `mocha-casperjs` doesn't start your server automagically, so you will have to manually run it in the background to run tests (or maybe use Grunt...?) 

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

* Try the above as an athletic workout - there are effectively two workouts here - one for casper and one for express - you can cross train between them! :-)
* Try experimenting with different routes with Express - you'll notice it's a lot like Sinatra in many ways
* See what happens if you replace `response.send` with `response.json` - can you see what this would be very useful for?
* Write more tests and see if you can pass them! `casper-chai` has a [great page](https://github.com/brianmhunt/casper-chai/blob/master/docs/casper-chai.md) on the kind of matcher statements it supports - note that anything structured as `*.should.have.*` can be rewritten as `expect(*).to.*`
* If you're feeling really bold, go back to [Leo's node-mocha example](https://github.com/pitchinvasion/node-mocha) and try to figure out why Zombie is unreliable and difficult to test with  
* Go to [the npm site](https://www.npmjs.com/browse/depended) and explore the packages there.
* Have a look at how to use `response.render` - if you have any problems, don't worry, everything will be explained in the next walkthrough


###Resources
* [Mocha](http://mochajs.org/)  
* [Chai](http://chaijs.com/)  
* [PhantomJS](http://phantomjs.org/)  
* [CasperJS](http://casperjs.org/)  
* [mocha-casperjs](https://github.com/nathanboktae/mocha-casperjs)  
* [casper-chai](https://github.com/brianmhunt/casper-chai)  
* [grunt-mocha-casper](https://github.com/roman01la/grunt-mocha-casperjs)
* [Video of Spike on Node Servers](https://www.youtube.com/watch?v=h5qyuyYIwt8)

