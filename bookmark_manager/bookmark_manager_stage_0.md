# Viewing / Creating Links

## Viewing links

Let's write our first integration test using Capybara. First, add capybara to your Gemfile and install it.

Then, create ```spec/features``` folder where our integration(Capybara) tests will be. Create the first test ```listing_all_links_spec.rb``` that visits the homepage and checks that the link we put in the database is there.

```ruby
feature 'User browses the list of links' do

  scenario 'when visiting the links page' do
    Link.new(url:    'http://www.makersacademy.com',
                    title:  'Makers Academy')
    visit '/links'
    expect(page.status_code).to eq 200
    expect(page).to have_content('Makers Academy')
  end

end
```

When you run this test, you will encounter a familiar error "uninitialized constant Link". At this stage we are being driven to create a class called Link. We know that we want this to be a representation of our database. We call these representations 'models'. In order to drive this development further, we are going to make a leap and construct the Link model as we would like to use it in the domain.

###Adding the database

For instructions on how to install your database (and learn some basic interactions via SQL) please [visit the PostgreSQL pill.](../pills/postgres.md)

###Talking to the database

To talk to the database, we'll need the DataMapper gem. Follow this :pill: [DataMapper](../pills/datamapper.md) to set up your ORM.

Then let's create our first model.  Since our bookmark manager is going to manage collections of links, it'll certainly need a table to store them. So, create a model in app/models/link.rb.

```ruby
# This class corresponds to a table in the database
# We can use it to manipulate the data
class Link

  # adds datamapper functionality to this class
  include DataMapper::Resource

  # these property declaration set the column headers in the Link table
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :title,  String
  property :url,    String

end
```

This class prescribes the relationship between the Link table in the database  and this Ruby application. We'll see how it can be used in a minute.

If you run your tests now, you should encounter the following failure:
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

How do you think you might approach this error? To get you started, follow these steps and see if you can change the error:

* Add ``` Capybara.app = BookmarkManager ``` to your RSpec config.
* Set up your sinatra app.rb in the 'app' folder of your application.
* Use the modular sinatra style (what do you think the app should be called?)
* Make sure that you require your server file in spec_helper.

The failure message of the test should now be:
```
Failures:

 1) User browses the list of links when visiting the links page
    Failure/Error: expect(page.status_code).to eq 200

      expected: 200
           got: 404

      (compared using ==)
    # ./spec/features/listing_all_links_spec.rb:6:in `block (2 levels) in <top (required)>'

Finished in 0.02297 seconds (files took 0.693 seconds to load)
1 example, 1 failure
```

We are receiving a status code of 404 - which indicates that the path does not exist.

Let's set that up now.


```ruby
# in app.rb

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end
```
```html
<!-- in views/links/index.erb -->
<h1> Links </h1>

<% @links.each do |link| %>
 Title: <%= link.title %>
 URL:   <%= link.url   %>
<% end %>
```
Running our tests now, it shows that our link is not being displayed on the page. Refer to [DataMapper documentation](http://datamapper.org/docs/create_and_destroy.html) and see if you can get this to pass.

## Creating Links

So, let's add a few basic features to the website. First, we need to somehow submit new links. Let's add a new test for it, ```adding_links_spec.rb```.

```ruby
feature 'User adds a new link' do

  scenario 'using the new link form' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.zombo.com/'
    fill_in 'title', with: 'This is Zombocom'
    click_button 'Add link'
    expect(Link.count).to eq(1)
    expect(current_path).to eq '/links'
    expect(page).to have_content('http://www.zombo.com/')
    expect(page).to have_content('This is Zombocom')
  end

end
```

Take the following steps::
* Define ``` get '/links/new' ``` route in app.rb.
```html
<form action='/links' method='post'>
 Url: <input type='text' name='url'>
 Title: <input type='text' name='title'>
 <input type='submit' value='Add link'>
</form>
```
* Create an associated view containing a form that POSTs to '/links'. What input fields should be defined?

Run your tests. You should be seeing:
```ruby
1) User adds a link using the new links form
    Failure/Error: expect(Link.count).to eq(1)

      expected: 1
           got: 3
```
Run them again. How does the error change? It seems that every time we run the tests, the number of links increases. This is unsurprising given that we are creating a link within our test. The flaw is in our testing strategy: we want every test to run from a clean slate. At present, however, data is persisting across test-runs.

Let's configure a gem called :pill:["DatabaseCleaner"](../pills/database_cleaner.md).

Configuring DatabaseCleaner should move us on to the next error:

```ruby
1) User adds a link using the new links form
   Failure/Error: expect(Link.count).to eq(1)

     expected: 1
          got: 0
```

Though we have a form for creating links, nothing is being done with the information the user has submitted. Examine the form you just created. Can you guess what path the form data is submitted to?

* Within app.rb, define a route for the form data to be submitted to:

```ruby
post '/links' do
  Link.create(url: params[:url], title: params[:title])
  redirect to('/links')
end
```

Now our tests shall pass. =)

## Extra Activities:
1. At this point, you may have already tried `rackup`. If you haven't, give it a shot. What happens? What step have we missed?



[ [Next Stage](bookmark_manager_stage_1.md) ]

[ [Return to outline](bookmark_manager.md) ]
