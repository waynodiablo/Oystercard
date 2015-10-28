## Creating Links

[Back to the Challenge Map](00_challenge_map.md)

By now we have a web application that allows us to add new links to the database and show the entire list on the front page. We have feature tests that give us comfort that if something breaks, we'll know about it straight away.

In this challenge you will implement a new feature: allowing links to have tags associated with them.

```
As a time-pressed user
So that I can organise my many links into different categories for ease of search
I would like to tag links in my bookmark manager
```

## Learning Objectives covered

* Create a many-to-many relationship between models
* Use incoming params to persist models to a database
* Extract configuration to its own file
* Create a bookmark manager that interacts with a database

## To complete this challenge, you will need to

- [ ] Create a failing feature test for adding a single tag to a Link with Capybara
- [ ] Amend the new link form to allow for adding a tag.
- [ ] Create a many-to-many relation to tags:
  - [ ] Create a Tag model
  - [ ] Refactor the DataMapper configuration into a separate `data_mapper_setup.rb` file
- [ ] Adjust the controller so that new tags are added to the Link as it is created.
- [ ] Deploy and confirm everything is running fine on Heroku

## Resources

* [DataMapper associations](http://datamapper.org/docs/associations.html)
* [Database relations - Pill](https://github.com/makersacademy/course/blob/master/pills/relational_SQL_DBs.md)
* [DataMapper collection documentation](http://www.rubydoc.info/github/datamapper/dm-core/master/DataMapper/Collection)

## [Solution](solutions/15.md)
