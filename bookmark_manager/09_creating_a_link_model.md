## Creating a Link model

[Back to the Challenge Map](0_challenge_map.md)

You have the error "uninitialized constant Link". Let's think about what a Link is.

We know that links need to be saved (persisted) somewhere and that we want to use a database. So we want our Link class to somehow map to a database...

In this challenge you'll create your "model" using a Ruby class and DataMapper

## Learning Objectives covered

* Embellish a ruby class so that it's persisted into a database via DataMapper (!!!New LO)
* Construct a data schema within a Ruby model
* Knowing where to place models in a Sinatra application (!!!New LO)

## To complete this challenge, you will need to

- [ ] Discuss with your pair partner what a "model" is and how it relates to a class or table/relation
- [ ] Create a 'links' table in Postgres in a 'bookmark_manager_test' database
- [ ] Create a model (DataMapper backed ruby class) in `app/models/link.rb` with `:id`, `:title` and `:url` properties
- [ ] Ensure that you have a new error related to visiting the links page

## Resources

* [DataMapper Getting Started](http://datamapper.org/getting-started.html)

## [Solution](solutions/09.md)
