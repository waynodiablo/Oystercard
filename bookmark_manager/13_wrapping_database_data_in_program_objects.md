## Wrapping Database data in Program Objects

[Back to the Challenge Map](00_challenge_map.md)

We've built a database-enabled MVC Sinatra application with test and development environments, validations, and a Rake task for setting it up.

At the moment, when we use `Link.all` to get links from the database, we just return an array of strings.

In this challenge, you will add a `title` column to the `links` table, and display it on the homepage instead of the link URL. To do this, you will need to **wrap database data in a Ruby object**.

## Challenge Setup

A normal connection between a database and an application mode works in this way:

- Bring database data from database rows into your Ruby application.
- Wrap that data in Ruby objects (models).
- Ask a model to do things with the data it wraps.

> 'Do things' could include: just expose the data directly (for instance, a `Link` just exposes its `url`), or use it in some way (for instance, an `Exam` might have an `average` method which does some calculation with scores stored as columns in the database).

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

- [ ] Update the `Link.all` method to return an array of instances of the `Link` class instead of URL strings. Each `Link` instance should wrap and expose the attributes `id` and `url`. Update the tests, too.
- [ ] Update the `index.erb` view to display the titles of Links instead of the Link URL. Clicking a link in the list should open a new browser window (or tab) with the URL of the link as the URL of the tab.
- [ ] Update the new link form with the ability to add a title to Links.
- [ ] Ensure all your tests are passing.

## Resources

* [What is an ORM?](https://stackoverflow.com/questions/1152299/what-is-an-object-relational-mapping-framework)

## [Walkthrough](walkthroughs/13.md)
