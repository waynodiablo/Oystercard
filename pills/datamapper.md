DataMapper
=========

## Adding the database

For instructions on how to install your database (and learn some basic interactions via SQL) please [visit the PostgreSQL pill.](../pills/postgres.md)

## Talking to the database with Ruby
So now we have a database running on our machine, how do we talk to it from Ruby?  We could start by looking for some low-level ruby libraries that allow us to interact directly with our database.  For example, libraries that allow enable us to execute `SELECT` statements to retrieve rows of data from our tables. We could then work out how to convert this data into Ruby objects that we can use in our code.  And that would be a _lot_ of work.  Fortunately, this is a problem that has been solved many times before; what we need is an Object-Relational Mapper (ORM).

We'll be using an ORM called [DataMapper](../pills/datamapper.md).  DataMapper serves as a bridge between our Ruby classes and the database.  It allows us to define mappings between our classes and tables declaratively using a DSL.  Datamapper then handles all the necessary communication with the database to create, read, update and delete our data.

DataMapper can be used with a variety of database engines, including postgres.  For each database, there is an **adapter**. We'll need to install the adapter to work with postgres. Add these gems to your Gemfile:


```ruby
gem 'data_mapper'
gem 'dm-postgres-adapter'
```
Then, add this code to ```data_mapper_setup.rb```:

```ruby
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './app/link' # require each model individually - the path may vary depending on your file structure.

# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!
```
Require this file near the top of your main application file - until this file is required, your app will not be able to access the database.

So, we begin by telling datamapper where our database is going to be. The second argument to setup() is called a connection string. It has the following format.

`dbtype://user:password@hostname:port/databasename`

By default Postgres.app is configured to accept connections from a logged in user without the password, so we omit them. Since postgres is running on the default port 5432, it doesn't have to be specified either.

After we require our models, datamapper will know what data schema we have in our project (because we include DataMapper::Resource in every model). After the models are finalised (checked for consistency), we can ask datamapper to create the tables.

However, datamapper will not create the database for us. We need to do it ourselves.

In the terminal run psql to connect to your database server.

Psql is a text-based interface to talk to the database, much like irb is used to run Ruby code. We need to create both the local databases we need using SQL commands - here is an example from the Bookmark Manager tutorial:

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1379937867691_Screen%20Shot%202013-09-23%20at%2012.44.14.png "terminal")

Finally, type
`\q`
to exit psql.

Now we have everything we need to use datamapper in our code.

Resources
--------

* http://datamapper.org/
* https://github.com/datamapper
* https://github.com/DatabaseCleaner/database_cleaner
* http://stackoverflow.com/questions/10904996/difference-between-truncation-transaction-and-deletion-database-strategies


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/datamapper.md)
