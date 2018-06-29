## Many-to-many relationships

[Back to the Challenge Map](00_challenge_map.md#challenges)

We've built a RESTful CRUD application for managing bookmarks. Users can comment on bookmarks.

> Want to jump in to this challenge? Start from [this commit](https://github.com/sjmog/bookmark_manager/commit/c81305935bf16747f16bb20466d4c75d5e1d667d).

Let's return to our specification:

* Show a list of bookmarks :white_check_mark:
* Add new bookmarks :white_check_mark:
* Delete bookmarks :white_check_mark:
* Update bookmarks :white_check_mark:
* Comment on Bookmarks :white_check_mark:
* Tag bookmarks into categories
* Filter bookmarks by tag
* Users manage their bookmarks

In this challenge, you will set up a **many to many relationship** between Bookmarks a new resource, Tags.

> A many-to-many relationship involves constructing a **join table**, which _belongs to_ more than one model (i.e. it has multiple foreign keys).

## Learning Objectives

* Implement a many-to-many relationship.

## To complete this challenge, you will need to

- [ ] Create a new table for Tags. The columns are:
  - [ ] an auto-incrementing primary key, `id`
  - [ ] a 60-character text field, `content`
- [ ] Create a **join table** for Tags and Bookmarks, called `bookmark_tags`. The columns are:
  - [ ] an auto-incrementing primary key, `id`
  - [ ] a foreign key, `bookmark_id`, which `REFERENCES` the bookmark table.
  - [ ] a foreign key, `tag_id`, which `REFERENCES` the tag table.
- [ ] Allow users to create tags for bookmarks. A tag should have many bookmarks. A bookmark should have many tags. Like comments, users should be able to see all tags given to a bookmark.
- [ ] Unlike comments, users should be able to click on a tag and see only bookmarks tagged with that tag.

## Hints
&nbsp;<details><summary>CLICK ME</summary>
- Again, this challenge has multiple possible solutions, but you'll definitely need to create two new models `Tag` and `BookmarkTag`.
- Whenever you add a new `Tag` to the database, you'll likely need to save a `LinkTag` separately.
- Once you can save links to your database, in order to associate them with particular bookmarks in your views you'll probably want a `bookmark.tags` method which returns a list of all tags belonging to a given bookmark.
- In order to filter by tag, you're also likely to need a `tag.bookmarks` method which returns all the bookmarks belonging to a given tag.
&nbsp;</details>

## Resources

* [SQL for one-to-one and many-to-many relationships](https://stackoverflow.com/questions/7296846/how-to-implement-one-to-one-one-to-many-and-many-to-many-relationships-while-de)
* [How to design a many-to-many relationship](https://dzone.com/articles/how-to-handle-a-many-to-many-relationship-in-datab)

## [Walkthrough](walkthroughs/14.md)
