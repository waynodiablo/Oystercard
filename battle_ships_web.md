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

First we need to make sure that the code we wrote for battleships is in the right places. As before we will need a ``lib`` and a ``spec`` directory. [Sinatra](#) can work with only these directories, but in a _"real"_ project you will see a few more:

````
./battleships_web
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
		|---javascript
		|---layouts
````
 **Hang on! We need a Gemfile!**

Our Gemfile helps us to keep track of the gems ( _and the versions of the gems_ ) we want to use in our project, so that when we clone the project from another computer we'll be able to  have all we need. Let's look at the Gemfile we are going to need during our project.

````ruby
# Gemfile

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

## Version 1:

## Version 2: 
