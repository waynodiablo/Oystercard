# Viewing and creating links

## Viewing links

Let's write our first feature test using Capybara. Create `spec/features` folder where our feature tests will be. Create the first test `viewing_links_spec.rb` that visits the homepage and checks that the link we put in the database is there.

```ruby
feature 'Viewing links' do

  scenario 'I can see existing links on the links page' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

    visit '/links'

    # as this is our first feature test,
    # the following expectation is a quick check that everything is working.
    expect(page.status_code).to eq 200
    # you might remove this later.

    # why do we use within here?
    # might we get a false positive if we just test for 'Makers Academy'?
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end
end
```

When you run this test, you will encounter a familiar error "uninitialized constant Link". At this stage we are being driven to create a class called `Link`.  Before we do that though, let's think about what a `Link` is.

We know that links need to be saved (persisted) somewhere and that we want to use a database.  So we want our `Link` class to somehow map to a database...

###Adding the database

For instructions on how to install your database (and learn some basic interactions via SQL) please [visit the PostgreSQL pill&nbsp;:pill:](../pills/postgres.md).

###Talking to the database
To talk to the database, we'll need the DataMapper gem. Follow this [DataMapper pill&nbsp;:pill:](../pills/datamapper.md) and spend some time [playing with Postgres & DataMapper&nbsp;:pill:](https://github.com/makersacademy/course/blob/master/pills/playing_with_postgres_and_datamapper.md).


Let's create our first model.  Since our bookmark manager is going to manage collections of links, it'll certainly need a table to store them.
* :white_check_mark: So, create a model in `/app/models/link.rb`.

```ruby
# This class corresponds to a table in the database
# We can use it to manipulate the data
class Link

  # adds datamapper functionality to this class
  include DataMapper::Resource

  # these property declarations set the column headers in the Link table
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :title,  String
  property :url,    String

end
```

This class prescribes a relationship between a table in the database (which will be called 'links') and instances of `Link`. We'll see how it can be used in a minute.

Running our tests now should kick up the following error:
```
Failures:

 1) Viewing links I can see existing links on the links page
    Failure/Error: visit '/links'
    ArgumentError:
      rack-test requires a rack application, but none was given
    # ./spec/features/viewing_links_spec.rb:4:in `block (2 levels) in <top (required)>'

Finished in 0.00136 seconds (files took 0.37153 seconds to load)
1 example, 1 failure
```

How do you think you might approach this error? To get you started, follow these steps and see if you can change the error:

* :white_check_mark: Create a file, `/app/app.rb`.
* :white_check_mark: Lay out Sinatra in the modular style within `app.rb`
* :white_check_mark: Add `Capybara.app = NameOfYourSinatraClass` to `spec_helper`. Here we're telling Capybara what it should be testing.
* :white_check_mark: Ensure you require your server file in spec_helper.

The failure message of the test should now be:
```
Failures:

 1) Viewing links I can see existing links on the links page
    Failure/Error: expect(page.status_code).to eq 200

      expected: 200
           got: 404

      (compared using ==)
    # ./spec/features/listing_all_links_spec.rb:6:in `block (2 levels) in <top (required)>'

Finished in 0.02297 seconds (files took 0.693 seconds to load)
1 example, 1 failure
```

We are receiving a status code of 404 - which indicates that the path does not exist.

* :white_check_mark: Let's create a `/links` path.


```ruby
# /app/app.rb
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end
```
```erb
<!-- in /views/links/index.erb -->
<h1> Links </h1>

<ul id="links">
  <% @links.each do |link| %>
    <li>
      Title: <%= link.title %>
      URL:   <%= link.url   %>
    </li>
  <% end %>
</ul>
```
Running our tests now, it shows that our link is not being displayed on the page.
* :white_check_mark: Refer to [DataMapper documentation](http://datamapper.org/docs/create_and_destroy.html) and see if you can get this to pass.

## Creating Links

Now's the time to add a few basic features to the website. First, we need to somehow create new links:
* :white_check_mark: Let's add a new test for it, `creating_links_spec.rb`.

```ruby
feature 'Creating links' do

  scenario 'I can create a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.zombo.com/'
    fill_in 'title', with: 'This is Zombocom'
    click_button 'Create link'

    # we expect to be redirected back to the links page
    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content('This is Zombocom')
    end
  end
end
```
Run your tests.  What steps do we need to take to fix the failures?

Take the following steps:
* :white_check_mark: Define `get '/links/new'` route in app.rb.
* :white_check_mark: Create an associated view containing a form that POSTs to `/links`.  What input fields should be defined?


Though we have a form for creating links, nothing is being done with the information the user has submitted. Examine the form you just created. Can you guess what path the form data is submitted to?

* :white_check_mark: Within app.rb, define a route for the form data to be submitted to, like so:

```ruby
post '/links' do
  Link.create(url: params[:url], title: params[:title])
  redirect to('/links')
end
```

Note:  Why do we POST to `/links` and not `/links/new`?  Why do we GET `links/new`?  Discuss this with your pair partner.  Does the message structure help us to infer the intent of each message?

### Starting with a clean slate
When we run our feature tests, we want each test to run from a clean start right?  Think about how this has been handled in previous projects.

Now we are persisting data outside of our application, are we making a clean start each time?  To answer that question, let's write a test.  You perhaps wouldn't normally write a test like this, but it's a good way to establish what's going on.  Put the following in your `creating_links_spec` - you can always delete it later:

```
scenario 'there are no links in the database at the start of the test' do
  expect(Link.count).to eq 0
end
```

Run your tests. You should be seeing:
```
1) Creating links there are no links in the database at the start of the test
    Failure/Error: expect(Link.count).to eq(0)

      expected: 0
           got: 3
```

Run them again. How does the error change? It seems that every time we run the tests, the number of links increases. This is unsurprising given that each run of the test creates a link. The flaw is in our testing strategy: we want every test to run from a clean slate.  At present, however, data is persisting across test-runs.

* :white_check_mark: Configure a gem called [DatabaseCleaner&nbsp;:pill:](../pills/database_cleaner.md).

All is well. =)

## Directory structure

Your directory should look like this:
```bash
.
├── Gemfile
├── Gemfile.lock
├── app
│   ├── app.rb
│   ├── data_mapper_setup.rb
│   ├── models
│   │   └── link.rb
│   └── views
│       └── index.erb
└── spec
    ├── features
    │   └── viewing_links_spec.rb
    └── spec_helper.rb

5 directories, 8 files
```
Be aware, however, that this is only a suggested structure. You might want to have the features folder outside of the spec folder, so that it's easier to run feature tests in isolation from unit tests. Discuss the pros and cons of different directory structures with your pair partner.

## Extra Activities:
* :white_check_mark: At this point, you may have already tried `rackup`. If you haven't, give it a shot. What happens? What step have we missed?
* :white_check_mark: We have a green feature test - now is a good time to deploy to Heroku (remember, deploy early and regularly). See the [docs](https://devcenter.heroku.com/articles/rack#using-datamapper-or-sequel) for some direction.



[ [Next Stage](bookmark_manager_stage_1.md) ]

[ [Return to outline](bookmark_manager.md) ]
