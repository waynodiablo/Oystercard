## Creating Your First Table

[Back to the Challenge Map](00_challenge_map.md)

We've just set up a Postgres database that can store (_persist_) data forever - even if you shut down and restart your computer.

In this challenge, you will use Postgres' built-in command-line program, `psql`, to interact with the database using a database-specific language, `SQL`. You will create a **database table** with two **database columns**.

> You rarely have to interact with databases from the command-line like this, but play around to create and destroy a few tables so you know what's going on at the data storage level.

## Learning Objectives covered

* Use the `psql` command to interact with Postgres
* Know that 'SQL' means 'Structured Query Language'
* Explain how SQL is used to query databases
* Use SQL query terms like `SELECT`, `FROM`, `WHERE`, and `*`

## To complete this challenge, you will need to

- [ ] List the existing database via `psql`
- [ ] Connect `psql` to an existing database
- [ ] List the tables in that database
- [ ] Create a basic table called 'students' with a single primary key (id) and name field
- [ ] List the existing tables again to check that the 'students' table shows up

## Resources

* [PostgreSQL Command Line Cheat Sheet](http://blog.jasonmeridth.com/posts/postgresql-command-line-cheat-sheet/)
* [SQL in One Page](http://www.cheat-sheets.org/sites/sql.su/)

## [Walkthrough](walkthroughs/04.md)
