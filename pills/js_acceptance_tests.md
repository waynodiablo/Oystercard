#Javascript Acceptance/Integration/Feature Testing

Listen up geeks. The tutorial below assumes you have done the pill on a
[Basic Node Server](https://github.com/makersacademy/course/blob/master/node/basic_node_server.md).

Follow the steps below to get JS project setup for reliable acceptance testing:

###Setup

#####1. [Download JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

#####2. Download Selenium Standalone and Install
```sh
$ npm install -g selenium-standalone@latest
$ selenium-standalone install
```
#####3. Download and Install webdriverio locally to your project
```sh
$ npm install webdriverio --save-dev
```
#####4. Download and Install chai locally to your project
```sh
$ npm install chai --save-dev
```
#####5. Download and Install mocha GLOBALLY 
```sh
$ npm install -g mocha 
```
#####6. Download and Install mocha locally, so that it's in your `package.json` and future devs won't scratch their heads wondering why no tests are running 
```sh
$ npm install --save-dev mocha 
```
#####7. Example Setup
`./views/index.html`

```html
<!DOCTYPE html>
<html lang="en">

  <title>Example Title</title>
  
<body>  

  <h1>Hello Makers</h1>
  
</body>

</html>
```

`./specs/features/homepageFeature.js`

```javascript
var webdriverio = require('webdriverio');
var expect = require('chai').expect;

describe('Homepage Tests', function() {

  var client = {};

  before(function(done) {
    client = webdriverio.remote({ desiredCapabilities: {browserName: 'chrome'}   });
    client.init().then(function() {
      done();
    });
  });
 
  after(function(done) {
    client.end().then(function() {
      done();
    });
  });

  it('Homepage Title Displays',function(done) {
    client
      .url('http://localhost:3000')
      .getTitle(function(err, title) {
        expect(err).to.not.be.true;
        expect(title).to.eql('Example Title');
      }) 
      .call(done);
  });
   
});
 
```

###Testing

#####1. Run selenium server in a new terminal window
```
$ selenium-standalone start
```
#####2. Start your node server
```sh
$ nodemon 
```
or
```sh
$ npm start
```
#####3. Run your test suite (assuming your `package.json` is set up correctly)
```sh
$ npm test
```
or 
```sh
$ mocha
```
(don't forget to set up `--recursive` in `mocha.opts` so that it can find your nested feature tests)
or
```sh
$ grunt
```
#####4. Bask in the glory of successful javascript testing.

###Resources
[WebdriverIO API Docs](http://www.webdriver.io/api.html)



![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/js_acceptance_tests.md)
