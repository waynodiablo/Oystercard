# Bundler

The recommended way of installing and managing gems is to use [bundler](http://bundler.io). [Bundler](http://bundler.io) is a program ( _and a ruby gem as well_) that is used to manage other gems. You install it manually (`gem install bundler`) but you use it to install and manage all other gems.

To use bundler, you need to tell it what gems you're using in your project. To do this, create a file called `Gemfile` ( **with capital G**) in the root directory of your project. A simple `Gemfile` may look like this:

````ruby
source 'https://rubygems.org'

gem 'sinatra'
````

The first line tells [bundler](http://bundler.io) to download the gems from [RubyGems.org](https://www.rubygems.org) ( _the source of the gems in the Ruby world_). The second line tells bundler that you want to use the _sinatra_ gem in your project. After you create the file, execute the following command

````
$ bundle install
````

This will download and install the latest version of the gem from [RubyGems.org](https://www.rubygems.org), as well as other gems that [Sinatra](http://sinatrarb.com) depends on.

Bundler and Gemfiles are particularly important when sharing projects you have built.  The Gemfile lets another developer know all the library dependencies your project has, and it also allows them to simply grab all the necessary dependencies by typing `bundle install` or even just `bundle`.

Note also that when you run `bundle` that bundler creates a file called Gemfile.lock, which stores the precise version of all the gems that your projects are using.  Check it out.  Don't edit that file, it's auto-generated and just for reference, but it is very important when you start deploying your app to a cloud hosting service like Heroku.  In that case Heroku will use the Gemfile.lock to ensure that the precise versions of every Gem you are using is installed correctly.  This is critical in order to ensure that we minimize discrepancies between the code that runs on your local development environment and that running in the cloud.

## Resources

- [Bundler](http://bundler.io)
- [Rubygems.org](https://www.rubygems.org)
