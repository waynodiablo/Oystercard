# Playing with Postgres and SQL from Terminal
### ( this pill is unfinished )

NOTE: The dollar symbol, by convention, means that what follows it is code. DON'T actually type the dollar symbol

DataMapper and how it works with postgres (aka psql) can be a little confusing, so it's worth playing around from the terminal.
Assuming you have psql installed and working, connect to your pool of databases like so:

    $ psql

Which should give you a command prompt:

    psql (9.3.5)
    Type "help" for help.

    admin=#

Check out the [psql pill](https://github.com/makersacademy/course/blob/master/pills/postgres.md) for an introduction to psql commands, otherwise use a [cheat sheet](http://blog.jasonmeridth.com/posts/postgresql-command-line-cheat-sheet/). Let's have a look at the existing databases:

    $ \l

Running this command gives me a list of a dozen or so databases, mostly from old projects. Let's start fresh though:

    $ CREATE DATABASE database_play;

We can now connect to the newly created database:

    $ \c database_play;

And inspect the existing list of tables:

    $ \dt

    No relations found.

That makes sense as we haven't put any data into this database or even told it how it should be structured. Let's try to create a table for storing data about students with SQL commands:

    CREATE TABLE students(
      id serial PRIMARY KEY,
      name varchar(50)
    );

Don't worry about what all this means! Now if we inspect the list of tables again (see above) we should see one with the name students. Let's have a closer look:

    $ SELECT * FROM STUDENTS;

This command displays all columns from the table "students" and shows us an empty table:

    id | name
    ----+------
    (0 rows)

Let's add some data.
