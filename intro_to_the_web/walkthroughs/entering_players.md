# Walkthrough – Entering Players

[Back to the Challenge](../entering_players.md)

Our User Story:

```
As two Players,
So we can play a personalised game of Battle,
We want to Start a fight by entering our names and seeing them
```

Inside our `spec` directory, let's create a `features` directory. This will house our feature tests, which will be written using Capybara. A separate directory will separate feature tests from unit tests, which will be written in raw RSpec.

```
.
└── battle
    ├── spec
    │   ├── features
    │   └── spec_helper.rb
    ├── .rspec
    ├── Gemfile
    ├── Gemfile.lock
    ├── app.rb
    └── config.ru
```

Let's add our first feature test within that directory:

```
.
└── battle
    ├── spec
    │   ├── features
    │   │   └── enter_names_spec.rb
    │   └── spec_helper.rb
    ├── .rspec
    ├── Gemfile
    ├── Gemfile.lock
    ├── app.rb
    └── config.ru
```

To write our feature test, we need to think about the _exact_ actions a user would take. Here is a list of what users would **have to do** in order to meet the User Story:

- Visit the home page ('/')
- Fill in a text field with a name
- Fill in a second text field with a name
- Click a Submit button

If they have done all these things, what would users **expect to see**?

- A page with the words '(name one) vs. (name two)'

Almost every Capybara feature test involves this process:

1. What does the user have to do?
2. What does the user expect to see?

Learn it by heart - it'll stand you well in the next few challenges.

Let's translate our user actions into a Capybara feature test:

```ruby
# in spec/features/enter_names_spec.rb

feature 'Enter names' do
  scenario 'submitting names' do
    visit('/')
    fill_in :player_1_name, with: 'Dave'
    fill_in :player_2_name, with: 'Mittens'
    click_button 'Submit'
    expect(page).to have_content 'Dave vs. Mittens'
  end
end
```

> Note that we are using Capybara's `feature` and `scenario` syntax. These work just like `describe` and `it`, and we can use them interchangeably. This is because Capybara-RSpec is simply a bunch of helpful methods on top of RSpec. Capybara itself is simply a way of driving devices, like browsers, in a programmatic way.

Running `rspec` from the root directory gives us an error:

```sh
Failures:

  1) Enter names submitting names
     Failure/Error: fill_in :player_1_name, with: 'Dave'
     Capybara::ElementNotFound:
       Unable to find field :player_1_name
     # /Users/Sam/.rvm/gems/ruby-2.2.2/gems/capybara-2.5.0/lib/capybara/node/finders.rb:43:in `block in find'
     # /Users/Sam/.rvm/gems/ruby-2.2.2/gems/capybara-2.5.0/lib/capybara/node/base.rb:84:in `synchronize'
     # /Users/Sam/.rvm/gems/ruby-2.2.2/gems/capybara-2.5.0/lib/capybara/node/finders.rb:32:in `find'
     # /Users/Sam/.rvm/gems/ruby-2.2.2/gems/capybara-2.5.0/lib/capybara/node/actions.rb:58:in `fill_in'
     # /Users/Sam/.rvm/gems/ruby-2.2.2/gems/capybara-2.5.0/lib/capybara/session.rb:698:in `block (2 levels) in <class:Session>'
     # /Users/Sam/.rvm/gems/ruby-2.2.2/gems/capybara-2.5.0/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'
     # ./spec/features/enter_names_spec.rb:8:in `block (2 levels) in <top (required)>'

Finished in 0.03001 seconds (files took 0.68998 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/features/enter_names_spec.rb:6 # Enter names submitting names
```

What's the error? `Capybara::ElementNotFound`. What's the problem? Capybara is loading the contents of the `get '/'` route, but it can't find a text field with a name equal to `'player_1_name` there.

Let's create a route that renders an `index.erb` view:

```ruby
# in app.rb

get '/' do
  erb :index
end
```

And now let's create a `views` directory containing a view that solves the Capybara error:

```erb
<!-- in views/index.erb -->
<input type="text" name="player_1_name">
```

Running `rspec` again gives us another error. By working from error to error, we can skip ahead a few stages until we have the following in our `index.erb` view:

```erb
<form>
  <input type="text" name="player_1_name">
  <input type="text" name="player_2_name">
  <input type="submit" value="Submit">
</form>
```

When Capybara tries to submit the form, it fails. Let's fix that by asking the form to point to a specific route, and to use a `post` request (POST because we are trying to make the server 'remember' the names - i.e. we are **changing server state**):

```erb
<form action="/names" method="post">
  <input type="text" name="player_1_name">
  <input type="text" name="player_2_name">
  <input type="submit" value="Submit">
</form>
```

Now we have a new error. Fixing from error to error, we need to add a `post '/names'` route to our `app.rb`:

```ruby
# in app.rb

post '/names' do
  erb :play
end
```

And in `play.erb` we want to display the names our users just submitted from the form. We don't know how we're going to get them just yet, so let's use two dummy instance variables:

```erb
<!-- in views/play.erb -->
<%= @player_1_name %> vs. <%= @player_2_name %>
```

So we can pass these instance variables into the view, let's extract them from the `params` in the `post '/names'` action:

```ruby
# in app.rb

post '/names' do
  @player_1_name = params[:player_1_name]
  @player_2_name = params[:player_2_name]
  erb :play
end
```

Our tests pass! Now to refactor. Although our Ruby code is slim enough, our form kind of sucks: a user would have no way of knowing what to fill in. Let's add some `label` and `h1` elements to give a visiting user some more information:

```erb
<!-- in index.erb -->
<h1>Battle!</h1>
<h2>Sign in to play</h2>
<form action="/names" method="post">
  <label for="player_1_name">
    Player 1 name
    <input type="text" name="player_1_name">
  </label>
  <label for="player_1_name">
    Player 2 name
    <input type="text" name="player_2_name">
  </label>
  <input type="submit" value="Submit">
</form>
```

Much nicer. Now we have passed our first feature test, let's check in with the User Story:

```
As two Players,
So we can play a personalised game of Battle,
We want to Start a fight by entering our names and seeing them
```

It feels like we've solved that. Let's move on to the next one!

[Forward to the Challenge Map](../README.md)
