# Bookmark manager

### Completion time 3-4 days


This week's project is a bookmark manager. The goal is to expose you to the following aspects of web development, in addition to what we've studied before:

*Integration testing: Capybara (Monday)
*Relational databases (Tuesday and Wednesday)
*Security considerations (Thursday)

In addition to the technologies mentioned above, this project is going to be more challenging on the front-end. You shouldn't need more than we've covered in the previous weeks but you should expect to spend more time on the front-end, compared to Sudoku – web version. Of course, we'll also continue to be using the technologies we're familiar with: Sinatra, RSpec, etc.

## High-level specification

We are going to build a bookmark manager, similar to pineapple.io or delicious.com in spirit. A bookmark manager is a good use case for exploring how relational databases work.

A bookmark manager is a website to maintain a collection of links, organised by tags. You can use it to save a webpage you found useful. You can add tags to the webpages you saved to find them later. You can browse links other users have added.

The website will have the following options:

*Show a list of links from the database
*Add new links
*Add tags to the links
*Filter links by a tag

This is the basic view of the website. This tutorial will discuss how to build it, step by step. At the end of the section there are multiple exercises challenging you to extend the functionality of this website. 

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1380279073159_Screen%20Shot%202013-09-27%20at%2011.06.12.png "Bookmark Manager")

## First Steps

As you'd do with every new project, create a new repository on Github. Create an empty Sinatra application with a Gemfile and config.ru.

## Outline

To prevent this pad from getting very large, let's break it down into sections.


##Bookmark manager – Adding the database

In this project, we'll need to store the data in a database. Before we add any functionality, let's add a relational database to this project.


First you will have to install postgresql (unless you have installed it already). eSQLFirst install postgresql. Postgres is a widely used open source relational database engine.

There are two ways of doing this. Downloading the app (2) will, sometimes, leave you with a non-working postgresql installation. We recommend using option 1.

1) Install it through Homebrew with "brew install postgresql" (after it has installed postgres follow the on screen instructions).

2)  In your terminal run

`brew install postgresql`

After homebrew has downloaded the software it will show you some installation instructions, follow them! Ok, they might not be that readable ;)

Make sure you run these commands after installing postgresql with homebrew:

`ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist`

You can check your installation by running

`psql`

At first it can happen that you don't have a database named after your username (you will see a messags along the lines 'unknown database "ecomba"). Let's create that database for you so that you can loging without having to specify the database:

`psql postgres`

`postgres# create database "ecomba";`

`DATABASE CREATE`

`postgres# \q`



From now on you will be able to log in to postgresql without having to specify the database you want to log into.

To talk to the database, we'll need the datamapper gem. It's an ORM (Object-relational mapper), which means that it's providing a convenient way to interact with our data using classes and objects instead of working with database tables directly.

Another advantage of datamapper is that is can be used with a variety of database engines, not only postgres. This implies that we'll need to install an adapter to work with postgres, apart from the datamapper itself. Add these gems to your Gemfile:

```ruby
gem 'data_mapper'
gem 'dm-postgres-adapter'
```

Don't forget to run "bundle install" every time you update your Gemfile.

Then let's create our first model. Since our bookmark manager is going to manage collections of links, it'll certainly need a table to store them. So, create a model in lib/link.rb.
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

Then, add this code to server.rb.


```ruby
env = ENV["RACK_ENV"] || "development"
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

Now we have everything we need to use datamapper in our code. Let's see how we could do it by writin an rspec test.

RSpec demonstration

First, add rspec to the Gemfile.
```ruby
group :development, :test do
  gem "rspec"
 end
 ```

Then, init the rspec files:
```ruby
rspec --init
```
Add this on top of spec/spec_helper:
```ruby
# Remember environment variables from week 1?
ENV["RACK_ENV"] = 'test' # because we need to know what database to work with

# this needs to be after ENV["RACK_ENV"] = 'test' 
# because the server needs to know
# what environment it's running it: test or development. 
# The environment determines what database to use.
require 'server'
``` 

Finally, create the spec/link_spec.rb:
```ruby
require 'spec_helper'

describe Link do

  context "Demonstration of how datamapper works" do

    # This is not a real test, it's simply a demo of how it works
    it 'should be created and then retrieved from the db' do
      # In the beginning our database is empty, so there are no links
      expect(Link.count).to eq(0)
      # this creates it in the database, so it's stored on the disk
      Link.create(:title => "Makers Academy", 
                  :url => "http://www.makersacademy.com/")
      # We ask the database how many links we have, it should be 1
      expect(Link.count).to eq(1)
      # Let's get the first (and only) link from the database
      link = Link.first
      # Now it has all properties that it was saved with.
      expect(link.url).to eq("http://www.makersacademy.com/")
      expect(link.title).to eq("Makers Academy")
      # If we want to, we can destroy it
      link.destroy
      # so now we have no links in the database
      expect(Link.count).to eq(0)
    end

  end

end

```

Check that it all works by running the test (make sure you have required "data_mapper" in server.rb).

`$ rspec`
Run options: include {:focus=>true}
```
All examples were filtered out; ignoring {:focus=>true}
.

Finished in 0.00991 seconds
1 example, 0 failures

Randomized with seed 41436

```

Why two databases?

A web project usually has at least three environments: development, test and production. An environment is the "mode" the project is running in, determined by the set of the environment variables (the environment the shell variables are in and the environment the project is running in are two different concepts that share the same name).

The environment the project is running in determines the behaviour of the project. For example, if we have an e-commerce project, our payment processing would be different for the three environment:
in production (when real customers use it), all credit cards would be charged for real
in development (when writing code), we would use special "development" credit cards that behave like real ones, except that no money is actually spent
in test (when running automated tests), we wouldn't even connect to the card processing centre to not slow down the tests

Depending on the environment, we may do or not do certain things: send real emails in production but only pretend to do it in a test environment. Our code can print extensive debugging information in development but only show succinct error messages in production.

So, getting back to the databases: we don't want to use the same database in different environments. Imagine you have one million users registered on your website. You don't want to use the same database for development. When you launch the website locally you only want to have a database with a few users that you control manually. And when you run your tests, you want your database to be empty because every test assumes that there is nothing there that wasn't created explicitely. What happens if your test deletes all data from the database and you run in on a production or development database? You'd lose data. So, we really need to use one database per environment.

That is why we are checking what environment we're in, defaulting to development.

```ruby
env = ENV["RACK_ENV"] || "development"
```

And then we select the database based on the environment.

```ruby
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
```

Finally, in our spec_helper we specify the environment, so that our tests were using the right database.

```ruby
ENV["RACK_ENV"] = 'test'
```

Current state is on Github.
https://github.com/makersacademy/bookmark_manager/tree/24321e022f78f1275b77dcdff32e2df963d281f2

## Cleaning the database

When a test runs, it assumes that the database is empty. The test is not obliged to leave the database clean, though. We need to take care of this ourselves. Add the database_cleaner gem to the Gemfile and install it. Then, require it in the spec_helper and configure RSpec to use it.
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

# Bookmark manager – Managing links and tags

Browsing links

Let's write our first integration test using Capybara first. First, add capybara to your Gemfile and install it. Then, require and configure it in spec_helper as instructed on the capybara github page.

```ruby
require 'capybara/rspec'

Capybara.app = Sinatra::Application.new
```

Then, create spec/features folder where our integration tests will be. Create the first test (listing_all_links_spec.rb) that visits the homepage and checks that the link we put in the database is there.
```ruby
require 'spec_helper'

feature "User browses the list of links" do

  before(:each) {
    Link.create(:url => "http://www.makersacademy.com",
                :title => "Makers Academy")
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Makers Academy")
  end
end
```

So, this test creates one link, goes to the homepage and expects to see it there (well, not exactly, it just looks for "Makers Academy" words somewhere on the page). If you run the test, it should fail.
```
Failures:

  1) User browses the list of links when opening the home page
     Failure/Error: expect(page).to have_content("Makers Academy")
       expected to find text "Makers Academy" in "Welcome to the bookmark manager"
     # ./spec/features/listing_all_links_spec.rb:11:in `block (2 levels) in <top (required)>'
```

This is because we haven't written any code to show the links on the homepage. Let's add it.

Current links:
```html
<ul>
  <% @links.each do |link| %>
    <li><a href="<%= link.url %>"><%= link.title %></a></li>
  <% end %>
</ul>
```
```ruby
get '/' do
  @links = Link.all
  erb :index
end
```

Now our tests pass.
```

Finished in 0.03551 seconds
2 examples, 0 failures
```

Current state is on Github.
https://github.com/makersacademy/bookmark_manager/tree/7d35ba70c772421e64999eac68a2e28f0501780b


Submitting a new link

So, let's add a few basic features to the website. First, we need to somehow submit new links. Let's add a new test for it, adding_links_spec.rb.

```ruby
require 'spec_helper'

feature "User adds a new link" do
  scenario "when browsing the homepage" do
    expect(Link.count).to eq(0)
    visit '/'
    add_link("http://www.makersacademy.com/", "Makers Academy")
    expect(Link.count).to eq(1)
    link = Link.first
    expect(link.url).to eq("http://www.makersacademy.com/")
    expect(link.title).to eq("Makers Academy")
  end

  def add_link(url, title)
    within('#new-link') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      click_button 'Add link'
    end      
  end
end
```

The code should be self-explanatory. We expect to have no links until we go to the homepage and fill out the form inside #new-link element and submit it. Afterwards, we'll have one link in the database with the properties that we specified when creating it.

This test fails, so let's make it pass. First, we'll need to create the form in question.

```html
<div id="new-link">
  <form action="/links" method="post">
    Url: <input type="text" name="url">
    Title: <input type="text" name="title">
    <input type="submit" value="Add link">
  </form>
</div>
```

Then we'll need to add a new route that will handle the form submission.

```ruby
post '/links' do
  url = params["url"]
  title = params["title"]
  Link.create(:url => url, :title => title)
  redirect to('/')
end
```

Current state is on Github.
https://github.com/makersacademy/bookmark_manager/tree/8844773e81ba888327a1bef46737c6cf5c36597f

## Adding tags to links

By now we have a web application that allows us to add new links to the database and show the entire list on the front page. We have integration tests that give us comfort that if something breaks, we'll know about it straight away.

Let's implement a new feature: allowing links to have tags associated with them. As usual, let's start with a test.
```ruby

  scenario "with a few tags" do
    visit "/"
    add_link("http://www.makersacademy.com/", 
                "Makers Academy", 
                ['education', 'ruby'])    
    link = Link.first
    expect(link.tags).to include("education")
    expect(link.tags).to include("ruby")
  end

  def add_link(url, title, tags = [])
    within('#new-link') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      # our tags will be space separated
      fill_in 'tags', :with => tags.join(' ')
      click_button 'Add link'
    end      
  end
  ```

Note that we modified add_link() method to have the third parameter with a default value to make sure it's still compatible with the other test we wrote earlier. Of course, our test fails.

```

1) User adds a new link with a few tags
     Failure/Error: expect(link.tags).to include("education")
     NoMethodError:
       undefined method `tags' for #<Link:0x007fe22c3a95b0>
     # ./spec/features/adding_links_spec.rb:19:in `block (2 levels) in <top (required)>'
```

So, the test tells us that the method "tags" that we expect to exist is undefined. This is because our Link model doesn't have any tags associated with it. Let's add a many-to-many relationship to our Link model.
```ruby
has n, :tags, :through => Resource
```

The details of how datamapper works with many-to-many relationships (:through => Resource) are well described in its documentation.

Let's go back and run the test. We get another error:

Cannot find the child_model Tag for Link in tags (NameError)

It means that the Link model now expect a Tag model to exist but we never defined it.

Before we do it, let's discuss the process we're going through. We have written a test that describes the functionality we want to see. Then we ran it and it highlighted a problem (no tags associated to a link). We fixed just that problem, no more, no less. We didn't create the Tag class straight away. Then we ran the test again and it told us that we didn't have the model Tag. This is when we decided to create the model Tag to get past this particular error. We'll be repeating this process several times over.

This is what is called test-driven development. You shouldn't merely have tests, they should drive the coding process. On many occasions you'll be able to predict the next error and you'll be tempted to fix a few things in one go. For example, if there were no tags linked to the Link model it was obvious that we should have created a many-to-many relationship and created the Tag model as well. However, be careful not to jump too far: the more code you write without the tests guiding you, the more likely you are to make an error. Some developers prefer to follow test messages very closely, doing the absolute minimum of work required to make them pass. Some move a few error messages at a time (like we've done before when we wrote our first test and wrote a dozen lines of code in one go. There isn't a one rule fits all approach. However, if you're unsure, follow the tests closely: they will guide you towards writing only the necessary amount of good code to get the job done.

So, let's create the Tag model that also has a many-to-many relationship to Link.

```ruby
class Tag

  include DataMapper::Resource

  has n, :links, :through => Resource

  property :id, Serial
  property :text, String
  
end
```

Note that we're doing a few things other than creating an empty datamapper model without letting the tests tell us that we need to do it (add the relationship with Link, add the text property). Use your best judgement when choosing how fast to go.

Let's move over to the next error.
```

2) User adds a new link with a few tags
     Failure/Error: fill_in 'tags', :with => tags.join(' ')
     Capybara::ElementNotFound:
       Unable to find field "tags"
```

Our test wants to fill out a field that doesn't exist. Let's fix it.
```html
Tags: <input type="text" name="tags">
```

Next error:
```

Failure/Error: expect(link.tags).to include("education")
       expected [] to include "education"
```

So, the test is filling out the form correctly since we added a new input fields but the data doesn't end up in the database. Time to fix it in server.rb.
```ruby

tags = params["tags"].split(" ").map do |tag|
  # this will either find this tag or create
  # it if it doesn't exist already
  Tag.first_or_create(:text => tag)
end
Link.create(:url => url, :title => title, :tags => tags)
```

Note that we're searching for a tag record in the database (or creating an instance of the Tag class if it doesn't exist) and then passing an array of instances to Link, as opposed to passing just the text. This is because a Tag is not simply a string, it's a database record that has text and id but may have other properties in the future (user_id of the user who created it, created_at timestamp, etc).

However, if we run the test, we'll still get an error.

```
Failure/Error: expect(link.tags).to include("education")
       expected [#<Tag @id=1 @text="education" @link_id=4>, #<Tag @id=2 @text="ruby" @link_id=4>] to include "education"
       Diff:
       @@ -1,2 +1,2 @@
       -["education"]
       +[#<Tag @id=1 @text="education" @link_id=4>, #<Tag @id=2 @text="ruby" @link_id=4>]
```

It turns out we made a mistake in out test. Instead of expecting the link.tags array to contain strings, we should expect it to contain instances of Tag object. Let's fix the test by mapping the Tag instances to the text they contain.

```ruby

expect(link.tags.map(&:text)).to include("education")
expect(link.tags.map(&:text)).to include("ruby")

```
Now all our tests pass.

```
Finished in 0.12076 seconds
4 examples, 0 failures
```
Current state is on Github.
https://github.com/makersacademy/bookmark_manager/tree/88dd9bc90041fc02dd5f335ad4ddfc0eab430c4e

## Filtering by tag

Adding tags to links is useful but it'd be even more useful to be able to filter links by a tag. Let's write a test for this in listing_all_links_spec first.

```ruby
scenario "filtered by a tag" do
  visit '/tags/search'
  expect(page).not_to have_content("Makers Academy")
  expect(page).not_to have_content("Code.org")
  expect(page).to have_content("Google")
  expect(page).to have_content("Bing")
end
```

Let's also update the before(:each) block to create some test data.

```ruby
  before(:each) {
    Link.create(:url => "http://www.makersacademy.com",
                :title => "Makers Academy", 
                :tags => [Tag.first_or_create(:text => 'education')])
    Link.create(:url => "http://www.google.com", 
                :title => "Google", 
                :tags => [Tag.first_or_create(:text => 'search')])
    Link.create(:url => "http://www.bing.com", 
                :title => "Bing", 
                :tags => [Tag.first_or_create(:text => 'search')])
    Link.create(:url => "http://www.code.org", 
                :title => "Code.org", 
                :tags => [Tag.first_or_create(:text => 'education')])
  }
  ```

Sure enough, the test fails because Sinatra returns a "404 Not Found" page for the route that doesn't exist yet. Let's add the route.

```ruby
get '/tags/:text' do
  tag = Tag.first(:text => params[:text])
  @links = tag ? tag.links : []
  erb :index
end
```

First we find the tag that we need (note the use of a named parameter in the route). Then, if the tag exists, we get associated links. Otherwise, we just return an empty array.

Current state is on Github
https://github.com/makersacademy/bookmark_manager/tree/e45ed5d9c3289c8320632e6aadcc56c3d624fbcc

## Adding user accounts
todo
## Styling the website
todo


## Exercises

By now you should be able to do all of the following (in no particular order).

* Show the list of available tags on the homepage
* Move the form to add a link to its own route
* Add user_id to tags and links. Display who the link was submitted by. Same for a tag
* Allow the user to add a link to favourites (this will be a many-to-many relationship)
* Display how many users favourited the link
* Create a user profile page that will show the links they submitted, tags they created and their favourites.
* Display the link to the user's profile at the top of the page if the user is logged in
* Implement forgotten password functionality
* Redirect the user with a flash message if a logged in user tries to sign up or sign in
* Send a welcome email when the user signs up
* Create validations for all models:
* email must have the correct format (see an example in Datamapper Validations)
* email and password must be present
* link must have a title and a url
* tag must have some text
* Add a description property to the link.
* Add a username to the User model, so that username instead of an email was shown next to the link.
