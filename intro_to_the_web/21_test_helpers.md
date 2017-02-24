# Test Helpers

[Back to the Challenge Map](README.md)

We've implemented two user stories, but our tests are starting to repeat themselves. They're duplicating the same user actions again and again:

- visiting the home page,
- entering names, and
- signing in.

We can use a **helper** to avoid this constant repetition. Helpers are small objects that provide basic functionality that isn't related to the main aim of a program. They are almost always used to DRY up code.

In this challenge, we will DRY up our tests using a **helper**.

### Learning Objectives covered
- DRY up code with helpers

### To complete this challenge, you will need to:

- [ ] Make a new file, `spec/features/web_helpers.rb`
- [ ] `require` this file inside your `spec_helper.rb`
- [ ] Define a method inside this file, `sign_in_and_play`
- [ ] Extract code from your two feature tests that:
  - visits the homepage,
  - fills in the fields, and
  - clicks submit
- [ ] Place this extracted code inside `sign_in_and_play`
- [ ] Replace these lengthy lines in your feature tests with a call to `sign_in_and_play`.

### Resources

- [Helper class (Wikipedia)](https://en.wikipedia.org/wiki/Helper_class)

### [Walkthrough](walkthroughs/21_test_helpers.md)
