# Playing with Postgres and DataMapper from Terminal

## The Basics

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
  * :white_check_mark: Add two more entries to the students table.
  * :white_check_mark: Delete them.
  * :white_check_mark: Update the names of one of them.

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

So we've created a class that has extra abilities endowed by DataMapper: namely, the ability to persist data to the database. We now need to have DataMapper [check the validity](http://www.rubydoc.info/github/datamapper/dm-core/DataMapper/Model#finalize-instance_method) of the models as we've declared them.

      $ DataMapper.finalize

DataMapper uses an elaboration the regular #new method for creating instances and preserving their data within the database:

      $ Student.create(name: "Ptolemy")

The Logger we setup will give us a bunch of mostly uninteresting chatter, but it should include the line:

    ~ (0.001957) INSERT INTO "students" ("name") VALUES ('Ptolemy') RETURNING "id"

So we've achieved exactly what we did before but in a single line of nice familiar Ruby. =)

Mess around with what you can do with DataMapper models. Here are some things to try:

  * :white_check_mark: Delete a row of a table, via DataMapper.
  * :white_check_mark: We set properties with two different datatypes: String, and Serial. What others are there?
  * :white_check_mark: What happens within SQL when we start creating associations within DataMapper?

### Further Commands

| Function                                    | Command                         |
| ------------------------------------------- | ------------------------------- |
| Create Database                             | CREATE DATABASE database_name;  |
| Drop (Delete) Database                      | DROP DATABASE database_name;  |
| List Databases                              | \l                              |
| Leave list of Databases                     | q                               |
| Connect to a Database                       | \c database_name                |
| List Tables in a connected Database         | \dt                             |
| List Users (Roles) in a connected Database  | \du                             |

## Advanced SQL: C.R.U.D.
*Note: The following assumes a database populated with some data relevant to the domain of Bookmark Manager.*

**C.R.U.D.** sounds like it should be an 80s punk band - but in Computer Science this acronym represents the four basic functions of [persistent storage](http://en.wikipedia.org/wiki/Persistence_(computer_science)), and stands for **Create, Read, Update and Delete.** These terms are pretty much self-explanatory, but I shall cover each of them in the context of SQL in just a moment.

**SQL** (pronounced "ess-que-el") stands for **Structured Query Language.** It is the most common language used to communicate with modern databases, and there are a handful of basic commands that will stand you in extremely good stead during your career as a Developer. Let us look at those as they apply to the principles of C.R.U.D.

#### Read

So we're going to defy the order of the acronym for a moment, and start with Read (cRud). The reason being, that knowing what's currently in a database is usually advantageous before creating, updating or deleting. The SQL command associated with Reading, is called `SELECT`. Let's say we have connected to a database. Let's take a look at the tables that this database consists of, using the postgres command `\dt`:

```
some_database=# \dt

List of relations
Schema |   Name    | Type  |    Owner
--------+-----------+-------+-------------
public | link_tags | table | your_username
public | links     | table | your_username
public | tags      | table | your_username
public | users     | table | your_username
(4 rows)
```

Now it would be really useful to know what kind of data lives in `links`. Let us invoke the mighty SQL Gods with the following:

```SQL
SELECT * FROM links;
```
Hopefully this is relatively easy to read, but basically asks the database to select _everything_ (*) from the table `links`. Let's have a look at what output is generated:

```
id |     title      |           url
----+----------------+--------------------------
 1 | Code.org       | http://code.org
 2 | Makers Academy | http://makersacademy.com
(2 rows)
```

So we can see here that we have three columns (also called 'fields'): `id`, `title` and `url`, and two rows (also called 'records' or 'tuples') with a value for each field. This gives us a good idea of what we've got to play with in terms of our table structure. Now let's take a look at the **create**, **update** and **delete** parts of C.R.U.D.

#### Create

There's little point of having a database if you're not willing to put anything in it. So it's time to Create. The SQL command associated with creation is `INSERT`. This command will create new [rows](http://en.wikipedia.org/wiki/Row_%28database%29d) in a table. Let's update our `links` table with some information for [CSS-Tricks](http://css-tricks.com):

```SQL
INSERT INTO "links" (TITLE,URL) VALUES ( 'CSS Tricks', 'http://csstricks.com');
```

There are several things to note here.

* We have put `links` in quotation marks. as you can see from when we ran `some_database=# SELECT * FROM "links";` that you can get away without it - however, to use the quotes is best practice so we shall continue hereon in that style.
* Where the column names (fields) are declared, we omit `ID`. This is because `ID` values are automatically generated by SQL and therefore are left out.
* When passing strings to populate the rows (aka records or tuples), we use single quotes. SQL typically reserves double quotes for table names.

Now let's have a look at the contents of table again:

```SQL
SELECT * FROM "links";
```
```
id |     title      |           url
----+----------------+--------------------------
 1 | Code.org       | http://code.org
 2 | Makers Academy | http://makersacademy.com
 3 | CSS Tricks     | http://csstricks.com
(3 rows)
```

We have successfully created a new record in `links`, and the database has automatically assigned it with a sequential `id`.

#### Update

Sometimes we just want to make amendments to our database. The `UPDATE` command is our friend here. Let's say that we made an error by linking to csstricks.com, and wish to amend the url value to the correct address (which is _css-tricks_.com). Looking at our table with a `SELECT` query, we can see that the column we have stored our offending value at is called `url` and it has a unique `id` of '3' associated with it.

```SQL
UPDATE "links" SET URL = 'http://css-tricks.com' WHERE ID = 3;
```
```
UPDATE 1
```
Run another `SELECT` query to see if our changes have taken effect (`UPDATE 1` is a kind of confirmation message, so we can feel fairly confident that _something_ has been updated...)

```SQL
SELECT * FROM "links";
```
```
id |     title      |           url
----+----------------+--------------------------
 1 | Code.org       | http://code.org
 2 | Makers Academy | http://makersacademy.com
 3 | CSS Tricks     | http://css-tricks.com
(3 rows)
```

Sweet, sweet success.

#### Delete

I think we'll forego elaborating on the concept of deletion and jump straight in. I'm thinking that after all our hard work it would be a shame to delete our link to css-tricks.com, so let code.org be the sacrificial lamb.

```SQL
DELETE FROM "links" WHERE ID = 1;
```
```
DELETE 1
```
Now let's see what kind of condition `links` is in:

```SQL
SELECT * FROM "links";
```
```
id |     title      |           url
----+----------------+--------------------------
 2 | Makers Academy | http://makersacademy.com
 3 | CSS Tricks     | http://css-tricks.com
(2 rows)
```

So that's a whirlwind tour of PostgreSQL. Hopefully this should shed some light on what's going on under the hood, and help you appreciate what an ORM like [DataMapper](http://datamapper.org/) gives us in terms of functionality. Always remember to check in with your databases as your projects grow to make sure you are understanding what's really going on in the dark corners of your database! :)

## Resources

* http://www.w3schools.com/sql/
* http://blog.jasonmeridth.com/posts/postgresql-command-line-cheat-sheet/

## Related Videos

Relational Database Overviews:

* [Sam on Whiteboard & Projector](https://www.youtube.com/watch?v=BS1_WrjhTQc)
* [Stephen on Whiteboard (+Mihai)](https://www.youtube.com/watch?v=dIq_E-HSje8)
* [Stephen on Projector (+Sam)](https://www.youtube.com/watch?v=C7EKjnFCyeQ)
* [Enrique on Whiteboard](https://www.youtube.com/watch?v=QlDE4kYzvjU)
