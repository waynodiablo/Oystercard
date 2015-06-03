DataMapper
=========

:construction: UNDER CONSTRUCTION :construction:

[DataMapper](http://datamapper.org/) is an ORM (Object-relational mapper), which means that it provides a convenient way to interact with our data using classes and objects instead of working with database tables directly. DataMapper serves as a bridge between Ruby and SQL.  It allows us to query a SQL database using ruby commands, and have the results from the SQL queries transformed into Ruby objects.

We will be using postgres databases during the course, however DataMapper can be configured to use many different databases. This implies that we'll need to install an adapter to work with postgres, as well as the datamapper gem itself. Add these gems to your Gemfile:

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

Psql is a text-based interface to talk to the database, much like irb is used to run Ruby code. Let's create both databases we need using SQL commands.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1379937867691_Screen%20Shot%202013-09-23%20at%2012.44.14.png "terminal")

Finally, type
`\q`
to exit psql.

Now we have everything we need to use datamapper in our code. Let's see how we could do it by writing an RSpec test.

**RSpec demonstration**

First, add rspec to the Gemfile.
```ruby
group :test do
  gem 'rspec'
end
```

Then, init the rspec files:
```ruby
rspec --init
```
Add this on top of spec/spec_helper:
```ruby
# Remember environment variables from week 1?
ENV['RACK_ENV'] = 'test' # because we need to know what database to work with

# this needs to be after ENV["RACK_ENV"] = 'test'
# because the server needs to know
# what environment it's running it: test or development.
# The environment determines what database to use.
require 'server'
```

Finally, create the ```spec/link_spec.rb```:

```ruby
describe Link do

  context 'Demonstration of how datamapper works' do

    # This is not a real test, it's simply a demo of how it works
    it 'should be created and then retrieved from the db' do
      # In the beginning our database is empty, so there are no links
      expect(Link.count).to eq(0)
      # this creates it in the database, so it's stored on the disk
      Link.create(title: 'Makers Academy',
                  url: 'http://www.makersacademy.com/')
      # We ask the database how many links we have, it should be 1
      expect(Link.count).to eq(1)
      # Let's get the first (and only) link from the database
      link = Link.first
      # Now it has all properties that it was saved with.
      expect(link.url).to eq('http://www.makersacademy.com/')
      expect(link.title).to eq('Makers Academy')
      # If we want to, we can destroy it
      link.destroy
      # so now we have no links in the database
      expect(Link.count).to eq(0)
    end

  end

end

```

Check that it all works by running the test (make sure you have ```require 'data_mapper'``` in ```server.rb```).

`$ rspec`

```
Run options: include {:focus=>true}
All examples were filtered out; ignoring {:focus=>true}
.

Finished in 0.00991 seconds
1 example, 0 failures

Randomized with seed 41436

```

Resources
--------

* http://datamapper.org/
* https://github.com/datamapper
* https://github.com/DatabaseCleaner/database_cleaner
* http://stackoverflow.com/questions/10904996/difference-between-truncation-transaction-and-deletion-database-strategies
