## CRUD

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a database-enabled MVC Sinatra application with test and development environments. Bookmarks show on the homepage as a list of clickable anchors to the linked website, nicely titled.

Let's return to our specification:

* Show a list of bookmarks :white_check_mark:
* Add new bookmarks :white_check_mark:
* Delete bookmarks :white_check_mark:
* Update bookmarks :construction:
* Comment on bookmarks
* Tag bookmarks into categories
* Filter bookmarks by tag
* Users manage their bookmarks

In this challenge, you will add functionality to **update** bookmarks.

## Learning Objectives

* Create a CRUD system.

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
- [ ] Complete the 'update bookmarks' requirement.

## Hints
&nbsp;<details><summary>CLICK ME</summary>
- You'll likely need to write the methods `Bookmark.delete` and `Bookmark.update`.  
- You'll probably want a `Bookmark.find` method in order to retrieve the specific Bookmark you want to update.
- You could make use of the [SQL WHERE keyword](https://www.w3schools.com/sql/sql_where.asp) to retrieve the correct Bookmark.
- In order to keep your routes RESTful, you may want to make use of Sinatra's [named parameters](http://sinatrarb.com/intro.html) - you'll need to need to enable `method_override` to use this feature.
- If the feature tests are failing because there is no bookmark with an `id` of `1`, this might be because of how you are cleaning the database between your tests. Check to see whether you are using `TRUNCATE` or `DROP TABLE`. The resources below includes an explanation of the differences between these actions.
&nbsp;</details>

## Resources

* [CRUD (Wikipedia)](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)
* [:pill: REST](../pills/rest.md)
* [Difference between TRUNCATE and DROP TABLE](https://stackoverflow.com/questions/135653/difference-between-drop-table-and-truncate-table)
* [Sinatra Configuation for method override](http://sinatrarb.com/configuration.html)
* [REST-ful routes in Sinatra](https://learn.co/lessons/sinatra-restful-routes-readme)
* [PostgreSQL Cheat Sheet](http://www.postgresqltutorial.com/postgresql-cheat-sheet/)
* [Capybara Cheat Sheet](https://gist.github.com/cmkoller/0d3b048b3c4b48ee4955)

## [Walkthrough](walkthroughs/13.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/bookmark_manager/13_crud.md)
