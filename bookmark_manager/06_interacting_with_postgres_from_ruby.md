## Interacting with PostgreSQL from Ruby

[Back to the Challenge Map](00_challenge_map.md)

We've built a Sinatra application that displays some hard-coded bookmarks. We've also created a database, added a database table, and played with some data in that table using `psql`.

In this challenge, you will get the application and database talking to each other. This will allow your application to **c**reate, **r**ead, **u**pdate and **d**elete database entries. Then you'll no longer need that hard-coded list of bookmarks ;)

## Learning Objectives covered

* Attach a database to a web application.

## To complete this challenge, you will need to

- [ ] Install the `pg` gem to your project.
- [ ] Update the `.all` method of your `Link` model to do the following (through `pg`):
  - [ ] Connect to the PostgreSQL `bookmark_manager` database.
  - [ ] Send a query to retrieve all records from the `bookmarks` table.
- [ ] Make sure you still pass the first feature, using this new response. You will need to update the view.
- [ ] Without stopping the Sinatra program, add a new bookmark via `psql` to the database.
- [ ] Make sure this new bookmark shows up on the `/bookmarks` page.

## Resources

* [Talking to PostgreSQL using Ruby via `pg`](http://zetcode.com/db/postgresqlruby/) (most useful is the section called 'Retrieving multiple rows of data')
* [`pg` documentation](https://deveiate.org/code/pg/)

## [Walkthrough](walkthroughs/06.md)
