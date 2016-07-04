# Use Zombie.js to write a functional test that tests that your app's title is displayed on the page

[Back to the Challenge Map](00_challenge_track.md)

The [Document Object Model (DOM)](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction) is the [tree](https://en.wikipedia.org/wiki/Tree_(data_structure)) data structure that a browser uses store the structure of a web page that it is displaying.

[Zombie.js](http://zombie.js.org/) is a test runner that can run your Mocha feature tests against a "virtual DOM".  This makes your feature tests faster and more reliable because they don't have to be run in a real browser.

In this challenge, you'll install Zombie.js and use it to write a small feature test.

### Learning objectives covered

- Install and run Zombie.js.
- Feature test web code.

### To complete this challenge, you will need to:

- [ ] Install Zombie.js from :pill: [npm](../pills/npm.md). (It's called `zombie` on npm, not `zombiejs`.)
- [ ] Write a feature test that checks that the `<title>` attribute of your app is `To Do List`.  Have a look at the :pill: [http-server](../pills/http_server.md) for information on how to allow your feature test to access the running version of your app.
- [ ] Make the test pass.

### Resources

- [Document Object Model (DOM) on MDN](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)
- [Zombie.js](http://zombie.js.org/)
- :pill: [http-server](../pills/http_server.md)
