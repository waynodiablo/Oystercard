#Javascript Acceptance/Integration/Feature Testing

Listen up geeks.

Follow the steps below to get JS project setup for reliable acceptance testing:

###Setup

1. [Download JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

2. Download Selenium Standalone and Install
```
$ npm install -g selenium-standalone@latest
$ selenium-standalone install
```
3. Download and Install webdriverio locally to your project
```
$ npm install webdriverio --save-dev
```
4. Download and Install chai locally to your project
```
$ npm install chai --save-dev
```
5. Download and Install mocha GLOBALLY 
```
$ npm install -g mocha 
```
6. Example Setup

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

1. Run selenium server in a new terminal window
...```
...$ selenium-standalone start
...```
2. Start your node server
```
...nodemon or npm start
```
3. Run your test suite
```
npm test or mocha or grunt
```
4. Bask in the glory of successful javascript testing.

###Resources
[WebdriverIO API Docs](webdriver.io/api.html)

