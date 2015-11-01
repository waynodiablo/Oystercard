## Using DataMapper

[Back to the Challenge Map](0_challenge_map.md)

You should now see how it's possible to manipulate database data using SQL. There is a problem emerging here, however: we're having to write out syntactically difficult and unfamiliar SQL commands to perform basic read / write commands. This is where DataMapper comes it. DataMapper allows us to deal with our database from a distance via a Ruby interface. In this challenge you'll use DataMapper to manipulate a database table using ruby commands.

## Learning Objectives covered

* Define DataMapper as a gem for including persistence functionality in Ruby classes ('models')
* Configure DataMapper to use a Postgres database
* Embellish a ruby class so that it's persisted into a database via DataMapper (!!!New LO)
* Construct a data schema within a Ruby model

## To complete this challenge, you will need to

- [ ] Create a new project including the "data_mapper" and "dm-postgres-adapter" gems
- [ ] Start an IRB session using those gems
- [ ] Setup DataMapper to use the local postgres database
- [ ] Set Logger level to `:debug`
- [ ] Create a student model in IRB that is DataMapper enabled
- [ ] Create a database entry (new student) from IRB
- [ ] Delete that new student from IRB

## Resources

* [DataMapper Getting Started](http://datamapper.org/getting-started.html)
* [DataMapper CRUD operations](http://datamapper.org/docs/create_and_destroy.html)
* [DataMapper Website](http://datamapper.org/)
* [Finish DataMapper Model Setup ](http://www.rubydoc.info/github/datamapper/dm-core/DataMapper/Model#finalize-instance_method)

## [Solution](solutions/06.md)
