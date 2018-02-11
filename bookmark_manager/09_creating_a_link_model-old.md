## Creating a Link model

[Back to the Challenge Map](00_challenge_map.md)

You have now built a feature test checking that you can read data from the database. At the moment, it's failing, because you don't have a `Link` class.

Additionally, we know that `Link`s need to be persisted to a database.

In this challenge, you will construct a `Link` **model** that uses the Datamapper ORM to map to a database table.

## Learning Objectives covered

* Add DataMapper functionality to a Ruby class
* Use DataMapper's DSL to construct a data schema within a Ruby model
* Know where to place models in a Sinatra application

## To complete this challenge, you will need to

- [ ] Discuss with your pair partner what a "model" is and how it relates to a class or table/relation
- [ ] Create a `Link` model that uses Datamapper in `app/models/link.rb` with `:id`, `:title` and `:url` properties
- [ ] Create a database called 'bookmark_manager_test'
- [ ] At the bottom of `app/models/link.rb`, instruct DataMapper to:
  - [ ] setup a connection to the `bookmark_manager_test` database
  - [ ] `finalize` your DataMapper model
  - [ ] `upgrade` the database with any new properties
- [ ] Run your feature test again.

## Resources

* [DataMapper Getting Started](http://datamapper.org/getting-started.html)

## [Walkthrough](walkthroughs/09.md)
