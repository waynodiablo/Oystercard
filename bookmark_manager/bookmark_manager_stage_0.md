##Adding the database

For instructions on how to install your database (and learn some basic interactions via SQL) please [visit the PostgreSQL pill.](../pills/postgres.md)

##Talking to the database

To talk to the database, we'll need the [DataMapper](http://datamapper.org/) gem. It's an ORM (Object-relational mapper), which means that it's providing a convenient way to interact with our data using classes and objects instead of working with database tables directly.

Another advantage of datamapper is that is can be used with a variety of database engines, not only postgres. This implies that we'll need to install an adapter to work with postgres, apart from the datamapper itself. Add these gems to your Gemfile:

```ruby
gem 'data_mapper'
gem 'dm-postgres-adapter'
```

Don't forget to run "bundle" every time you update your Gemfile.

Then let's create our first model. Usually we would test drive its creation, but let's have a look at what a database mapped model looks like first.  Since our bookmark manager is going to manage collections of links, it'll certainly need a table to store them. So, create a model in lib/link.rb.

```ruby
# This class corresponds to a table in the database
# We can use it to manipulate the data
class Link

  # this makes the instances of this class Datamapper resources
  include DataMapper::Resource

  # This block describes what resources our model will have
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :title,  String
  property :url,    String

end
```

This file describes the relationship between the table in the database (they don't exist yet) and this Ruby class. We'll see how it can be used in a minute.

Then, add this code to ```server.rb``` in the lib directory.

```ruby
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link' # this needs to be done after datamapper is initialised

# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!
```

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
require 'spec_helper'

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

Why two databases?

A web project usually has at least three environments: development, test and production. An environment is the "mode" the project is running in, determined by the set of the environment variables (the environment the shell variables are in and the environment the project is running in are two different concepts that share the same name).

The environment the project is running in determines the behaviour of the project. For example, if we have an e-commerce project, our payment processing would be different for the three environment:

1. in production all credit cards would be charged for real (when real customers use it)
2. in development (when writing code), we would use special "development" credit cards that behave like real ones, except that no money is actually spent
3. in test (when running automated tests), we wouldn't even connect to the card processing centre so as not to slow down the tests

Depending on the environment, we may or may not do certain things: e.g. send real emails in production but only pretend to do it in a test environment. Our code can print extensive debugging information in development but only show succinct error messages in production.

So, getting back to the databases: we don't want to use the same database in different environments. Imagine you have one million users registered on your website. You don't want to use the same database for development. When you launch the website locally you only want to have a database with a few users that you control manually. And when you run your tests, you want your database to be empty because every test assumes that there is nothing there that wasn't created explicitly. What happens if your test deletes all data from the database and you run in on a production or development database? You'd lose data. So, we really need to use one database per environment.

That is why we are checking what environment we're in, and defaulting to development.

```ruby
env = ENV['RACK_ENV'] || 'development'
```

And then we select the database based on the environment.

```ruby
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
```

Finally, in our ```spec_helper.rb``` we specify the environment, so that our tests were using the right database.

```ruby
ENV['RACK_ENV'] = 'test'
```

Current state is on Github.
https://github.com/makersacademy/bookmark_manager/tree/24321e022f78f1275b77dcdff32e2df963d281f2

## Cleaning the database

When a test runs, it assumes that the database is empty. The test is not obliged to leave the database clean, though. We need to take care of this ourselves. Add the ```database_cleaner``` gem to the ```Gemfile``` and install it. Then, require it in ```spec_helper.rb``` and configure RSpec to use it.

```ruby
RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
```

This will make sure that the database is cleared after every test run.

Current State on Github
https://github.com/makersacademy/bookmark_manager/tree/15f77fecce729e2a9225f3ac2d369e201f6ce142

[ [Next Stage](bookmark_manager_stage_1.md) ]

[ [Return to outline](bookmark_manager.md) ]
