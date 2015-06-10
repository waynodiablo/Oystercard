# Playing with Postgres and DataMapper from Terminal

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

Let's add some data:

    $ INSERT INTO students (name)
    VALUES ('Ptolemy');

The same select command from above will prove that the new data has been added to the students table.

Try the following exercises:
  * Add two more entries to the students table.
  * Delete them.
  * Update the names of one of them.

There is a problem emerging here, however: we're having to write out syntactically difficult and unfamiliar SQL commands to perform basic read / write commands. This is where DataMapper comes it. DataMapper allows us to deal with our DataBase from a distance via a Ruby interface.

So let's play! Keep your psql prompt open but open a new tab in terminal. Create a gemfile and add the following gems:

    gem 'data_mapper'
    gem 'dm-postgres-adapter'

Bundle install then crack open IRB or pry and run the following:

    $ require 'data_mapper'
    $ require 'dm-postgres-adapter'
    $ DataMapper::Logger.new($stdout, :debug)
    $ DataMapper.setup(:default, "postgres://localhost/database_play")

The above are pretty self-explanatory. For learning purposes, we're having DataMapper show us its chatter with the database.

Now let's create a Student "model" (within IRB) for interfacing with our student table in the database:

    class Student
      include DataMapper::Resource

      property :id,     Serial
      property :name,   String
    end

So we've created a class that has extra abilities endowed by DataMapper: namely, the ability to persist data to the database. We now need to have DataMapper tell the database what the structure of the "students" table in the database should look like:

      $ DataMapper.finalize

DataMapper uses an elaboration the regular #new method for creating instances and preserving their data within the database:

      $ Student.create(name: "Ptolemy")

The Logger we setup will give us a bunch of mostly uninteresting chatter, but it should include the line:

    ~ (0.001957) INSERT INTO "students" ("name") VALUES ('Ptolemy') RETURNING "id"

So we've achieved exactly what we did before but in a single line of nice familiar Ruby. =)

Mess around with what you can do with DataMapper models. Here are some things to try:

  * Delete a row of a table, via DataMapper.
  * We set properties with two different datatypes: String, and Serial. What others are there?
  * What happens within SQL when we start creating associations within DataMapper?
