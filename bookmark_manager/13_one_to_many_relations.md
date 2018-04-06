## One-to-many Relations

[Back to the Challenge Map](00_challenge_map.md)

We've built a CRUD application for managing bookmarks.

> Want to jump in to this challenge? Start from [this commit](https://github.com/sjmog/bookmark_manager/commit/58da0fff8056009c83c848a3eb21c757ae4017de).

Let's return to our specification:

* Show a list of bookmarks :white_check_mark:
* Add new bookmarks :white_check_mark:
* Delete bookmarks :white_check_mark:
* Update bookmarks :white_check_mark:
* Comment on bookmarks :construction:
* Tag bookmarks into categories
* Filter bookmarks by tag
* Users manage their bookmarks

In this challenge, you will set up a [one to many relationship](http://www.databaseprimer.com/pages/relationship_1tox/) between Bookmarks and a new resource, Comments (each _individual_ bookmark can have _many_ comments).

## Learning Objectives

* Implement a one-to-many relationship

## To complete this challenge, you will need to

- [ ] Create a new table for Comments. The columns are:
  - [ ] an auto-incrementing primary key, `id`
  - [ ] a 240-character text field, `text`
  - [ ] a foreign key, `bookmark_id`, which `REFERENCES` the bookmarks table.
- [ ] Allow users to create comments on bookmarks.
- [ ] Display those comments below each bookmark.

> `bookmark.comments` should give a list of all the comments.

## Resources

* [One-to-many relationships](http://www.databaseprimer.com/pages/relationship_1tox/)

## [Walkthrough](walkthroughs/13.md)
