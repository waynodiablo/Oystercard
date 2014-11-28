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

SQL
---

Virtually every relational database in the world uses SQL (pronounced
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
a relationship between the two tables. That's the 'relational' in Relational Database. The Address table might look like this:

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
blog post by a user. Luckily there's a great way around this by extracting out
he blog posts to a seperate table:

|id | user_id | title | content |
|---|---|---|---|
|1 | 1 | my dog | my lovely dog |
|2 | 2 | trees | Lovely trees |
|3 | 2 | Prince | Yay Purple Rain|
|4 | 1 | my cat | my wonderful cat|
[Blogposts]

