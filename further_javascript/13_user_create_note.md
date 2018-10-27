# Use TDD to finish support for user note creation

[Back to the Challenge Map](00_challenge_track.md)

In this challenge, you'll write code to let the user submit a new note.  You'll test that the note is displayed.  You might also refactor your code so that its concerns are better separated into modules, rather than it all being in `note-controller.js`.  If you do this, it will make your code easier to test and more agile.

### Learning objectives covered

- Integrate model, view and controller code.

### To complete this challenge

- [ ] Use TDD to update your `note-controller.js` so that it no longer adds a dummy `Favourite drink: seltzer` note.
- [ ] Integrate the `note-controller.js` code that intercepts a submit event, extracts the submitted note text, adds a new note to the note list and updates the `app` element to show the note list as HTML.  Test drive your development as best as you can.
- [ ] Refactor your code.  Maybe some parts of it can be delegated to new modules?

### Tests to write

- When the app loads, the HTML for an empty note list is displayed.
- When a submit event is triggered, the HTML for a note list with the new note is written to the `app` element.

You will probably need to do some serious mocking for these tests.  To get the mocking right, diagram the boundaries of the note controller.  The boundaries you decide on will determine what you mock.

### Resources

- :pill: [Mocking in JavaScript](../pills/mocking_in_javascript.md)
- [In what order do the parts of an HTML page load?](http://stackoverflow.com/questions/1795438/load-and-execution-sequence-of-a-web-page)
- :pill: [Frontend, single page app](https://github.com/makersacademy/course/blob/master/pills/frontend_single_page_app.md)
- [Document Object Model (DOM) on MDN](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)
- [getElementById on MDN](https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementById)
- [innerHTML on MDN](https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/further_javascript/13_user_create_note.md)
