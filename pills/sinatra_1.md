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

![alt text](https://github.com/makersacademy/course/blob/master/pills/images/sinatra/sinatra_basic_1.png)

Now, let's make it happen. Create a new file _hello.rb_ and type the following:

````ruby
require 'sinatra'

get '/' do
  'hello!'
end
````

Now, run this file.

`$ ruby hello.rb`

You should see this:

```
== Sinatra/1.4.3 has taken the stage on 4567 for development with backup from Thin 
>> Thin web server (v1.5.1 codename Straight Razor) 
>> Maximum connections set to 1024 
>> Listening on localhost:4567, CTRL+C to stop 
```

Now, open this address (http://localhost:4567) in the browser and you should see a white page with "hello!" in the upper left corner.

### What does localhost:4567 mean?

This means that Sinatra started running making your web application available on the address _http://localhost:4567_. The address looks different from most web addresses but in fact it's a normal web address. The 'localhost' is a reserved word that always refers to the computer it's used on. So, localhost on my machine means my machine and localhost on your machine means your machine. Technically, it corresponds to the IP address 127.0.0.1 that always points to the current machine. The 4567 is the number of the port that is used to connect to localhost. Every internet connection always needs at least two parameters: the address of the machine (localhost, google.com or an IP address) and a port (80, 3000, 4567 or some other). So, in this case Sinatra is listening for connections on localhost and on port 4567.

You may ask why you don't normally specify a port when you connect to a web server? Why can you type google.com in the address bar and it will work without the port? The reason is that by convention, web servers usually run on port 80, so your browser assumes you want to use port 80 if you don't specify any. So, when you type this in the address bar

`www.google.com`

your browser actually opens the connection to

`www.google.com`

You can try putting the port in the browser bar, it will work just as fine. If you try to put a port number that google.com doesn't expect, you won't get a response. For example, you'll get an error if you do this

`www.google.com:22`

As we mentioned, the port 80 is reserved for web (HTTP) connections but there are many more. For example, ssh uses port 22 and https (encrypted HTTP connection) usually run on port 443. However, all of those are just conventions. Nothing prevents you from running an ssh server on port 80, if you insist on it.

## How does it work?

So, let's take a look at the source code again.

````ruby
require 'sinatra'

get '/' do
  'hello!'
end
````

First, we require Sinatra, the gem, to be available in our application. Then we call the _get()_ method, provided by Sinatra, passing '/' as an argument - this could therefore be re-written get('/') but the convention is to ignore the brackets. What you're telling the Sinatra to do is to _get_ whatever the block returns, in this case the string 'hello!' whenever someone requests it by calling the page at the address '/'.

The '/' part of the address is the last slash in _http://localhost:4567/_. If we wanted to have another page at http://localhost:4567/secret, then we'd do the following

````ruby
require 'sinatra'

get '/' do
  'hello!'
end

get '/secret' do
  'This is a secret page'
end
````

Having done this on your Sinatra application and gone to http://localhost:4567/secret on your browser, you found the following page:

![alt text](https://github.com/makersacademy/course/blob/master/pills/images/sinatra/sinatra_basic_2.png)

### What's happening?

Nothing to worry about. What Sinatra is telling you is that it doesn't know what '/secret' is all about, despite you've written this in your app.

What's happening is that you haven't re-loaded the application server, so the server doesn't know about this new '/secret' address is all about.

First things first, go back to terminal and press Ctrl-C to stop the server. Then re-start it by writing:

`$ ruby hello.rb`

Now go back to _http://localhost:4567/secret_ and magic: it now works... but what a painful process.

## Automatic code reloading















































