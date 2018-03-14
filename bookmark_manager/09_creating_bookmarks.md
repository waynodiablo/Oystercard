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

## Learning Objectives covered

* Build a complete full-stack feature.

## To complete this challenge, you will need to

- [ ] Decompose the requirement 'add new bookmarks' into a User Story.
- [ ] Write a feature test for a user submitting a new bookmark via a form. _Think carefully about how to set up the Sinatra routes for this!_
- [ ] Solve the feature test by:
  - [ ] Doing the simplest thing
  - [ ] Refactoring bookmark creation into the `Bookmark` model (perhaps a `Bookmark.create` method?)
  - [ ] Ensuring that your feature test passes
- [ ] Test that your new feature also works in the development environment
- [ ] Refactor any spec code that adds data to the database with this new `Bookmark.create` functionality.

## [Walkthrough](walkthroughs/09.md)
