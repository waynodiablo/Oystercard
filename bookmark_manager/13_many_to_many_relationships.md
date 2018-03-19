## Many-to-many relationships

[Back to the Challenge Map](00_challenge_map.md)

We've built a RESTful CRUD application for managing links. Users can comment on links.

> Want to jump in to this challenge? Start from [this commit](https://github.com/sjmog/bookmark_manager/commit/c81305935bf16747f16bb20466d4c75d5e1d667d).

Let's return to our specification:

* Show a list of links :white_check_mark:
* Add new links :white_check_mark:
* Delete links :white_check_mark:
* Update links :white_check_mark:
* Comment on Links :white_check_mark:
* Tag links into categories
* Filter links by tag
* Users manage their links

In this challenge, you will set up a **many to many relationship** between Links a new resource, Tags.

> A many-to-many relationship involves constructing a **join table**, which _belongs to_ more than one model (i.e. it has multiple foreign keys).

## Learning Objectives

* Implement a many-to-many relationship.

## To complete this challenge, you will need to

- [ ] Create a new table for Tags. The columns are:
  - [ ] an auto-incrementing primary key, `id`
  - [ ] a 60-character text field, `content`
- [ ] Create a **join table** for Tags and Links, called `link_tags`. The columns are:
  - [ ] an auto-incrementing primary key, `id`
  - [ ] a foreign key, `link_id`, which `REFERENCES` the link table.
  - [ ] a foreign key, `tag_id`, which `REFERENCES` the tag table.
- [ ] Allow users to create tags for links. A tag should have many links. A link should have many tags. Like comments, users should be able to see all tags given to a link.
- [ ] Unlike comments, users should be able to click on a tag and see only links tagged with that tag.

> `link.tags` should give a list of all the tags that belong to this link.
> `tag.links` should give a list of all the links that belong to this tag.

## Resources

* [SQL for one-to-one and many-to-many relationships](https://stackoverflow.com/questions/7296846/how-to-implement-one-to-one-one-to-many-and-many-to-many-relationships-while-de)
* [How to design a many-to-many relationship](https://dzone.com/articles/how-to-handle-a-many-to-many-relationship-in-datab)

## [Walkthrough](walkthroughs/17.md)
