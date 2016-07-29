# Spike to intercept a form `submit` event emitted by the create note form

[Back to the Challenge Map](00_challenge_track.md)

In this challenge, you'll learn how to listen for the event triggered when a user submits an HTML form.  You'll also learn how to stop the form being submitted, thus avoiding a page refresh that would break your single page app.

### Learning objectives covered

- Listen for events.
- Stop an event from triggering a default action.

### To complete this challenge, you will need to:

- [ ] You can spike this code.
- [ ] Add code to `note-controller.js` to listen for `submit` events.  (Don't use jQuery!)  In your handler, `console.log` the submit event object.
- [ ] Add code to your listening code that stops the form being submitted when a `submit` event is triggered.
- [ ] Click the submit button.  A submit event object should be logged.  The page shouldn't refresh.

### Resources

- :pill: [Single page app](https://github.com/makersacademy/course/blob/master/pills/single_page_app.md)
- [You don't need jQuery - ways of interacting with the DOM without using jQuery](http://blog.garstasio.com/you-dont-need-jquery/)
- [`preventDefault()` on MDN](https://developer.mozilla.org/en/docs/Web/API/Event/preventDefault)
