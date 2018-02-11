## Creating links

[Back to the Challenge Map](00_challenge_map.md)

We've built a Sinatra application that can read and display links from the database. We've interacted with the database via `psql`, `pg`, and now a GUI, TablePlus.

Over the past few challenges, we:

- Set up a database.
- Played with it a bit.
- Connected it with Sinatra.

Now that we have a reliable persistent database, let's build the next feature in the specification:

* Show a list of links :white_check_mark:
* Add new links :construction:
* Tag links into categories
* Filter links by tag

In this challenge, you will build the entire feature of 'adding links to the database' from browser to database: across the whole stack.

> This is your first 'full-stack' feature!

## Learning Objectives covered

* Build a complete full-stack feature.

## To complete this challenge, you will need to

- [ ] Decompose the requirement 'add new links' into a User Story.
- [ ] Write a feature test for a user submitting a new link via a form. _Think carefully about how to set up the Sinatra routes for this!_
- [ ] Solve the feature test by:
  - [ ] Doing the simplest thing
  - [ ] Refactoring link creation into the `Link` model
  - [ ] Ensuring that your feature test passes
- [ ] Test that your new feature also works in the development environment

## [Walkthrough](walkthroughs/09.md)