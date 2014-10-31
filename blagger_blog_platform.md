Blagger
=======

> Fake it till you make it...

This week's project is a blogging platform. The goal is to build on what has
been learned before, and expose you to aspects of web development.

- Integration testing (Cucumber)
- Relational databases (Tuesday and Wednesday)
- Security considerations (Thursday)

## High-level specification

We are going to build a blogging platform, like Blogger or Tumblr. This is
a great use case to demonstrate how relational databases work. It also might be
good to keep a blog on!

A blog is a website that maintains a collection of articles (blog posts),
organised by tags or category, each written by an author. Articles can be edied
by their author.

- A front page with all the posts previewed.
- Blog post pages which show the entire article.
- An admin page to create, edit and delete blog posts

## First Steps

As you'd do with every new project, create a new repository on Github. Create an
empty [Sinatra] application with a `Gemfile` and `config.ru`.

Given that we will be using Cucumber for our integration tests, a quick way to
get everything set up is to use the `cucumber-sinatra` gem. Install the gem and
then run `cucumber-sinatra init --app Blagger server.rb`

## Outline

To prevent this pad from getting very large, let's break it down into sections.

##Adding the database

In this project, we'll need to store the data in a database. Before we add any
functionality, let's add a relational database to this project.

First you will have to install [PostgreSQL](link to postgres pill).
Postgres is a widely used open source relational database engine.

To talk to the database, we'll need the datamapper gem. It's an ORM
(Object-Relational Mapper), which means that it's providing a convenient way to
interact with our data using classes and objects instead of working with
database tables directly.

Another advantage of datamapper is that is can be used with a variety of
database engines, not only postgres. This implies that we'll need to install an
adapter to work with postgres, apart from the datamapper itself. Add these gems
to your Gemfile:

```ruby
gem 'data_mapper'
gem 'dm-postgres-adapter'
```

Don't forget to run `bundle install` every time you update your Gemfile!

Then let's create our first model. Since our blogging platform is going to manage
collections of posts, it'll certainly need a table to store them. So, create
a model in `lib/post.rb`.

```ruby
# This class corresponds to a table in the database
# We can use it to manipulate the data

class Post

  # this makes the instances of this class Datamapper resources

  include DataMapper::Resource

  # This block describes what resources our model will have

  property :id,         Serial # Serial means that it will be auto-incremented for every record
  property :title,      String
  property :text,       Text

end
```

This file describes the relationship between the table in the database (they don't exist yet) and this Ruby class. We'll see how it can be used in a minute.

Then, add this code to server.rb.

```ruby
env = ENV["RACK_ENV"] || "development"

# we're telling datamapper to use a postgres database on localhost. The name will be "blagger_test" or "blagger_development" depending on the environment - and we're pulling in the environment variable 'RACK_ENV' above.

DataMapper.setup(:default, "postgres://localhost/blagger_#{env}")

require './lib/post'
# this needs to be done after datamapper is initialised. It loads up the model
# so that datamapper 'knows' about it - so you'll need datamapper first!

# After declaring your models, you should finalise what they look like.

DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them!

DataMapper.auto_upgrade!
```

By default Postgres.app is configured to accept connections from a logged in
user without the password, so we omit them. Since postgres is running on the
default port 5432, it doesn't have to be specified either.

After we require our models, datamapper will know what data schema we have in
our project (because we `include DataMapper::Resource` in every model). After the
models are finalized (checked for consistency), we can ask datamapper to create
the tables.

However, datamapper will not create the database for us. We need to do it
ourselves.

In the terminal run `psql` to connect to your database server.

Psql is a text-based interface to talk to the database, much like irb is used to
run Ruby code. Let's create both databases we need using SQL commands:

```shell
CREATE DATABASE "blagger_test";

CREATE DATABASE "blagger_development";
```

Finally, type
`\q`
to exit psql.

###Testing with Rspec Demo

First, add rspec to the Gemfile.
```ruby
group :development, :test do
  gem "rspec"
end
```

(Don't forget to `bundle`)

Then, init the rspec files:

```ruby
rspec --init
```

Add this on top of `spec/spec_helper`:

```ruby
# Remember environment variables from week 1?
ENV["RACK_ENV"] = 'test' # because we need to know what database to work with

# this needs to be after ENV["RACK_ENV"] = 'test'
# because the server needs to know
# what environment it's running it: test or development.
# The environment determines what database to use.

require 'server'
```

Finally, create the spec/post_spec.rb:

```ruby
require 'spec_helper'

describe Post do

  context "Demonstration of how datamapper works" do

    # This is not a real test, it's simply a demo of how it works

    it 'should be created and then retrieved from the db' do

      # In the beginning our database is empty, so there are no posts
      expect(Post.count).to eq(0)

      # this creates it in the database, so it's stored on the disk
      Post.create(:title => "Blagger is Born",
                  :text => "My first post about my wonderful new blogging
                  platform.")

      # We ask the database how many posts we have, it should be 1
      expect(Post.count).to eq(1)

      # Let's get the first (and only) post from the database
      post = Post.first

      # Now it has all properties that it was saved with.
      expect(post.text).to eq("My first post about my wonderful new blogging
                  platform.")
      expect(post.title).to eq("Blagger is Born")

      # If we want to, we can destroy it
      post.destroy

      # so now we have no posts in the database
      expect(Post.count).to eq(0)
    end

  end

end

```

Check that it all works by running the test (make sure you have required "data_mapper" in server.rb).

```shell
All examples were filtered out; ignoring {:focus=>true}
.

Finished in 0.00991 seconds
1 example, 0 failures

Randomized with seed 41436
```

Why two databases? Time to learn about [your development environments](dev env
pill here) if you haven't already.

## Cleaning the database

When a test runs, it assumes that the database is empty. The test is not obliged
to leave the database clean, though. We need to take care of this ourselves. Add
the `database_cleaner` gem to the Gemfile and install it. Then, require it in
`spec_helper` and configure RSpec to use it (inside the `RSpec.configure` loop)

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

###Managing posts

So that's how to get testing going with Rspec - but I said we'd be using
Cucumber to do our integration tests. Let's get that set up too!

If you've used the `cucumber-sinatra` gem to do your set up you've already got
the required file structures in place (if not, just set up the directories as
described in the Cucumber pill).

First add two gems to the Gemfile's development and test groups - `capybara`
and `cucumber`. Cucumber should be familiar by now - [Capybara](pill?) less so.

We'll be using Capybara to write the individual tests that Cucumber will then
be running. Capybara is a (headless) browser and DSL for testing websites - you
can write tests that move a virtual browser around a website and test the
content, server responses, CSS and HTML you find there.

Let's start with a test to see all the blog posts when we get to the homepage.

```gherkin
Feature: Blagger homepage
    In order to use the Blagger blogging platform
    As reader of blogs
    I want there to be a homepage

    Scenario: User browses th list of posts
        Given there is a blog post with the title of "My first blog post"
        When I am on the homepage
        Then I should see "My first blog post"
```

If you run `cucumber` now you'll get the following output to the terminal:

```shell
  Scenario: User browses the list of posts                            # features/homepage.feature:6
    Given there is a blog post with the title of "My first blog post" # features/homepage.feature:7
    When I am on the homepage                                         # features/step_definitions/web_steps.rb:19
    Then I should see "My first blog post"                            # features/step_definitions/web_steps.rb:107

1 scenario (1 undefined)
3 steps (2 skipped, 1 undefined)
0m0.002s

You can implement step definitions for undefined steps with these snippets:

Given(/^there is a blog post with the title of "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
```

Which is Cucumber's way of telling us that it doesn't know what that step is
all about. Copy and paste the snippet above into a new file in the
`features\step_definitions`. Let's call it `homepage_steps.rb`. And let's fill
in the blanks as follows:

```ruby
Given(/^there is a blog post with the title of "(.*?)"$/) do |title|
  Post.create(title: "My first blog post")
end
```

When
