# Playing Battleships in the browser

This time we are going to improve on our battleships game. 
In [the last project](https://github.com/makersacademy/course/blob/master/battle_ships.md) 
we implemented the battleships game for the terminal. 

Whilst interacting with the computer on the terminal is an essential skill 
for us developer types, it is far from the preferred way to interact with 
your computer for people in general. When was the last time you checked your calendar on the terminal? **Exactly!**

Nowadays applications are much richer in colours and interactions, they feel 
smoother and friendlier that the terminal does.

The web offers a wonderful plethora of technologies and possibilities to 
build applications. It's time for us to look into web technologies and play 
with them.

**How about being able to  play battleships on the browser?**

## Version 0: Setting up

The first thing we have to do is to setup our project so that it's ready for us to start working on it.

Last week you created a playable battleships game for the terminal. You separated the logic of the game from the view ( _how the game is presented to the players_ ), making it extensible in that direction ( _if you did not, there is a version of battleships you can clone and use LINK_ ).

First we need to make sure that the code we wrote for battleships is in the right places. As before we will need a ``lib`` and a ``spec`` directory. [Sinatra](#) can work with only these directories, but in a _"real"_ project you will see a few more. By the end of this project our directory structure will look a little more complex than what we have seen so far:

````
.
|---README.md
|---config.ru
|---Gemfile
|---Gemfile.lock
|---features
    |---step_definitions
    |---support
|---lib
|---public
|---spec
|---views
    |---styles
    |---layouts
````

 **Hang on! We need a Gemfile!**

Our Gemfile helps us to keep track of the gems ( _and the versions of the gems_ ) we want to use in our project, so that when we clone the project from another computer we'll be able to  have all we need. Let's look at the Gemfile we are going to need during our project:

````ruby
source 'https://rubygems.org'

gem 'sinatra'

group :development, :test do
  gem 'capybara'
  gem 'cucumber'
  gem 'cucumber-sinatra'
  gem 'launchy'
  gem 'rspec'
  gem 'shotgun'
end
````

_You might have noticed that we have ordered the gems alphabetically. This is for practical reasons. In bigger projects that use a lot of different gems we want to make sure that we find them in our Gemfile fairly quickly._

Once you've bundled the `Gemfile` run `rspec` and make sure everything is working ( _did you remember to add your code into the lib and spec directories?_ ).

Now that your specs are passing and the code is all in place we are ready to start working on our battleships online game!

## Version 1: Building an application from the outside in

Everything is setup and ready, but how do we start? If you have been following best practices you know that you have to write a failing test before you write any code. That was a relatively easy task when we were talking about simpler applications. This time though we are building a full fledged web application; our friends and family can play with our app!

**Let's get started then, shall we?**

One of the gems you should have in your system now is ``cucumber-sinatra``. This gem will help you setting up cucumber.

Cucumber is a testing too written by Aslak Hellesøy that let's you describe your application in plain english. The description of your system, the features, will interact with your application and prove that it works as described (CUCUMBER PILL).

In your projects directory run:

````
cucumber-sinatra init --app  BattleShips lib/battleships.rb
Generating with init generator:
     [ADDED]  features/support/env.rb
     [ADDED]  features/support/paths.rb
     [ADDED]  features/step_definitions/web_steps.rb
     [ADDED]  lib/battleships.rb
     [ADDED]  config.ru
````

This has added some directories and files in our application directory. If we run cucumber now we will see the following output:

````
cucumber
0 scenarios
0 steps
0m0.000s
````

Let's write the first scenario of our first feature (`features/starting_a_game.feature`):

````
Feature: Starting the game
  In order to play battleships
  As a nostalgic player
  I want to start a new game

  Scenario: Registering
    Given I am on the homepage
    When I press "New Game"
    Then I should see "What's your name?"
````

Running cucumber now looks very different than it did before:

````
cucumber
Feature: Starting the game
  In order to play battleships
  As a nostalgic player
  I want to start a new game

  Scenario: Registering                   # features/starting_a_game.feature:6
    Given I am on the homepage            # features/step_definitions/web_steps.rb:19
    When I press "New Game"               # features/step_definitions/web_steps.rb:27
      Unable to find button "New Game" (Capybara::ElementNotFound)
      ./features/step_definitions/web_steps.rb:29:in `block (2 levels) in <top (required)>'
      ./features/step_definitions/web_steps.rb:14:in `with_scope'
      ./features/step_definitions/web_steps.rb:28:in `/^(?:|I )press "([^\"]*)"(?: within "([^\"]*)")?$/'
      features/starting_a_game.feature:8:in `When I press "New Game"'
    Then I should see "What's your name?" # features/step_definitions/web_steps.rb:107

Failing Scenarios:
cucumber features/starting_a_game.feature:6 # Scenario: Registering

1 scenario (1 failed)
3 steps (1 failed, 1 skipped, 1 passed)
0m0.053s
````

**What did just happen?** Cucumber is telling us that it cannot find a button named _New Game_ in the homepage. But, how is it possible that cucumber was able to go to the homepage? Which homepage? At this point in time we haven't even created anything apart from our feature file. What's going on?

Start your sinatra application

````
rackup
[2014-05-19 17:57:39] INFO  WEBrick 1.3.1
[2014-05-19 17:57:39] INFO  ruby 2.1.2 (2014-05-08) [x86_64-darwin13.0]
[2014-05-19 17:57:39] INFO  WEBrick::HTTPServer#start: pid=14728 port=9292
````

and point your browser to your application ( _[http://localhost:9292](http://localhost:9292)_ ).

Why is sinatra greeting us with a "Hello BattleShips!" message?

If you open your `lib/battleships.rb` file you will see why:

````ruby
require 'sinatra/base'

class BattleShips < Sinatra::Base
  get '/' do
    'Hello BattleShips!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
````

When we initialised cucumber with sinatra-cucumber we told it to generate our application as well. That's why we now have our battleships controller ready and waiting to change for us.

## Version 2: 
