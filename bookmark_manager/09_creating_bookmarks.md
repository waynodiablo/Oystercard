## Creating bookmarks

[Back to the Challenge Map](00_challenge_map.md)

We've built a Sinatra application that can read bookmarks from the bookmark_manager database and display them to the user. We've also interacted with the database via `psql`, `pg`, and now a GUI, TablePlus.

Over the past few challenges, we:

- Set up a database.
- Played with it a bit.
- Connected it with Sinatra.

Now that we have a reliable persistent database, let's build the next feature in the specification:

* Show a list of bookmarks :white_check_mark:
* Add new bookmarks :construction:
* Delete bookmarks
* Update bookmarks
* Comment on bookmarks
* Tag bookmarks into categories
* Filter bookmarks by tag
* Users manage their bookmarks

In this challenge, you will build the entire feature of 'adding bookmarks to the database' from browser to database: across the whole stack.

> This is your first 'full-stack' feature!

Let's also ensure that the user actually submits a link: not an empty string, or some other string.

> If we don't do this, Bookmark Manager will potentially have invalid URLs listed, which would severely impact on user experience.

To achieve this, you will create a **validation** that the submitted URL is, in fact, a URL.

## Learning Objectives covered

* Build a complete full-stack feature.
* Validate user input in the model layer.

## To complete this challenge, you will need to

- [ ] Decompose the requirement 'add new bookmarks' into a User Story.
- [ ] Write a feature test for a user submitting a new bookmark via a form. _Think carefully about how to set up the Sinatra routes for this!_
- [ ] Solve the feature test by:
  - [ ] Doing the simplest thing
  - [ ] Refactoring bookmark creation into the `Bookmark` model (perhaps a `Bookmark.create` method?)
  - [ ] Ensuring that your feature test passes
- [ ] Test that your new feature also works in the development environment
- [ ] Refactor any spec code that adds data to the database with this new `Bookmark.create` functionality.
- [ ] Add a new feature test that expects some kind of error message, on the page, if the user does not submit a real URL.
- [ ] Pass this feature test by adding functionality to the `Bookmark` model.

## Resources

* [How do I check if a URL is valid?](https://stackoverflow.com/questions/1805761/how-to-check-if-a-url-is-valid)
* [Sinatra Flash (for showing one-time messages)](https://github.com/SFEley/sinatra-flash)


## [Walkthrough](walkthroughs/09.md)
