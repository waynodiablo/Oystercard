# Spike and test code that shows a note in the `index.html` page

[Back to the Challenge Map](00_challenge_track.md)

In this challenge, you'll write and test code that shows a note in your `index.html` page.

You'll need to instantiate your note list model, add a note to it, use your note list view to convert your note list model to HTML and dynamically insert the HTML into the body of your `index.html` page.

Because you'll need to integrate several different elements to make the code work, try spiking the code, then deleting it and rewriting it test-first.

### Learning objectives covered

- Insert content into the DOM.
- Integrate model, view and controller code.

### To complete this challenge, you will need to:

- [ ] Spike code that fulfils the specification below.
- [ ] Check that you can visit `http://localhost:8080` in your browser and see `Favourite drink: seltzer`.
- [ ] Delete your code and rewrite it using a TDD approach.

### Specification

- Code is in a file called `note-controller.js`.
- Code is wrapped in the module pattern.
- Uses the constructor and prototype pattern to define a note controller that can be instantiated.
- Takes a note list model upon instantiation. Adds a note that says `Favourite drink: seltzer`.
- Has a method that uses your note list view to convert the note list model to HTML.
- Has a method that inserts the HTML into the `app` element so the note list appears in the `index.html` page.

### Tests to write

- A note controller can be instantiated.
- When the method that puts the note list HTML into the `index.html` page is called, the `app` element has its `innerHTML` property set to the HTML for a note list with one note.  This may require a mocked `app` element.

### Resources

- [Document Object Model (DOM) on MDN](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)
- [getElementById on MDN](https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementById)
- [innerHTML on MDN](https://developer.mozilla.org/en-US/docs/Web/API/Element/innerHTML)
