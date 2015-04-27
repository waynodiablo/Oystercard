## Starting a new Node project

* Beginners just want to quickly start a new project
* First: Install Node.  I recommend installing it from the website instead of a version manager to keep things simple for beginners
* Next: Create a new directory, then run npm init

```shell
$ mkdir ma-example
$ cd ma-example
$ npm init
```

## Installing modules for the new project

* Prefer installing modules locally rather than globally
* Use --save and --save-dev
* Idiom: Don't check ./node_modules into git for projects you deploy
* Idiom: Lock down dependencies for production with npm shrinkwrap
  * It'll walk through all dependencies and sub-dependencies to include the specific versions that you're using

## Installing modules into your project:

```shell
$ npm install --save express
$ npm install --save-dev mocha supertest
```

## A sample Express project

```javascript
var express = require('express');
var app = express();

app.set('port', process.env.PORT || 3000);

app.get('/', function(req, res) {
  res.send('Hello');
});

app.listen(app.get('port'), function() {
  console.log('Listening on:', app.get('port'));
});

module.exports = app;
```

* Idiom: Edit package.json and add "start": "node index.js" to "scripts". Lots of tools and services are set up to start Node applications with "npm start".

## A sample test

```javascript
var app = require('./../');
var assert = require('assert');
var request = require('supertest');                //1

describe('Sample app', function() {
  it('should serve Hello', function(done) {
    request(app)
      .get('/')
      .expect(200)                                 //2
      .end(function(err, res) {
        if (err) done(err);
        assert.equal(res.text, 'Hello');           //3
        done();
      });
    });
});
```

1. The SuperTest module makes it easier to script requests for tests. Our app server and request will run in the same process
2. SuperTest lets you set up expectations for easy testing
3. You can look at the response body to make sure the text/JSON/etc. is what you expect the application to generate

To run this test you need to invoke it with the mocha runner:

```shell
./node_modules/mocha/bin/mocha
```

I usually put this in package.json under the "scripts", "test" property so I can just type "npm test".

## Modern Node application layout

Key dependencies:

* Server: express, mongoose, bcrypt, request, nodemailer
* Client: browserify, gulp, nodemon, sass, easy-livereload, uglify
* Test: mocha, zombie/nightwatch

Structure:

* **Client:** CommonJS modules compiled with Grunt/Browserify/uglify
  * client/viewmodels/
  * client/router.js
  * client/init.js
  * node_modules/* -- Use npm for client-side packages
* **Assets:**
  * public/app.js -- where the files in client/ end up
  * public/libs.js -- I have a separate build task that generates optimised builds for client-side JavaScript and CSS
* **Node:**
  * views/ -- Jade views, but you could also put React view models in here and share them between the client and the server
  * models/ -- "thin" database models
  * services/ -- services sit between the models and REST API
  * routes/ -- route handler, where your REST API is implemented
  * middleware/ -- use lots of middleware
  * index.js -- define the routes, load express stuff
