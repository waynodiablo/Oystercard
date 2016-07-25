## Using DataMapper

[Back to the Challenge Map](00_challenge_map.md)

We've built a database, added a database table, and played with some data in that table. To do all of this, we used the command-line program `psql`, and a bunch of SQL code.

Reading and writing data from and to a database using SQL is a painful thing to do. SQL isn't a great language for programmers to interact with data: it's cumbersome and abstract.

In this challenge, you will do all the interactions with a database you just did in SQL, using an **Object-Relational Map** (**ORM**). You will use **DataMapper** as your ORM.

## Challenge Setup

ORMs translate between two 'object models'. In this case, DataMapper will translate between Ruby objects: classes, instances, instance variables, and so on; and database objects: tables, rows, and columns.

Basically, you can use DataMapper to interact with a database using Ruby, instead of the finicky SQL.

## Learning Objectives covered

* Define DataMapper as a gem for interacting with a database in Ruby ('models')
* Configure DataMapper to use a Postgres database
* Include DataMapper in a ruby class so that it can be persisted into a database
* Construct a data schema within a Ruby **model**

## To complete this challenge, you will need to

- [ ] Create a new Ruby project including the `data_mapper` and `dm-postgres-adapter` gems.
- [ ] Create a database called `datamapper_play` using `psql`.
- [ ] Start `irb`, and require the ORM gems from step 1.
- [ ] In `irb`, set up DataMapper to *connect* to the `datamapper_play` database.
- [ ] In `irb`, turn on DataMapper's error logging.
- [ ] In `irb`, create a `Student` class, and include the DataMapper ORM inside it:
  - [ ] Declare a `Student` class and include the module `DataMapper::Resource`.
  - [ ] Give the `Student` class the properties `id` and `name`.
- [ ] In `irb`, use the `Student` class you built to create an entry in your `students` table.
- [ ] In `irb`, use the `Student` class you built to delete that new student.

## Resources

* [Introduction to Datamapper _1hr video by Makers_] (https://vimeo.com/112068478)
* [Associations in Datamapper _1hr video by Makers_] (https://vimeo.com/112158606) 
* [DataMapper Getting Started](http://datamapper.org/getting-started.html)
* [DataMapper CRUD operations](http://datamapper.org/docs/create_and_destroy.html)
* [DataMapper Website](http://datamapper.org/)
* [DataMapper Overview, Setup & Configuration](http://www.rubydoc.info/github/datamapper/dm-core/DataMapper)
* [Finish DataMapper Model Setup ](http://www.rubydoc.info/github/datamapper/dm-core/DataMapper/Model#finalize-instance_method)

## [Walkthrough](walkthroughs/06.md)
