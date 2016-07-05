# Use Mocha to unit test and write a model for a to do

[Back to the Challenge Map](00_challenge_track.md)

Mocha is very similar to Jasmine, but more modular.  You'll use it to write tests for a model that implements a to do.

Normally, you've built systems outside in: writing a feature test, writing unit tests to match the unit test failure, writing code to pass the unit tests and finally the feature test.  You'll build this app inside out.  This means writing tests for low level units first, writing code to pass the tests, and building up towards feature tests.  It can be tricky to build feature tests for the web, because many layers of code (JS, CSS, HTML, the Document Object Model) need to be integrated. Building inside out will let you build on a solid foundation towards these feature tests.

### Learning objectives covered

- Install Mocha, Chai and Sinon.
- Write a test with Mocha.
- Use the constructor and prototype pattern to implement a model for a to do.

### To complete this challenge, you will need to:

- [ ] Install :pill: [node](../pills/node.md).
- [ ] Install Mocha from :pill: [npm](../pills/npm.md).
- [ ] Install the Chai assertion library from :pill: [npm](../pills/npm.md).
- [ ] Install the Sinon mocking library from :pill: [npm](../pills/npm.md).
- [ ] Write tests that check you can instantiate a to do JavaScript object.  Write tests that check that a to do object can store and retrieve a `task` string like `Eat breakfast` and a `complete` boolean.
- [ ] Implement a to do model as a JavaScript object.  Make your tests pass.

### Resources

- :pill: [node](../pills/node.md)
- :pill: [npm](../pills/npm.md)
- [Mocha website](https://mochajs.org/)
- [Chai website](http://chaijs.com/)
- [Sinon website](http://sinonjs.org/)
- [Constructor and prototype pattern workshop](https://github.com/maryrosecook/constructor-and-prototype-pattern-workshop)
