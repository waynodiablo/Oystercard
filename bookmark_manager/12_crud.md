## CRUD

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a database-enabled MVC Sinatra application with test and development environments. Bookmarks show on the homepage as a list of clickable anchors to the linked website, nicely titled.

Let's return to our specification:

* Show a list of bookmarks :white_check_mark:
* Add new bookmarks :white_check_mark:
* Delete bookmarks
* Update bookmarks
* Comment on bookmarks
* Tag bookmarks into categories
* Filter bookmarks by tag
* Users manage their bookmarks

In this challenge, you will add functionality to **delete** and **update** bookmarks.

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

##Hints

- You'll likely need to write the methods `Bookmark.delete` and `Bookmark.update`.  First however, you'll probably want a `Bookmark.find` method in order to retrieve the specific Bookmark you want to perform one of those actions on.
- You could make use of the [SQL WHERE keyword](https://www.w3schools.com/sql/sql_where.asp) to retrieve the correct Bookmark.
- In order to keep your routes RESTful, you may want to make use of Sinatra's [named parameters](http://sinatrarb.com/intro.html)

## Resources

* [CRUD (Wikipedia)](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)
* [:pill: REST](../pills/rest.md)

## [Walkthrough](walkthroughs/12.md)
