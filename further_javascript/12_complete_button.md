# Test and write code that implements a to do `Complete` button

[Back to the Challenge Map](00_challenge_track.md)

In this challenge, you'll write code to let a user mark a to do as complete.

### Learning objectives covered

- Create an HTML form.
- Listen for events.
- Stop an event from triggering a default action.
- Extract data from an event.
- Write a more complex feature test that encompasses a user filling out and submitting a form and seeing new data displayed in a page.

### To complete this challenge, you will need to:

- [ ] Write unit tests to check that you can change the `completed` boolean on a to do list item model from false to true.  Make these tests pass.
- [ ] Change your to do template tests to check that the outputted HTML includes an HTML form that will complete the to do.  The form should send a post request to an appropriate RESTful URL.  It should have a submit button labelled `Complete`.
- [ ] Update your to do template code to pass these tests.
- [ ] Add a feature test that checks that the user can click on the complete button and see the to do be indicated as complete in `index.html`.  (If your code is nicely modularised, you can also write unit tests to help your get your units working.)

### Resources

- [`preventDefault()` on MDN](https://developer.mozilla.org/en/docs/Web/API/Event/preventDefault)
- [HTML forms on W3 schools](http://www.w3schools.com/html/html_forms.asp)
- [RESTful routing question on Stack Overflow](http://stackoverflow.com/questions/2441962/what-is-restful-routing)
- [Functional (feature) testing for node using Mocha and Zombie.js](http://www.redotheweb.com/2013/01/15/functional-testing-for-nodejs-using-mocha-and-zombie-js.html)
- [innerHTML on MDN](https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML)
- [You don't need jQuery - ways of interacting with the DOM without using jQuery](http://blog.garstasio.com/you-dont-need-jquery/)
