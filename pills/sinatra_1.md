# Sinatra

We hope you've enjoyed moving Boris bikes around and building the battleships game.

Now it's time to share whatever you're building on your computer with the rest of the world, on the Web. In order to do so, we need to learn how to build web applications using _"web application frameworks"_.

Have you heard of Ruby-on-Rails? Ruby here is the language whereas Rails is the web application framework. You're thefore using the Rails web application framework (referred to as a framework) with the Ruby language.

A framework is a library, a ruby gem that makes our Ruby code accessible to the web browser. There are plenty of web application frameworks available for the Ruby language; the two we will cover are Sinatra and Rails, in this particular order.

## Why start with Sinatra?

Sinatra, unlike Rails has a minimal feature set that will allow us to keep our web applications very simple. Because of Sinatra's simplicity, we will be able to focus on the basic elements of a web application, as opposed to the features of the framework. Once you understand well how Sinatra applications work, it will be much easier to get a deeper understanding of how Ruby on Rails works. Trust us, we've tested many ways and we found this is the best way for you to learn.

Despite its simplicity, Sinatra is very powerful. A large number of websites and applications are built on Sinatra. There's a very incomplete list of [companies using it in the wild](http://www.sinatrarb.com/wild.html), it is certainly orders of magnitude bigger.

You are encouraged to type in the code instead of copy-pasting it, it will help you to memorise and understand what you're doing.

## What you will learn

* How to set-up and use Sinatra
* Routes
* Introduction to HTML & CSS

## Prerequisites

You should have a good understanding of Ruby, including how blocks work.

## Sinatra Installation

As it was mentioned above, Sinatra is just a Ruby gem, so you'll need to install it as usual.

`$ gem install sinatra`

However, a better way would be to put it in your Gemfile and install using bundler. There are two advantages to this approach. Firstly, you'll be keeping a record of what gems are used in the project for other developers to see. Secondly, it will help shotgun (we'll discuss it in a minute) to load sinatra.

````ruby
# this is Gemfile
source 'https://rubygems.org'
gem 'sinatra'
````

`$ bundle install`

Once you have installed Sinatra, you are ready to create the "hello, world" application.

## "Hello, world" application

Let's create the most basic web application using Sinatra. It will have only one page and on this page there will be "hello!" text. This is what it will look like.




















