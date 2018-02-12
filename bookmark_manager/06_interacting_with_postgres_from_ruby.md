## Interacting with PostgreSQL from Ruby

[Back to the Challenge Map](00_challenge_map.md)

We've built a Sinatra application that displays some hard-coded links. We've also built a database, added a database table, and played with some data in that table using `psql`.

In this challenge, you will get them talking to each other. You will remove the hard-coded array of links and read them from a database instead.

## Learning Objectives covered

* Attach a database to a web application.

## To complete this challenge, you will need to

- [ ] Install the `pg` gem to your project.
- [ ] Update the `.all` method of your `Link` model to do the following (through `pg`):
  - [ ] Connect to the PostgreSQL `bookmark_manager` database.
  - [ ] Send a query to retrieve all records from the `links` table.
  - [ ] Return those links as an array of URLs.
- [ ] Make sure you still pass the first feature.
- [ ] Without stopping the Sinatra program, add a new link via `psql` to the database.
- [ ] Make sure this new link shows up on the page.

## Resources

* [Talking to PostgreSQL using Ruby via `pg`](http://zetcode.com/db/postgresqlruby/) (most useful is the section called 'Retrieving multiple rows of data')
* [`pg` documentation](https://deveiate.org/code/pg/)

## [Walkthrough](walkthroughs/06.md)
