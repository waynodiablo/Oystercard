## One-to-many Relations

[Back to the Challenge Map](00_challenge_map.md)

We've built a CRUD application for managing links. The routes are RESTful.

> Want to jump in to this challenge? Start from [this commit](https://github.com/sjmog/bookmark_manager/commit/58da0fff8056009c83c848a3eb21c757ae4017de).

Let's return to our specification:

* Show a list of links :white_check_mark:
* Add new links :white_check_mark:
* Delete links :white_check_mark:
* Update links :white_check_mark:
* Comment on Links
* Tag links into categories
* Filter links by tag
* Users manage their links

In this challenge, you will set up a **one to many relationship** between Links a new resource, Comments.

## Learning Objectives

* Implement a one-to-many relationship.

## To complete this challenge, you will need to

- [ ] Create a new table for Comments. The columns are: 
  - [ ] an auto-incrementing primary key, `id`
  - [ ] a 240-character text field, `text`
  - [ ] a foreign key, `link_id`, which `REFERENCES` the link table.
- [ ] Allow users to create comments on links.
- [ ] Display those comments below each link.

> `link.comments` should give a list of all the comments.

## Resources

* [One-to-many relationships](http://www.databaseprimer.com/pages/relationship_1tox/)

## [Walkthrough](walkthroughs/16.md)
