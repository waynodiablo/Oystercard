## CRUD

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a database-enabled MVC Sinatra application with test and development environments. Bookmarks show on the homepage as a list of clickable anchors to the linked website, nicely titled.

Let's return to our specification:

* Show a list of bookmarks :white_check_mark:
* Add new bookmarks :white_check_mark:
* Delete bookmarks :construction:
* Update bookmarks
* Comment on bookmarks
* Tag bookmarks into categories
* Filter bookmarks by tag
* Users manage their bookmarks

In this challenge, you will add functionality to **delete** bookmarks.

## Learning Objectives

* Implement deleting bookmarks

## Challenge Setup

There are generally four actions you can take with persistent data:

- **Creating** data
- **Reading** data
- **Updating** data
- **Deleting** data

These are usually abbreviated to the acronym **CRUD**. a CRUD application is one that creates, reads, updates, and deletes data. The majority of web applications are, essentially, CRUD applications.

Remember to maintain RESTful routing conventions.

## To complete this challenge, you will need to

- [ ] Complete the 'delete bookmarks' requirement.

## Hints
&nbsp;<details><summary>CLICK ME</summary>
- You'll likely need to write the method `Bookmark.delete`.  
- You could make use of the [SQL DELETE keyword](https://www.w3schools.com/sql/sql_delete.asp) to delete the correct bookmark.
- In order to keep your routes RESTful, you may want to make use of Sinatra's [named parameters](http://sinatrarb.com/intro.html) - you'll need to need to enable `method_override` to use this feature.
&nbsp;</details>

## Resources

* [CRUD (Wikipedia)](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)
* [:pill: REST](../pills/rest.md)
* [Difference between TRUNCATE and DROP TABLE](https://stackoverflow.com/questions/135653/difference-between-drop-table-and-truncate-table)
* [Sinatra Configuation for method override](http://sinatrarb.com/configuration.html)
* [REST-ful routes in Sinatra](https://learn.co/lessons/sinatra-restful-routes-readme)
* [PostgreSQL Cheat Sheet](http://www.postgresqltutorial.com/postgresql-cheat-sheet/)
* [Capybara Cheat Sheet](https://gist.github.com/cmkoller/0d3b048b3c4b48ee4955)

## [Walkthrough](walkthroughs/12.md)
