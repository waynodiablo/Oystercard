Relational Databases
====================

A relational database is one which stores data as a series of 'tables' made of
rows and columns -- like a spreadsheet. The rows represent individual entries in
the database, while the columns represent the fields - the data stored about he
entries. For instance, here's a representation of a user in a relational
database:


|      id | user_name | password | email       |
|---------|-----------|----------|-------------|
|  1      | bob       | 1234     | bob@bob.com |
|  2      | tom       | 5678     | tom@tom.com |
[User]

Relational databases are managed using relational database management systems
(RDBMS), such as PostgreSQL, MySQL and SQL Server.

###SQL

Virtually every relational database in the world uses SQL ('Structured Query
Language' pronounced
'sequel') as the language to query and update the database. Let's use some SQL
to look at this database. We won't be using a real database quite yet. The SQL
command to look at all the rows in this table:

```SQL
SELECT * FROM User;
```

And if we'd like a user 1's email address:

```SQL
SELECT email FROM User WHERE id = 1;
```

SQL is worth looking at - but let's not get bogged down in the details right
now. Let's think about giving these users addresses:

###One-to-One Relationships

We could represent the users addresses like this:

|      id | user_name | password | email       |city | postcode|
|---------|-----------|----------|-------------|-------|-------|
|  1      | bob       | 1234     | bob@bob.com |London|SW1 1DB|
|  2      | tom       | 5678     | tom@tom.com |Wisbech|PE13 2DB|
[User]

But it would be better to make another table for the addresses and set up
a relationship between the two tables. That's the 'relational' in Relational
Database. The Address table might look like this:

| id |  city | postcode |
|---|---|---|
| 27 |London|SW1 1DB|
| 32 |Wisbech|PE13 2DB|
[Address]

And the User table now looks like this:

|      id | user_name | password | email       | address_id |
|---------|-----------|----------|-------------|----------|
|  1      | bob       | 1234     | bob@bob.com |  27 |
|  2      | tom       | 5678     | tom@tom.com |  32 |
[User]

We can take a look at the full information about a user by using a SQL
`INNER JOIN` statement as follows:

```SQL
SELECT * FROM User INNER JOIN Address ON User.address_id = Address.id;
```

This command joins the tables for User and Address, using the `address_id` field
on user to get the matching `id` field on address. Note that if there is no
Address for a user you will not see the user - you're exclusively showing the
data that matches.

###One-to-Many Relationships

Let's say our users are writing blogs. We'd need to save these blogs to the
database -- title, content and all. Were we to store that information on the
User table we'd be looking at something pretty ugly. And wide...

|      id | user_name | password | email       | address_id | blog1_title| blog1_content| blog2_title| blog2_content|
|---------|-----------|----------|-------------|----------|---|---|---|---|
|  1      | bob       | 1234     | bob@bob.com |  27 | my dog| my lovely dog| my cat| my wonderful cat|
|  2      | tom       | 5678     | tom@tom.com |  32 | trees | Lovely trees| Prince| Yay Purple Rain |
[User]

This is bad. We'd have to be adding new fields for each extra blog post, along
with leaving some of the 'cells' for each row blank when there isn't an nth
blog post by a user. Luckily there's a way around this by extracting out
he blog posts to a separate table:

|id | user_id | title | content |
|---|---|---|---|
|1 | 1 | my dog | my lovely dog |
|2 | 2 | trees | Lovely trees |
|3 | 2 | Prince | Yay Purple Rain|
|4 | 1 | my cat | my wonderful cat|
[Blogposts]

This is called a *one-to-many relationship* -- one user can have many blog
posts. You can see that it's handled in the same way as the one-to-one
relationship, although it's even more vital to have the data broken out into
individual tables this time.

Querying this in SQL requires you to join the tables again:

```SQL
SELECT * FROM User LEFT JOIN Blog ON User.id = Address.user_id;
```

The `LEFT JOIN` command returns all the left hand side (User) data, and any
matching right hand side data (Blog). If there is no matching data on the right
you'll just get an empty cell. This will let us see all users - even if they
don't have a blog post.

###Many-to-Many Relationships

This is where things get a little gnarly. Bloggig software often has a way of
tagging each post based on it's content. For instance 'animals', 'cats', 'gardening' and
'diminutive pop-stars' would all be valid tags for Bob and Tom's posts.  The
'animal' tag would apply to both the dog and the cat post, and the cat post
should also be tagged with 'cat'. We might say that a post has many tags, and
a tag has posts. A *many-to-many relationship*.

We could extend out the Blogposts table to display each and every tag for each
post:

|id | user_id | title | content | tag1 | tag2|
|---|---|---|---|---|---|
|1 | 1 | my dog | my lovely dog | animals| |
|2 | 2 | trees | Lovely trees | gardening| |
|3 | 2 | Prince | Yay Purple Rain| diminutive pop-stars| |
|4 | 1 | my cat | my wonderful cat| animals| cats|
[Blogposts]

But we've already seen that this ends in a very long table, and the repetition
of content. It also means that there's no direct relationship between the
tags themselves and the blog posts - we'd have to have to have a Tags table that looked
like this:

|id | tag_name| blog_post_one_id| blog_post_two_id|
|---|---|---|---|
|1 | cats | 4| |
|2 | animals|1 |4 |
|3 | gardening|2 | |
|4 | diminutive pop-stars|3 | |
[Tags]

and then change all the tag fields in the Blogposts table into tag_ids. No fun,
and lots of repetition of information.

We can use the same pattern as seen in one-to-many relationships to fix this
using a *join table*. The join table matches ids of one table to ids in another
table, removing the repetition in each. The join table for the tags would look
like this:

|blog_id|tag_id|
|---|---|
|4| 1|
|4| 2|
|1 |2|
|2 |3|
|3| 4|
[TagsBlogposts]

See how the table doesn't repeat any lines? And how it neatly joins the two
tables? None of the data is now repeated in the other table - we would say that
the database is *normalized* - it has been organized to minimize the redundancy
in the system.

We can verbalize this relationship as something like 'Blogposts has many Tags
*through* TagsBlogposts" and vice versa. To query this in SQL we would join the
two tables *through* the join table each other:

```SQL
SELECT * FROM TagsBlogposts
INNER JOIN Tags ON Tags.id = TagsBlogposts.blog_id
INNER JOIN Blogposts ON Blogposts.id = TagsBlogposts.tag_id;
```

(You can write SQL statements across many lines - but they must always end in
a semi-colon). This query will return all the data about Tags and their related
Blogposts. Note that you don't need to make a join table when the two tables are
linked through a pre-existing table.

###ORMs

In the past when you wanted to query a RDBMS from your program you may have had
to construct SQL queries as a string to send to the database, and then parse the
response into something your program can work with -- like an object. The
inefficiencies of this should be obvious -- you have to know and translate
between two different languages.

This operation is so frequent that libraries have been written for (almost)
every language to relate an object oriented programming language to a relational
database. These libraries are called Object Relational Mappers (ORMs), and you
will do much of your work with databases using them.

###But... SQL

SQL was invented in 1970 and is still being used today, long after every other
language around in the 70s has fallen by the wayside. While it's definitely
not a cool language, or even very pretty, it's efficient and good at what
it does, and a useful tool. When your database falls apart, it's good to have
some SQL
