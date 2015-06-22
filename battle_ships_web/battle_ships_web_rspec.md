# Playing Battleships in the browser

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

In this project we are going to take our battleships game to the next level.
In [the last project](../battle_ships/battle_ships.md) we implemented the battleships game for the terminal.  Please refer to the [learning objectives](learning_objectives.md) for a list of everything we're hoping to cover this week.

Whilst interacting with the computer on the terminal is an essential skill for us developer types, it is far from the preferred way to interact with computers for people in general. Before you even knew there was a terminal you likely did almost everything on a computer via a graphical interface of some sort; either through a dedicated desktop application or through a browser.

Back in the day the terminal was the only way to interact with a computer. Nowadays, application interactions are richer and more colourful: a graphical interface feels smoother and friendlier than the terminal does.

The web offers a wonderful plethora of technologies and possibilities to build applications.  Web applications that run in a browser are different from dedicated desktop applications (like MS Word) that have to be installed separately on each individual computer.  Web applications can be accessed from any computer that has a browser, simply by pointing the browser at the correct web page or URL (Uniform Resource Locator, e.g. http://google.com).  This means if you want to create a new 'app' you can just share the link to it, rather than having to ask your users to go through a potentially complex and error prone installation process.  The flipside is browser compatibility issues, but more on that later.

**In the meantime, how about being able to play battleships in a browser?**

In order to share whatever we're building on our computer with the rest of the world, on the Web, we need to learn how to build web applications using _"web application frameworks"_.

Have you heard of 'Ruby on Rails'? Ruby is the language: Rails is the web application framework. A Ruby on Rails application is one that uses the Rails web application framework with the Ruby language.

A web application framework for Ruby is a gem (library) that provides support to make our Ruby code accessible to the web browser. There are plenty of web application frameworks available for the Ruby language; the two we focus on in the Makers Academy course are Sinatra and Rails, in that particular order.

## Why start with Sinatra?

Sinatra, unlike Rails, has a minimal feature set that will allow us to keep our web applications very simple. Because of Sinatra's simplicity, we will be able to focus on the basic elements of a web application, as opposed to the features of the framework. Once you have a good understanding of how Sinatra applications work, it will be much easier to get a deeper understanding of how Ruby on Rails works.

Despite its simplicity, Sinatra is very powerful. A large number of websites and applications are built on Sinatra. There's a very incomplete list of [companies using it in the wild](http://www.sinatrarb.com/wild.html). The real number is certainly orders of magnitude bigger.

***As usual please work on this project with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill](pills/pairing.md) :pill:.***

## Prerequisites

Please ensure you have a good understanding of [Sinatra](../pills/sinatra_1.md) :pill: and [Capybara](../pills/capybara.md) :pill: before starting this project.  Capybara is a Ruby library that supports grabbing pieces of HTML web pages and taking actions like clicking links and filling in forms - please refer to the pills for details.  We'll use Capybara to write the acceptance tests for our game.

## Version 0: Setting up

The first thing we have to do is to setup our project so that it's ready for us to start working on it.

Last week you created a playable battleships game for the terminal. You separated the logic of the game from the view ( _how the game is presented to the players_ ), making it modifiable in terms of what interface it is played through, e.g. terminal, web, desktop app etc.  **If you were unable to complete your game logic or separate your game logic from your view logic, here are some versions of a battleships game engine you can use as an alternative:**

* [Steve's BattleShips](https://github.com/makersacademy/battle_ships_september)
* [Tansaku's BattleShips](https://github.com/tansaku/battleships_mvp_sequence)
* [Ben's Battleships](https://github.com/silvabox/battleships) (`gem install battleships`)

Note, if you use Ben's version, you should install it as a gem.  If you do this, you can start this walkthrough in a clean folder with no code.

Start by creating a BattleshipsWeb folder in your projects directory.

If you are importing your own battleships code, or code from one of the examples other than the gem, make sure that the code is in the right places. As before we will need a `lib` and a `spec` directory.

[Sinatra](../pills/sinatra_1.md) can work with just these directories, but in a _"real"_ project you will see a few more. By the end of this project our directory structure will look a little more complex than anything we have seen so far:

```
.
|---README.md
|---config.ru
|---Gemfile
|---Gemfile.lock
|---lib
|---public
|---spec
    |---features
|---views
    |---styles
    |---layouts
```

We will review what all these files and directories do as we come to them.

 **First things first! We need a Gemfile!**

Let's start with a Gemfile. Our Gemfile helps us to keep track of the [gems](../pills/gems.md) ( _and the versions of the gems_ ) we want to use in our project, so that when we clone the project from another computer we'll be able to easily install everything we need. Let's look at the Gemfile we are going to need during our project:

```ruby
source 'https://rubygems.org'

gem 'battleships' # if you are using Ben's gem
gem 'sinatra'

group :development, :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rspec'
  gem 'rspec-sinatra'
  gem 'shotgun'
end
```

_You might have noticed that we have ordered the gems alphabetically. This is for practical reasons. In bigger projects that use a lot of different gems we want to make sure that we find them in our Gemfile fairly quickly._

Once you've bundled the `Gemfile` run `rspec` and make sure everything is working ( if you are not using the gem, _did you remember to add your battleships code into the lib and spec directories?_ ).

Now that your specs are passing and the code is all in place we are ready to start working on our battleships online game!

Commit your code to Git (you'd already done this though, right?).

## Version 1: Building an application from the outside in

Everything is set up and ready, but how do we start? If you have been following best practices you know that you have to write a failing test before you write any code. That was a relatively easy task when we were talking about simpler applications. This time though we are building a full-fledged web application; our friends and family can play with our app!

**Let's get started then, shall we?**

One of the gems you should have in your system now is `rspec-sinatra`. This gem will help you setting up RSpec to work with Sinatra.

Within your BattleshipsWeb directory, run:

```shell-session
$ rspec-sinatra init --app  BattleshipsWeb lib/battleships_web.rb
Generating with init generator:
     [ADDED]  spec/spec_helper.rb
     [ADDED]  lib/battleships_web.rb
     [ADDED]  config.ru
```

This will add some directories and files to our application directory.  You can use `git status` to quickly see what's new.  Have a look at the new files and see if you can work out what they are for.  Then commit the changes so you are back to a clean working directory.

Now we're ready to write our first test, but what sort of test should that be?  So far, we've been writing _unit_ tests using RSpec and testing our features using IRB.  That's been OK up to now: each time we've needed a feature, our 'feature tests' have helped us to understand which unit tests to write next.  However, as our application gets larger, relying on manual feature tests is going to become unwieldy.  Wouldn't it be nice if we could automate our feature tests as well?

Well, we can.  If you think about it, everything we've written in IRB could have been written within one or more RSpec tests. The advantage of this would be every time we run RSpec it would run all of our feature tests too.

Let's look at an example for Battleships.  We want to test that we can hit a ship after it has been placed on the board:

```sh
$ irb
2.0.0-p195 :001 > require 'battleships'
 => true
2.0.0-p195 :002 > board = Board.new
 => #<Battleships::Board:0x007fd34225b5f8>
2.0.0-p195 :003 > ship = Ship.destroyer
 => #<Battleships::Ship:0x007fd341a4af08 @type=:destroyer, @size=2, @hits=0>
2.0.0-p195 :004 > board.place_ship ship, :B2, :vertically
 => [#<Battleships::Ship:0x007fd341a4af08 @type=:destroyer, @size=2, @hits=0>]
2.0.0-p195 :005 > board.receive_shot :B3
 => :hit
```
What might that look like as a feature test?
```
describe 'shooting at the board' do
  it 'results in :hit if there is a ship' do
    board = Board.new
    ship = Ship.destroyer
    board.place_ship ship, :B2, :vertically
    expect(board.receive_shot :B3).to eq :hit
  end
end
```
Note how this differs from a unit test.  Firstly, _we are not using doubles_.  Secondly, we are not describing a specific class, such as `Board`.  It is not necessarily clear which component is under test, and that's the point: we are testing the _feature_ and not the _units_.

Suppose we had written that feature test _first_ - before writing any unit tests. It would fail, of course. But, the failure would point us in the right direction to write our code: **the feature test contains code we wish we had**.  It gives us a clear starting point to go and start writing unit tests.  It may be quite a while before we can actually get that feature test to pass, but when it does, we'll have achieved a significant amount.  We could then choose the next feature to test and so on.  This is a very useful technique and is one of the cornerstones of Behaviour Driven Development (BDD), which you should read about here: [BDD&nbsp;:pill:](../pills/bdd.md) and [BDD cycle&nbsp;:pill:](../pills/bdd_cycle.md).


So what are the features we want to test for BattleshipsWeb?  We've already tested the API; now we want to test the user interface...

Let's write the first scenario of our first feature (`spec/features/starting_a_game_spec.rb`):

```ruby
require 'spec_helper'

feature 'Starting a new game' do
  scenario 'Starting a new game' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end
end
```

The `feature` and `scenario` methods are provided by Capybara.  They're just synonyms for RSpec's `describe` and `it` and they help to differentiate these as feature tests.

```shell-session
$ rspec

Starting a new game
  I am asked to enter my name (FAILED - 1)

Failures:

  1) Starting a new game I am asked to enter my name
     Failure/Error: click_link 'New Game'
     Capybara::ElementNotFound:
       Unable to find link "New Game"
     # /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/capybara-2.4.4/lib/capybara/node/finders.rb:41:in `block in find'
     # /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/capybara-2.4.4/lib/capybara/node/base.rb:84:in `synchronize'
     # /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/capybara-2.4.4/lib/capybara/node/finders.rb:30:in `find'
     # /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/capybara-2.4.4/lib/capybara/node/actions.rb:27:in `click_link'
     # /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/capybara-2.4.4/lib/capybara/session.rb:676:in `block (2 levels) in <class:Session>'
     # /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/capybara-2.4.4/lib/capybara/dsl.rb:51:in `block (2 levels) in <module:DSL>'
     # ./spec/feature/starting_a_game_spec.rb:6:in `block (2 levels) in <top (required)>'

Finished in 0.01883 seconds (files took 0.29812 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/feature/starting_a_game_spec.rb:4 # Starting a new game I am asked to enter my name
```

**What just happened?** RSpec is telling us that it cannot find a link named _New Game_ in the homepage. But, how is it possible that RSpec was able to go to the homepage? Which homepage? At this point in time we haven't even created anything apart from our feature file. What's going on?

Start your sinatra application

```shell-session
rackup
[2014-05-19 17:57:39] INFO  WEBrick 1.3.1
[2014-05-19 17:57:39] INFO  ruby 2.1.2 (2014-05-08) [x86_64-darwin13.0]
[2014-05-19 17:57:39] INFO  WEBrick::HTTPServer#start: pid=14728 port=9292
```

and point your browser to your application ( _[http://localhost:9292](http://localhost:9292)_ ).

Why is Sinatra greeting us with a "Hello BattleshipsWeb!" message?

If you open your `lib/battleships_web.rb` file you will see why:

````ruby
require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base
  get '/' do
    'Hello BattleshipsWeb!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
````

When we initialised RSpec with sinatra-rspec we told it to generate our application as well. That's why we now have our BattleshipsWeb controller returning that greeting.

To make the first step work we need to do a few things:

- create a views directory
- tell our `BattleshipsWeb` controller where the views are:
```set :views, proc { File.join(root, '..', 'views') }``` inside your BattleshipsWeb class.
- create an `index.erb` file with the html ( _containing a link with the text 'New Game'_ )
- adjust the BattleshipsWeb class like so:

````ruby
require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base
  get '/' do
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
````

Running rspec again after we have finished these tasks we will see the following:

```shell-session
rspec

Starting a new game
  I am asked to enter my name (FAILED - 1)

Failures:

  1) Starting a new game I am asked to enter my name
     Failure/Error: expect(page).to have_content "What's your name?"
       expected to find text "What's your name?" in "New Game"
     # ./spec/feature/starting_a_game_spec.rb:7:in `block (2 levels) in <top (required)>'

Finished in 0.03161 seconds (files took 0.4445 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/feature/starting_a_game_spec.rb:4 # Starting a new game I am asked to enter my name

```

**We are almost there!** Now we only need to change the button so that it actually takes us to a new page that will ask us for our name. Once we have done this we will see the following output from RSpec:

```shell-session
rspec

Starting a new game
  I am asked to enter my name

Finished in 0.03279 seconds (files took 0.42197 seconds to load)
1 example, 0 failures
```

OK, our specs are passing now, but there is something wrong with the scenario we specified; it said "I am asked to enter my name", but we hardly have registered for a new game... Can you modify the scenario to add the necessary steps to make it pass?

**Tasks**

- Add steps to the scenario
- Add a scenario for when the player does not input his name

**Exercises**

* Allow the user to play against the computer by shooting at a randomly generated computer opponent board

## Version 2: Making the game playable by two people

We now have the first walking skeleton of our application and we are ready to add more features to describe our application.

For this to happen we need to introduce the concept of a session to our application and make it _remember_ who is playing against whom. We also need to make sure that our application only allows 2 players per game.

**Task: Write the following features (and add the functionality to the application):**

- Registering a second player
- Placing the ships
- Shooting at each others boards in turns
- Winning and loosing

## Version 3: Multigame battleships

Up until now our application has been running only for two players at a time. Can you make it work with any amount of players and games ( obviously with two players per game )?

## Final touches

It would be nice if our battleships game looked like something that people wanted to play with, maybe we should be looking at it :wink:

Once we have added some CSS goodness let's deploy our application to :pill: [heroku](../pills/heroku.md) and share it with the world!

**Congratulations! You have released your first application!**

Resources
---------

* [The Internet and WWW](../pills/internet_web.md)
