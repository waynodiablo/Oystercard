# Use TDD to finish the implementation of a single note page

[Back to the Challenge Map](00_challenge_track.md)

In this challenge, you'll complete the code for a page that shows a single note.  You'll give note models unique ids.  You'll link each note in the main page to its single note page.  And you'll write code to display the content for a single note.

### Learning objectives covered

- Support multiple content "pages" in a frontend, single page app.
- Use the `hashchange` event to load page content when the browser URL changes.

### To complete this challenge, you will need to:

#### Note model unique `id`

- [ ] TDD giving each note model object a unique `id`.  The first note created would have an `id` of `0`.  The second note created would have an `id` of `1`.

#### Link each note to a page that displays the full note

- [ ] Read :pill: [frontend, single page app](https://github.com/makersacademy/course/blob/master/pills/frontend_single_page_app.md).
- [ ] Use TDD to update the note list view so that each note is linked to an appropriate URL for displaying that individual note.
- [ ] Go to `http://localhost:8080` in your browser.  You should be able to click on a note and be redirected to the URL for that note.  There should be no page refresh.  The page content shouldn't change.  (And you won't see the note, yet.)

#### Load the content for the single note page

- [ ] Using TDD, update your `note-controller.js` to load content for the single note page.  The note controller code should listen for `hashchange` events.  When one happens, if the new browser URL is for a single note page, it should use the `app` element to set the web page content to the HTML for that note.
- [ ] Go to `http://localhost:8080` in your browser.  You should be able to click on a note and see the full text of that note.  There should be no page refresh.

### Resources

- :pill: [Frontend, single page app](https://github.com/makersacademy/course/blob/master/pills/frontend_single_page_app.md)
- [Getting the current browser URL](http://stackoverflow.com/questions/1034621/get-current-url-in-web-browser)
- [JavaScript string methods (MDN)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String#Methods)
