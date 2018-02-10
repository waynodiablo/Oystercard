# Setting up a Testing Environment

[Back to the Challenge Map](00_challenge_map.md)

We've built a Sinatra application that can read and display links from the database. We've interacted with the database via `psql`, `pg`, and now a GUI, TablePlus.

Right now, we have a problem:

- Our feature and unit tests expect three specific links.
- We've been adding links and changing links via `psql`, `pg`, and TablePlus.

So, our feature and unit tests are probably failing right now. It's a real pain to have to change the data back to the 'just right' three links every time we want to run that feature test.

And, in future, we're planning on enabling the user to add more links. This problem is going to get worse!

In this challenge, you will write a script to **reset your database** every time you run the tests. You'll build a **test environment** for your web application.

## Learning Objectives covered

* Set up a test environment.

## To complete this challenge, you will need to

- [ ] Create a new database, `bookmark_manager_test`, with a `links` table.
- [ ] Print out the Rack [Environment Variable](http://blog.honeybadger.io/ruby-guide-environment-variables/), `ENV`.
- [ ] Use `ENV` to enable the following condition: when you run your application using `rackup`, Links are read from the `bookmark_manager` database. When you run your application tests using `rspec`, Links are read from the `bookmark_manager_test` database.
- [ ] Write a script that uses `pg` to:
  - [ ] Empty the `links` table in the database.
  - [ ] Add the three links the feature test expects to the database.
- [ ] Figure out how to run this script automatically every time you run `rspec` for this application.

## Resources

* [How do I get the current Rack Environment?](https://stackoverflow.com/questions/15459569/how-to-get-the-current-rack-environment-in-rake)
* [PostgreSQL `DROP TABLE IF EXISTS` command](https://www.postgresql.org/docs/8.2/static/sql-droptable.html)
* [PostgreSQL `TRUNCATE` command](https://www.postgresql.org/docs/8.2/static/sql-truncate.html)

## [Walkthrough](walkthroughs/08.md)