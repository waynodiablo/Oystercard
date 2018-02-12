## Creating Your First Table

[Back to the Challenge Map](00_challenge_map.md)

We've just set up a Postgres database that can store (_persist_) data forever - even if you shut down and restart your computer.

In this challenge, you will use Postgres' built-in command-line program, `psql`, to interact with the database using a database-specific language, `SQL`. You will create a **table** with two **columns**.

> You rarely have to interact with databases from the command-line like this, but play around to create and destroy a few tables so you know what's going on at the data storage level.

## Learning Objectives covered

* Use the `psql` command to interact with Postgres
* Create tables using SQL.

## To complete this challenge, you will need to

- [ ] Create a new PostgreSQL database for Bookmark Manager, called `bookmark_manager`.
- [ ] Use `psql` to connect to this new database.
- [ ] Use `psql` to create a table called `links` in the `bookmark_manager` database, with two columns: `id`, a `SERIAL PRIMARY KEY`, and `url`, a `VARCHAR` with a maximum length of `60`.

> Don't forget that you can list databases and tables using `\l`.

## Resources

* [PostgreSQL Command Line Cheat Sheet](http://blog.jasonmeridth.com/posts/postgresql-command-line-cheat-sheet/)
* [SQL in One Page](http://www.cheat-sheets.org/sites/sql.su/)

## [Walkthrough](walkthroughs/04.md)
