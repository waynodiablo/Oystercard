Relationships between tables in a database
====================

A relational database is one which stores data as a series of 'tables' made of
rows and columns -- like a spreadsheet. The rows represent individual entries in
the database, while the columns represent the fields - the data stored about the
entries. For instance, here's a representation of a user in a relational
database:

<table>
  <thead>
    <tr>
      <td colspan="4" align="center"><i>User</i></td>
    </tr>
    <tr>
      <th>id</th>
      <th>user_name</th>
      <th>password</th>
      <th>email</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1</td>
      <td>bob</td>
      <td>1234</td>
      <td>bob@bob.com</td>
    </tr>
    <tr>
      <td>2</td>
      <td>tom</td>
      <td>5678</td>
      <td>tom@tom.com</td>
    </tr>
  </tbody>
</table>

Relational databases are managed using relational database management systems
(RDBMS), such as PostgreSQL, MySQL and SQL Server.

### One-to-One Relationships

We could represent the users addresses like this:

User v2

|      id | user_name | password | email       |city | postcode|
|---------|-----------|----------|-------------|-------|-------|
|  1      | bob       | 1234     | bob@bob.com |London|SW1 1DB|
|  2      | tom       | 5678     | tom@tom.com |Wisbech|PE13 2DB|

But it would be better to make another table for the addresses and set up
a relationship between the two tables. That's the 'relational' in Relational
Database. The Address table might look like this:

Address v1

| id |  city | postcode |
|---|---|---|
| 27 |London|SW1 1DB|
| 32 |Wisbech|PE13 2DB|

And the User table now looks like this:

User v3

|      id | user_name | password | email       | address_id |
|---------|-----------|----------|-------------|----------|
|  1      | bob       | 1234     | bob@bob.com |  27 |
|  2      | tom       | 5678     | tom@tom.com |  32 |

We can take a look at the full information about a user by using a SQL
`INNER JOIN` statement as follows:

```SQL
SELECT * FROM User INNER JOIN Address ON User.address_id = Address.id;
```

This command joins the tables for User and Address, using the `address_id` field
on user to get the matching `id` field on address. Note that if there is no
Address for a user you will not see the user - you're exclusively showing the
data that matches.

### One-to-Many Relationships

Let's say our users are writing blogs. We'd need to save these blogs to the
database -- title, content and all. Were we to store that information on the
User table we'd be looking at something pretty ugly. And wide...

User v4

|      id | user_name | password | email       | address_id | blog1_title| blog1_content| blog2_title| blog2_content|
|---------|-----------|----------|-------------|----------|---|---|---|---|
|  1      | bob       | 1234     | bob@bob.com |  27 | my dog| my lovely dog| my cat| my wonderful cat|
|  2      | tom       | 5678     | tom@tom.com |  32 | trees | Lovely trees| Prince| Yay Purple Rain |


This is bad. We'd have to be adding new fields for each extra blog post, along
with leaving some of the 'cells' for each row blank when there isn't an nth
blog post by a user. Luckily there's a way around this by extracting out
the blog posts to a separate table:

Blogposts v1

|id | user_id | title | content |
|---|---|---|---|
|1 | 1 | my dog | my lovely dog |
|2 | 2 | trees | Lovely trees |
|3 | 2 | Prince | Yay Purple Rain|
|4 | 1 | my cat | my wonderful cat|

This is called a *one-to-many relationship* -- one user can have many blog
posts. You can see that it's handled in the same way as the one-to-one
relationship, although it's even more vital to have the data broken out into
individual tables this time.

Querying this in SQL requires you to join the tables again:

```SQL
SELECT * FROM User LEFT JOIN Blog ON User.id = Blog.user_id;
```

The `LEFT JOIN` command returns all the left hand side (User) data, and any
matching right hand side data (Blog). If there is no matching data on the right
you'll just get an empty cell. This will let us see all users - even if they
don't have a blog post.

### Many-to-Many Relationships

This is where things get a little gnarly. Blogging software often has a way of
tagging each post based on its content. For instance 'animals', 'cats', 'gardening' and
'diminutive pop-stars' would all be valid tags for Bob and Tom's posts.  The
'animal' tag would apply to both the dog and the cat post, and the cat post
should also be tagged with 'cat'. We might say that a post has many tags, and
a tag has posts. A *many-to-many relationship*.

We could extend out the Blogposts table to display each and every tag for each
post:

Blogposts v2

|id | user_id | title | content | tag1 | tag2|
|---|---|---|---|---|---|
|1 | 1 | my dog | my lovely dog | animals| |
|2 | 2 | trees | Lovely trees | gardening| |
|3 | 2 | Prince | Yay Purple Rain| diminutive pop-stars| |
|4 | 1 | my cat | my wonderful cat| animals| cats|

But we've already seen that this ends in a very long table, and the repetition
of content. It also means that there's no direct relationship between the
tags themselves and the blog posts - we'd have to have a Tags table that looked
like this:

Tags v1

|id | tag_name| blog_post_one_id| blog_post_two_id|
|---|---|---|---|
|1 | cats | 4| |
|2 | animals|1 |4 |
|3 | gardening|2 | |
|4 | diminutive pop-stars|3 | |

and then change all the tag fields in the Blogposts table into tag_ids. No fun,
and lots of repetition of information.

We can use the same pattern as seen in one-to-many relationships to fix this
using a *join table*. The join table matches ids of one table to ids in another
table, removing the repetition in each. The join table for the tags would look
like this:

TagsBlogposts

|blog_id|tag_id|
|---|---|
|4| 1|
|4| 2|
|1 |2|
|2 |3|
|3| 4|

See how the table doesn't repeat any lines? And how it neatly joins the two
tables? None of the data is now repeated in the other table - we would say that
the database is *normalized* - it has been organized to minimize the redundancy
in the system.

We can verbalize this relationship as something like 'Blogposts has many Tags
*through* TagsBlogposts" and vice versa. To query this in SQL we would join the
two tables *through* the join table each other:

```SQL
SELECT * FROM TagsBlogposts
INNER JOIN Tags ON Tags.id = TagsBlogposts.tag_id
INNER JOIN Blogposts ON Blogposts.id = TagsBlogposts.blog_id;
```

(You can write SQL statements across many lines - but they must always end in
a semi-colon). This query will return all the data about Tags and their related
Blogposts. Note that you don't need to make a join table when the two tables are
linked through a pre-existing table.


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/db_relationships.md)
