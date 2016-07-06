# Use Ajax to request some to dos stored on a remote server, then display them

[Back to the Challenge Map](00_challenge_track.md)

In this challenge, you'll change your app to download some to dos from an API via Ajax.  You'll initialise your app with these to dos.

### Learning objectives covered

- Use Ajax to request data from an external API.
- Use a callback to take the data in an Ajax response and use it to update some application data.

### To complete this challenge, you will need to:

- [ ] Play around to make a GET request to `http://quiet-beach-24792.herokuapp.com/todos.json` and print the data that's returned.  You could use jQuery.  Or you could use an XMLHttpRequest object.
- [ ] Update the feature test you wrote in challenge 6 to check for the to dos returned by the API.  Watch it fail.
- [ ] Initialise your to do list model with the to dos that are returned when you make an Ajax GET request to the to do API.  Your feature test should now pass.
- [ ] Optional.  Extract your Ajax code to a separate module.  Write unit tests for it.

### Resources

- [You don't need jQuery (Ajax)](http://blog.garstasio.com/you-dont-need-jquery/ajax/)
- [Callbacks workshop](https://github.com/maryrosecook/callbacks-workshop)
- [Functional (feature) testing for node using Mocha and Zombie.js](http://www.redotheweb.com/2013/01/15/functional-testing-for-nodejs-using-mocha-and-zombie-js.html)
