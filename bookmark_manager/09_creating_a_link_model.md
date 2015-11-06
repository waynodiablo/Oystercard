## Creating a Link model

[Back to the Challenge Map](00_challenge_map.md)

You have the error "uninitialized constant Link". Let's think about what a Link is.

We know that links need to be saved (persisted) somewhere and that we want to use a database. So we want our Link class to map to a database.

In this challenge you'll create your "model" using a Ruby class and DataMapper

## Learning Objectives covered

* Add DataMapper functionality to a Ruby class
* Use DataMapper's DSL to construct a data schema within a Ruby model
* Know where to place models in a Sinatra application

## To complete this challenge, you will need to

- [ ] Discuss with your pair partner what a "model" is and how it relates to a class or table/relation
- [ ] Create a model (DataMapper backed ruby class) in `app/models/link.rb` with `:id`, `:title` and `:url` properties
- [ ] At the bottom of `link.rb`, instruct DataMapper to:
  - [ ] setup a connection to the `bookmark_manager_test` database
  - [ ] finalize your DataMapper model
  - [ ] update your DataMapper models
- [ ] Ensure that you have a new error related to visiting the links page

## Resources

* [DataMapper Getting Started](http://datamapper.org/getting-started.html)

## [Solution](solutions/09.md)
