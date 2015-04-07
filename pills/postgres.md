# PostgreSQL

Postgres is a widely used open source [relational database](http://en.wikipedia.org/wiki/Relational_database) engine.

### Installation

There are two ways of doing this. Firstly, you can download the PostgreSQL app. However, the app can sometimes be problematic, and actually leave you with a non-working PostgreSQL installation.

**We recommend the following method:**

In your terminal run `brew install postgresql`

After homebrew has downloaded the software it will show you some installation instructions, follow them!

Make sure you run these commands after installing:

```shellm
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

You can check your installation by running `psql`

At first it can happen that you don't have a database named after your username (you will see a message along the lines `database "your_computer_username" does not exist`).

Let's create that database for you so that you can log in without having to specify which one: `psql postgres`

Which opens up the postgres terminal - it looks something like `postgres=#`.

Then type in the following:

```shell
create database "your_user_name_here";

CREATE DATABASE

postgres=# \q
```
The last command quits out of the postgres terminal.

From now on you will be able to log in to postgresql without having to specify the database you want to log into.

## More fun commands

### PostgreSQL

| Function                                    | Command                         |
| ------------------------------------------- | ------------------------------- |
| Create Database                             | CREATE DATABASE database_name;  |
| Drop (Delete) Database                      | DROP DATABASE database_name;  |
| List Databases                              | \l                              |
| Leave list of Databases                     | q                               |
| Connect to a Database                       | \c database_name                |
| List Tables in a connected Database         | \dt                             |
| List Users (Roles) in a connected Database  | \du                             |

### SQL (and C.R.U.D.)

**C.R.U.D.** sounds like it should be an 80s punk band - but in Computer Science this acronym represents the four basic functions of [persistent storage](http://en.wikipedia.org/wiki/Persistence_(computer_science)), and stands for **Create, Read, Update and Delete.** These terms are pretty much self-explanatory, but I shall cover each of them in the context of SQL in just a moment.

**SQL** (pronounced "ess-que-el") stands for **Structured Query Language.** It is the most common language used to communicate with modern databases, and there are a handful of basic commands that will stand you in extremely good stead during your career as a Developer. Let us look at those as they apply to the principles of C.R.U.D.

#### Read

So we're going to defy the order of the acronym for a moment, and start with Read (cRud). The reason being, that knowing what's currently in a database is usually advantageous before creating, updating or deleting. The SQL command associated with Reading, is called `SELECT`. Let's say we have connected to a database. Let's take a look at the tables that this database consists of, using the postgres command `\dt`:

```SQL
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

Hmm, now it would be really useful to know what kind of data lives in `links`. Let us invoke the mighty SQL Gods with the following:

```SQL
some_database=# SELECT * FROM links;
```
Hopefully this is relatively easy to read, but basically asks the database to select _everything_ (*) from the table `links`. Let's have a look at what output is generated:

```SQL
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
some_database=# INSERT INTO "links" (TITLE,URL) VALUES ( 'CSS Tricks', 'http://csstricks.com');
```

There are several things to note here.

* We have put `links` in quotation marks. as you can see from when we ran `some_database=# SELECT * FROM "links";` that you can get away without it - however, to use the quotes is best practice so we shall continue hereon in that style.
* Where the column names (fields) are declared, we omit `ID`. This is because `ID` values are automatically generated by SQL and therefore are left out.
* When passing strings to populate the rows (aka records or tuples), we use single quotes. SQL typically reserves double quotes for table names.

Now let's have a look at the contents of table again:

```SQL
some_database=# SELECT * FROM "links";

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
some_database=# UPDATE "links" SET URL = 'http://css-tricks.com' WHERE ID = 3;
UPDATE 1
```
Run another `SELECT` query to see if our changes have taken effect (`UPDATE 1` is a kind of confirmation message, so we can feel fairly confident that _something_ has been updated...)

```SQL
some_database=# SELECT * FROM "links";

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
some_database=# DELETE FROM "links" WHERE ID = 1;
DELETE 1
```
Now let's see what kind of condition `links` is in:

```SQL
some_database=# SELECT * FROM "links";

id |     title      |           url
----+----------------+--------------------------
 2 | Makers Academy | http://makersacademy.com
 3 | CSS Tricks     | http://css-tricks.com
(2 rows)
```

So that's a whirlwind tour of PostgreSQL. Hopefully this should shed some light on what's going on under the hood, and help you appreciate what an ORM like [DataMapper](http://datamapper.org/) gives us in terms of functionality. Always remember to check in with your databases as your projects grow to make sure you are understanding what's really going on in the dark corners of your database! :)

Resources
---------

* http://www.w3schools.com/sql/
* http://blog.jasonmeridth.com/posts/postgresql-command-line-cheat-sheet/

Related Videos
--------------

* [Stephen on Whiteboard (+Mihai)](https://www.youtube.com/watch?v=dIq_E-HSje8)
* [Stephen on Projector (+Sam)](https://www.youtube.com/watch?v=C7EKjnFCyeQ)
* [Enrique on Whiteboard](https://www.youtube.com/watch?v=QlDE4kYzvjU)
