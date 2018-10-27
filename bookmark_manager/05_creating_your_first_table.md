## Creating Your First Table

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've just set up a Postgres database that can store (_persist_) data forever - even if you shut down and restart your computer.

In this challenge, you will use Postgres' built-in command-line program, `psql`, to interact with the database using a database-specific language, `SQL`. You will create a **table** with two **columns**.

> You rarely have to interact with databases from the command-line like this, but play around to create and destroy a few tables so you know what's going on at the data storage level.

## Learning Objectives covered

* Use the `psql` command to interact with Postgres
* Create tables using SQL.

## To complete this challenge, you will need to

- [ ] Create a new PostgreSQL database for Bookmark Manager, called `bookmark_manager`.
- [ ] Use `psql` to connect to this new database.
- [ ] Use `psql` to create a table called `bookmarks` in the `bookmark_manager` database, with two columns: `id`, a `SERIAL PRIMARY KEY`, and `url`, a `VARCHAR` with a maximum length of `60`.
- [ ] Record the database setup instructions. 

## Hints
&nbsp;<details><summary>CLICK ME</summary>
- All of the commands you will need for this step are listed in the two documents listed below.  You may need to check both of them.
- Don't forget that you can list databases using `\l` and tables using `\dt`. You can use these commands to check that your set up has been successful.
&nbsp;</details>

## Resources

* [PostgreSQL Command Line Cheat Sheet](http://blog.jasonmeridth.com/posts/postgresql-command-line-cheat-sheet/)
* [SQL in One Page](http://www.cheat-sheets.org/sites/sql.su/)
* [PostgreSQL Cheat Sheet](http://www.postgresqltutorial.com/postgresql-cheat-sheet/)

## [Walkthrough](walkthroughs/05.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/bookmark_manager/05_creating_your_first_table.md)
