## Wrapping Database data in Program Objects

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a database-enabled MVC Sinatra application with test and development environments.

At the moment, when we use `Bookmark.all` to get bookmarks from the database, we just return an array of strings.

In this challenge, you will add a `title` column to the `bookmarks` table, and display it on the homepage instead of the link URL. To do this, you will need to **wrap database data in a Ruby object**.

## Learning Objectives

* Map objects across systems.

## Challenge Setup

A normal connection between a database and an application mode works in this way:

- Bring database data from database rows into your Ruby application.
- Wrap that data in Ruby objects (models).
- Ask a model to do things with the data it wraps.

> 'Do things' could include: just expose the data directly (for instance, a `Bookmark` just exposes its `url`), or use it in some way (for instance, an `Exam` might have an `average` method which does some calculation with scores stored as columns in the database).

For instance, let's imagine we're building a blog, which is a list of posts. The database for the blog has the following `posts` table:

```
| id | title                         |
|----|-------------------------------|
| 1  | The team is the thing         |
| 2  | Shovels make me sad           |
| 3  | What is the 'simplest thing'? |
```

Wrapping each row in a Ruby object allows me to access each post in my application as an instance of the `Post` class. Then, I can query each post: for instance, I could ask for `post.id`, `post.title`, or more complicated things like `post.word_count`.

The `Post` class would, in this case, _wrap_ the data in each row of the table, and provide a thin layer of logic on top of that data (for instance, logic for calculating the `word_count`).

> This pattern of accessing data from a database and wrapping it is sometimes called the 'Object-Relational Map (ORM) Pattern'.

## To complete this challenge, you will need to

- [ ] Update the `index.erb` view to show Bookmark titles instead of Bookmark URLs.
  - [ ] Users should be able to give this `title` when they create the bookmark.
  - [ ] Clicking a link in the list should open the `url` of the bookmark.

## Hints

#### Returning objects that respond to `#id`, `#title` and `#url` from database queries

You may want to update the `Bookmark.create` and `Bookmark.all` methods to return instances of the `Bookmark` class instead of strings. The instance should wrap and expose the attributes `id`, `title` and `url`.

In your `Bookmark.create` method you can use the PostgreSQL keyword `RETURNING` to ask a query to return specific values and pass them into your Bookmark's initialize method.

Read more about the use of `RETURNING` in the document linked to below.

#### Testing for Bookmark equality

You need to decide what makes two bookmarks 'the same' bookmark. You might pick two bookmarks that have the same URL. Or you might pick what your database picks – that two bookmarks are 'the same' if they have the same ID.

Either way, you can set what Ruby considers to be equal by defining your own `==` method on an object. For instance:

```ruby
# true if Bookmark defines its own == method, false otherwise.
Bookmark.new(1) == Bookmark.new(1)
```

## Resources

* [What is an ORM?](https://stackoverflow.com/questions/1152299/what-is-an-object-relational-mapping-framework)
* [PostgreSQL RETURNING](https://www.postgresql.org/docs/9.5/static/dml-returning.html)

## [Walkthrough](walkthroughs/11.md)
