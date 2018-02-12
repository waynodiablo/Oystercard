## Extracting a `Database` setup object

[Back to the Challenge Map](00_challenge_map.md)

We've built a Sinatra application that can read and write from and to a database. It's structured in an MVC style, and has test and development environments.

At the moment, our `Link` class methods have two responsibilities:

- Connect to the correct database for the current environment, and
- Manipulate data in that database.

Each time we want to transact with the database from the `Link` model, we create a new connection using `PG.connect`. Wouldn't it be great if this all happened once, when the app boots?

Even worse – at the moment, we have no way of telling whether we're connecting to the _right_ database other than checking the database once we're connected to it. We should write some tests to make sure we're connecting to the right database.

In this challenge, you will extract an object which is used to setup a connection to the database when the application starts, and refactor `Link` to use it.

## To complete this challenge, you will need to

- [ ] Test-drive a new class, `DatabaseConnection`, with two methods:
  - [ ] `DatabaseConnection.setup` is a class method. It takes one parameter: a database name. It should set up a connection to that database, which is saved as a class instance variable in `Database`.
  - [ ] `DatabaseConnection.query` is a class method. It takes one parameter: an SQL query string. It should use the class instance variable from `setup` to execute that SQL query string on the correct database, via `pg`.
- [ ] Write a setup script that runs when the application boots, which calls `DatabaseConnection.setup` with the correct database for the environment.
- [ ] Replace calls to `PG.connect` and `connection.exec` in `Link` with your new `DatabaseConnection` wrapper class.

## [Walkthrough](walkthroughs/10.md)
