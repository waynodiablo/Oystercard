# Sinatra

[Sinatra](http://www.sinatrarb.com/) is a simple, no-frills web application framework for Ruby. It allows you to integrate applications written in Ruby with a web interface, so anyone with a browser can use them. In contrast to more complex web application frameworks such as [Ruby on Rails](http://rubyonrails.org), Sinatra provides very little beyond making your ruby code accessible to requests that come over the HTTP protocol.

> Sinatra is one of many simple web application frameworks.  You can read about some of the alternatives in [this blog post](http://www.sitepoint.com/ruby-microframeworks-round/).


As with every pill and project please do type in the code examples instead of copy-pasting them, it will help you to memorize and understand what you're doing.

***As always there may be subtle errors in the following materials.  Please try to approach any of these as challenges on which to polish your debugging skills - pull requests very welcome.***

## What you will learn

* How to set-up and use Sinatra
* Routes
* Templates
* Forms
* Parameters

## Prerequisites

You should be fully proficient in Ruby (post-precourse standard), including [blocks&nbsp;:pill:](blocks.md). For later parts of this walkthrough, you will also need to be proficient with [HTML&nbsp;:pill:](html.md) and [CSS&nbsp;:pill:](css.md).

## Sinatra Installation

***Note, we recommend working through this pill with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill&nbsp;:pill:](pairing.md).***

As with every bit of non-trivial code you write it's a good idea to initialise a git repository and push your code to Github in order to back it up.  Put the following code in a Github repo called `sinatra-test`.

As mentioned above, Sinatra is just a Ruby [gem](gems.md) :pill:, so you'll need to install it as usual:

`$ gem install sinatra`

> Where does this install the Sinatra gem?

However, a better way would be to put it in your Gemfile:

```ruby
# Gemfile
source 'https://rubygems.org'
gem 'sinatra'
```

and install using [bundler](bundler.md) :pill::

`$ bundle install`

There are two advantages to this approach. Firstly, you'll be keeping a record of what gems are used in the project for other developers to see. Secondly, it will help Shotgun (we'll discuss it in a minute) to load Sinatra.

Once you have installed Sinatra, you are ready to create a web-accessible _Hello World_ application. Let's do that now.

[Go to part 2](sinatra_2.md)

Resources
--------

* [Sinatra Main Site](http://www.sinatrarb.com/)
* [Sinatra Main Intro Documentation](http://www.sinatrarb.com/intro.html)
* [Talk Slides on Sinatra Chat Server](http://obfusk.org/achatwithsinatra/#1)
* [Detailed Talk Slides on Sinatra](http://www.slideshare.net/BobNadlerJr/sinatra-flatiron)
* [Sinatra Up and Running (Book)](http://shop.oreilly.com/product/0636920019664.do)
* [Jump Start Sinatra (Book)](http://www.sitepoint.com/store/jump-start-sinatra/)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/sinatra_1.md)
