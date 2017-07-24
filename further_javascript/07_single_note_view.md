# TDD a single note view

[Back to the Challenge Map](00_challenge_track.md)

In this challenge, you'll begin implementing code that lets a user see a note on its own page. (Have a look at the [user stories](notes_app_user_stories.md) to remind yourself of the design of the app.

The first step will be to make a single note view.  This takes a note model and converts it to HTML.

### Learning objectives covered

- Interpolate data into static HTML.

### To complete this challenge, you will need to:

- [ ] TDD a single note view object (a view for showing a single note on a page) that fulfils the specification below.

### Specification

- Code is in a file called `single-note-view.js`.
- Code is wrapped in the module pattern.
- Code uses the constructor and prototype pattern to define a single note view object that can be instantiated.
- The single note view constructor takes a note model as a parameter.
- The single note view has a method that, when called, returns a string of HTML that represents the note model.  For example: `<div>Favourite drink: seltzer</div>`.

### Resources

- [Constructor and prototype pattern workshop](https://github.com/makersacademy/skills-workshops/tree/master/week-5/encapsulation_with_constructor_and_prototype_pattern)
- [Array join](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/join)
- :pill: [JavaScript module pattern](https://github.com/makersacademy/course/blob/master/pills/javascript_module_pattern.md)
