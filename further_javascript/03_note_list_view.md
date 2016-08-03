# TDD a note list view

[Back to the Challenge Map](00_challenge_track.md)

In order to display a list of notes to the user, they need to be converted to HTML.  In this challenge, you'll write code for a note list view.  This code takes a note list model and outputs it as a string that contains the HTML for an unordered HTML list.

### Learning objectives covered

- Interpolate data into static HTML.

### To complete this challenge, you will need to:

- [ ] TDD the note list view object that fulfils the specification below.

### Specification

- Code in a file called `note-list-view.js`.
- Code is wrapped in the module pattern.
- Uses the constructor and prototype pattern to define a note list view object that can be instantiated.
- Takes a note list model upon instantiation.
- Has a method that, when called, returns a string of HTML that represents the note list model.  For example: `<ul><li><div>Favourite food: pesto</div></li><li><div>Favourite drink: seltzer</div></li></ul>`.
- Handles a note list model that has no notes, one note or several notes.

> NB: This challenge doesn't require you to display the HTML in a browser, or put the HTML into an HTML file.  If your code returns the right string of HTML to your tests, the challenge is complete!

### Resources

- [Constructor and prototype pattern workshop](https://github.com/maryrosecook/constructor-and-prototype-pattern-workshop)
- [Array join](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/join)
- [HTML lists on MDN](https://developer.mozilla.org/en/docs/Web/HTML/Element/ul)
- :pill: [JavaScript module pattern](https://github.com/makersacademy/course/blob/master/pills/javascript_module_pattern.md)
