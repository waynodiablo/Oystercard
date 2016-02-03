# Walkthrough – Getting Started with Battle

[Back to the Challenge](../17_getting_started_with_battle.md)

Our project directory should look something like this:

```
.
└── battle
```

Let's add a Gemfile for our dependencies using `bundle init`.

> Including a Gemfile means any future developer starting our project can install all project dependencies by running `bundle`.

```
.
└── battle
    └── Gemfile
```

Inside our Gemfile, let's add the dependencies:

```ruby
# In Gemfile
source 'https://rubygems.org'

gem 'sinatra'
gem 'rspec-sinatra'
gem 'capybara'
```

And use `bundle` to install those dependencies to our project (generating a Gemfile.lock).

From the [`rspec-sinatra` Github page](https://github.com/tansaku/rspec-sinatra) we can initialize our app from the command line, with RSpec and Capybara all set up:

```sh
rspec-sinatra init --app Battle app.rb
```

Our project directory now looks like this:

```
.
└── battle
    ├── spec
    │   └── spec_helper.rb
    ├── .rspec
    ├── Gemfile
    ├── Gemfile.lock
    ├── app.rb
    └── config.ru
```

Inside our `app.rb`, we have an application `Battle` set up to use Sinatra's [Modular Style](http://www.sinatrarb.com/intro.html#Sinatra::Base%20-%20Middleware,%20Libraries,%20and%20Modular%20Apps):

```ruby
# in app.rb

require 'sinatra/base'

class Battle < Sinatra::Base
  get '/' do
    'Hello Battle!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
```

> Sinatra's Modular Style allows you to use a slimmed-down version of Sinatra that is more modular and portable.

OK, we're done with this challenge. Next up, we'll implement our first User Story.

[Forward to the Challenge Map](../00_challenge_map.md)