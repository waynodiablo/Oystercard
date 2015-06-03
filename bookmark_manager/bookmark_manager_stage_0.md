* test first?
* add pill links
* `dbtype://user:password@hostname:port/databasename` doesn't make sense
* remove link.destroy once db_cleaner is setup

# Managing links and tags

## Browsing links

Let's write our first integration test using Capybara. First, add capybara to your Gemfile and install it. 

Then, create ```spec/features``` folder where our integration(Capybara) tests will be. Create the first test ```listing_all_links_spec.rb``` that visits the homepage and checks that the link we put in the database is there.

```ruby
feature 'User browses the list of links' do

  scenario 'when visiting the links page' do
    Link.new(url:    'http://www.makersacademy.com',
                    title:  'Makers Academy')
    visit '/links'
    expect(page).to have_content('Makers Academy')
  end
end
```

When you run this test, you will see this failure:
```
Failures:

 1) User browses the list of links when visiting the links page
    Failure/Error: visit '/links'
    ArgumentError:
      rack-test requires a rack application, but none was given
    # ./spec/features/listing_all_links_spec.rb:4:in `block (2 levels) in <top (required)>'

Finished in 0.00136 seconds (files took 0.37153 seconds to load)
1 example, 1 failure
```

This is because we have not yet set up capybara in our spec_helper. Full instructions are found on the [capybara](https://github.com/jnicklas/capybara) github page.

```ruby
Capybara.app = BookmarkManager
```



#Adding the database

For instructions on how to install your database (and learn some basic interactions via SQL) please [visit the PostgreSQL pill.](../pills/postgres.md)

##Talking to the database

To talk to the database, we'll need the DataMapper gem. Follow this :pill: [DataMapper](../pills/datamapper.md) to set up your ORM.

Then let's create our first model.  Since our bookmark manager is going to manage collections of links, it'll certainly need a table to store them. So, create a model in lib/link.rb.

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

We will also need to set up our :pill: [database environments](#).

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



Current State on Github
https://github.com/makersacademy/bookmark_manager/tree/15f77fecce729e2a9225f3ac2d369e201f6ce142

[ [Next Stage](bookmark_manager_stage_1.md) ]

[ [Return to outline](bookmark_manager.md) ]
