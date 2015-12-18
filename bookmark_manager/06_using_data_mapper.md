## Using DataMapper

[Back to the Challenge Map](00_challenge_map.md)

You should now see how it's possible to manipulate database data using SQL. However, we're having to write out syntactically difficult and unfamiliar SQL to perform basic read / write commands. This is where DataMapper comes in. DataMapper allows us to deal with our database via a Ruby interface. In this challenge you'll use DataMapper to manipulate a database table using ruby commands.

## Learning Objectives covered

* Define DataMapper as a gem for interacting with a database in Ruby ('models')
* Configure DataMapper to use a Postgres database
* Include DataMapper in a ruby class so that it can be persisted into a database
* Construct a data schema within a Ruby **model**

## To complete this challenge, you will need to

- [ ] Create a new project including the "data_mapper" and "dm-postgres-adapter" gems
- [ ] Connect with `psql` and create a database called `datamapper_play`
- [ ] Start an IRB session and require the "data_mapper" and "dm-postgres-adapter" gems
- [ ] Setup DataMapper to *connect* to the `datamapper_play` database
- [ ] Turn on DataMapper's error logging
- [ ] Create a `Student` model in IRB:
  - [ ] Declare a `Student` class and include the module `DataMapper::Resource`.
  - [ ] Give the `Student` model the properties `id` and `name`.
- [ ] Create an entry in your student table from within IRB
- [ ] Delete that new student from within IRB

## Resources

* [DataMapper Getting Started](http://datamapper.org/getting-started.html)
* [DataMapper CRUD operations](http://datamapper.org/docs/create_and_destroy.html)
* [DataMapper Website](http://datamapper.org/)
* [DataMapper Overview, Setup & Configuration](http://www.rubydoc.info/github/datamapper/dm-core/DataMapper)
* [Finish DataMapper Model Setup ](http://www.rubydoc.info/github/datamapper/dm-core/DataMapper/Model#finalize-instance_method)

## [Solution](solutions/06.md)
