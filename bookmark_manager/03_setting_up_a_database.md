## Setting up a database

[Back to the Challenge Map](00_challenge_map.md)

We now have a web application with some **hard-coded** data (an array of Bookmarks) and the users of our application can see those bookmarks listed on a page.

In the next few challenges, we are going to:

- set up a **database**,
- play with it a bit to understand its structure, and
- connect it to our Sinatra application.

> We'll return to building the Bookmark Manager application in [this challenge](./06_interacting_with_postgres_from_ruby.md), a few challenges down the line. If you're already comfortable with how Relational Databases work, feel free to skip to that challenge.

In this challenge, you will prepare to move the hard-coded data into a **database**. To do this, you will set up **PostgreSQL** (a database management system) and create a new database.

### Challenge Setup

Let's return to the specification:

* Show a list of bookmarks :white_check_mark:
* Add new bookmarks
* Delete bookmarks
* Update bookmarks
* Comment on bookmarks
* Tag bookmarks into categories
* Filter bookmarks by tag
* Users manage their bookmarks

A user story for the next requirement, 'add new bookmarks', could look like this:

```
As a time-pressed user
So that I can save a website
I would like to add the site's address and title to bookmark manager
```

This user story requires that we persist bookmarks across interactions. At the moment, we _are_ persisting bookmarks as hard-coded strings in our code. This hard coding makes it tough to add new bookmarks while the program's running.

We could solve the persistence problem using a global variable (or the other horrorshow we constructed towards the end of Battle), or even by saving link data out to a file. But it's far more normal to use a **database**.

> A database is simply organised part of a filesystem. It's optimised for storing and retrieving data.

A common database system for modern web development is called [PostgreSQL](https://en.wikipedia.org/wiki/PostgreSQL).

> PostgreSQL is actually a server that runs a database. Therefore, it can be started, stopped, and interacted with through an interface, `psql`.

In this challenge, you will **install the PostgreSQL database system**, and interact with it to create a database.

## Learning Objectives covered

* Install PostgreSQL.
* Create a database.

## To complete this challenge, you will need to

- [ ] Install the `postgresql` command-line package via Homebrew (use the command `brew`).
- [ ] Start postgres and set it to run automatically when your computer starts. (See the instructions in the output that brew shows when it's installing postgres.)
- [ ] Check your installation by running `psql` in the terminal. Use the resources below to understand any errors that you see.
- [ ] Create a PostgreSQL database with the same name as your computer username, e.g. `timmy507`.

## Resources

* [Homebrew Package Manager](http://brew.sh/)
* [PostgreSQL Command Line Cheat Sheet](http://blog.jasonmeridth.com/posts/postgresql-command-line-cheat-sheet/)

## [Walkthrough - Mac OS](walkthroughs/03_mac.md)
## [Walkthrough - Linux](walkthroughs/03_linux.md)
## [Walkthrough - Nitrous](walkthroughs/03_nitrous.md)
