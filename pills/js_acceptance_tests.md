#Javascript Acceptance/Integration/Feature Testing

Listen up geeks. The tutorial below assumes you have done the pill on a
[Basic Node Server](https://github.com/makersacademy/course/blob/master/node/basic_node_server.md).

Follow the steps below to get JS project setup for reliable acceptance testing:

###Setup

- [Download JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

- Download Selenium Standalone and Install
```sh
$ npm install -g selenium-standalone@latest
$ selenium-standalone install
```
- Download and Install webdriverio locally to your project
```sh
$ npm install webdriverio --save-dev
```
- Download and Install chai locally to your project
```sh
$ npm install chai --save-dev
```
- Download and Install mocha GLOBALLY 
```sh
$ npm install -g mocha 
```
- Example Setup
`./specs/features/homepageFeature.js`

```javascript
var webdriverio = require('webdriverio');
var expect = require('chai').expect;

describe('Homepage Tests', function() {

  var client = {};

  before(function(done) {
    client = webdriverio.remote({ desiredCapabilities: {browserName: 'chrome'}   });
    client.init(done);
  });
 
  after(function(done) {
    client.end(done);
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

- Run selenium server in a new terminal window
```
$ selenium-standalone start
```
- Start your node server
```sh
$ nodemon 
```
or
```sh
$ npm start
```
- Run your test suite
```sh
$ npm test
```
or
```sh
$ mocha
```
or
```sh
$ grunt
```
- Bask in the glory of successful javascript testing.

###Resources
[WebdriverIO API Docs](http://www.webdriver.io/api.html)

