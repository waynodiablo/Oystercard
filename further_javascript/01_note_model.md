# TDD a model for a note

[Back to the Challenge Map](00_challenge_track.md)

So far in the course, you've mostly built systems outside in: write a feature test, write unit tests to match the unit test failure and write code to pass the tests.  For this app, you'll focus on unit tests.  You'll write tests for a unit (e.g. the object that represents a note). Then you'll implement the unit.  You'll keep on going in this fashion all the way through building your app.  There's a lot of new material in this week's curriculum.  Focusing on unit tests will help you methodically write solid, expandable code.

### Learning objectives covered

- Write unit tests without using a testing framework.
- Use the constructor and prototype pattern.

### To complete this challenge, you will need to:

- [ ] TDD a note object that fulfills the specification below.

### Note model specification

- Code is in a file called `note-model.js`.
- Code is wrapped in the module pattern.
- Uses the constructor and prototype pattern to define a note model object that can be instantiated.
- Takes the text of a note upon instantiation e.g. `My favourite language is JavaScript`.
- Stores the text in a `text` property on the note.
- Has a method that will return the note text.

### Resources

- :pill: [JavaScript module pattern](https://github.com/makersacademy/course/blob/master/pills/javascript_module_pattern.md)
- :pill: [Writing tests without a framework](https://github.com/makersacademy/course/blob/master/pills/writing_tests_without_a_testing_framework.md)
- [Constructor and prototype pattern workshop](https://github.com/maryrosecook/constructor-and-prototype-pattern-workshop)
