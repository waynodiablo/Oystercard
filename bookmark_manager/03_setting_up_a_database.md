## Setting up a database

[Back to the Challenge Map](00_challenge_map.md)

Now that you understand the pros and cons of different persistence mechanisms, it's important for you to see them in action. In this challenge you will install a popular Relational Database Management System (RDBMS) called PostgreSQL

## Learning Objectives covered

* Know that psql is a command-line tool to interact with a Postgres database
* Install Postgres
* Use the psql command to interact with Postgres

## To complete this challenge, you will need to

- [ ] Using `brew`, install the `postgresql` package and follow the instructions carefully
- [ ] Check your installation by running `psql` in the terminal. Refer to the [official postgres tutorial](http://www.postgresql.org/docs/9.5/static/tutorial-createdb.html) to understand any errors that you see.
- [ ] Create a database in Postgres with your username:
  - [ ] From within terminal, type `echo $USER` to see your username. 
  - [ ] Connect with `psql`.
  - [ ] Using the `CREATE DATABASE databasename` command, create a database with your username.

## Resources

* [Homebrew Package Manager](http://brew.sh/)
* [Creating a database - Official Documentation](http://www.postgresql.org/docs/9.5/static/tutorial-createdb.html)
* [PostgreSQL Command Line Cheat Sheet](http://blog.jasonmeridth.com/posts/postgresql-command-line-cheat-sheet/)

## [Solution - Mac OS](solutions/03_mac.md)
## [Solution - Linux](solutions/03_linux.md)
## [Solution - Nitrous](solutions/03_nitrous.md)
