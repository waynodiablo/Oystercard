## Manipulating Table Data

[Back to the Challenge Map](00_challenge_map.md#challenges)

We have created a PostgreSQL database, and added a `bookmarks` table. At the moment, there's no data in the table.

In this challenge, you will use SQL to **c**reate, **r**ead (**query**), **u**pdate and **d**elete (CRUD) data in the table you created, inside your PostgreSQL database.

## Learning Objectives covered

* Use SQL terms like `SELECT`, `FROM`, `WHERE` and `*` to query a database table
* Use SQL terms like `INSERT`, `UPDATE` and `DELETE` to create, update and delete database entries

## To complete this challenge, using the psql command line interface

- [ ] List any existing rows in the bookmarks table.
- [ ] Create four link entries in the `bookmarks` table, with the following URLs: `http://www.makersacademy.com`, `http://askjeeves.com`, `http://twitter.com`, and `http://www.google.com`, using an `INSERT` statement.
- [ ] List the four entries using a `SELECT` statement.
- [ ] Delete the link with a URL of `http://twitter.com` using a `DELETE` statement.
- [ ] Update the `http://askjeeves.com` link to `http://www.destroyallsoftware.com` using an `UPDATE` statement.

## Hints
&nbsp;<details><summary>CLICK ME</summary>
* Again, use the documents linked below to look up the commands you need.
* Sanity check each step using a SELECT statement.
&nbsp;</details>

## Resources

* [PostgreSQL Command Line Cheat Sheet](http://blog.jasonmeridth.com/posts/postgresql-command-line-cheat-sheet/)
* [Alternative PostgreSQL Cheat Sheet](http://www.postgresqltutorial.com/postgresql-cheat-sheet/)
* [SQL in One Page](http://www.cheat-sheets.org/sites/sql.su/)
* [Relational Database: Terminology](https://en.wikipedia.org/wiki/Relational_database#Terminology)

## [Walkthrough](walkthroughs/06.md)
