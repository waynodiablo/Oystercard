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

What we've been doing is restarting our server every time we made a change to the files because Sinatra needed to reload them. There's a way to reload the files without restarting the entire process.

Firstly, install a gem called **shotgun** by putting in your Gemfile and running 'bundle install'.

Secondly, load your application like this:

`$ shotgun hello.rb -p 4567`

The -p switch tells shotgun what port to use. Use this switch to keep the port consistent with the default Sinatra port. By default shotgun will use port 9393.

If you see a "Boot Error" when you're starting the application using shotgun, double check that you have required the _sinatra_ gem in the _Gemfile_ and ran "bundle install" afterwards.

## Basics of HTML and CSS

Now, let's make our website slightly more interesting. Let's add some HTML and CSS to the page. I assume you've already have a basic grasp of what they are but if not, here's a reminder.

HTML stands for HyperText Markup Language. It is the language that is used to create webpages. Every web page that you see in your browser is built using HTML. If you right-click the page you're reading right now and select 'View source', you'll see the HTML code for the current page.

HTML language consists of tags, enclosed in angle brackets. They usually come in pairs but sometimes they don't. For example, below is an example of an HTML code for an image inside a div tag - it stands for 'division'. A div tag usually signifies a section, a division of a document. The first **< div >** is called the _opening tag_ and the last **< /div >** is called the _closing tag_. Note that the closing tag has a slash after the angle bracket. 

````
<div>
  <img src='http://bit.ly/1eze8aE'>
</div>
````

The **< img >** tag doesn't need the closing tag as it is a 'self-closing tag'. The **src** bit is called an attribute. Its value determines what image will be displayed. In this case, _http://bit.ly/1eze8aE_ is a direct link to a kitten image.

If you put this html in a web page, it will be rendered by the browser like this:

![alt text](https://github.com/makersacademy/course/blob/master/pills/images/sinatra/sinatra_basic_3.png)

Let's try it:

````ruby
require 'sinatra'

get '/' do
  "<div>
    <img src='http://bit.ly/1eze8aE'>
   </div>"
end
````

Now go to the webpage: _http://localhost:4567/_ (if you aren't using shotgun, don't forget to restart the your web server: press Ctrl-C in the terminal and start it again).

![alt text](https://github.com/makersacademy/course/blob/master/pills/images/sinatra/sinatra_basic_4.png)

However, this image, as lovely as it is, is a bit dull. Real web pages have something else in them that makes them look good: CSS.

CSS stands for Cascading Style Sheets. It's a language that describes what HTML elements should look like when they are rendered by the browser. For example, let's add some CSS code to create a border around the **div** that contains our image.

````ruby
require 'sinatra'
get '/' do
  "<div style='border: 3px dashed red'>     
     <img src='http://bit.ly/1eze8aE'>    
   </div>"
end 
````

Now our web page looks like this:

![alt text](https://github.com/makersacademy/course/blob/master/pills/images/sinatra/sinatra_basic_5.png)

To achieve this effect we added an **attribute** called **style** to the **di**v element. Its **value** is "border: 3px dashed red". It defines what style is applied to the element, in this case a border, 3 pixels wide, dashed (as opposed to solid, for example), and red in colour.

By combining HTML and CSS we can achieve sophisticated visual effects in our web applications. We'll explore the basics of how HTML and CSS work in more details later this week and we'll discuss advanced HTML and CSS features in weeks 7 and 8.

## ERB: Separating your Ruby from your HTML and CSS

So, we've got a kitten inside a box with a red border. The code looks like this

````ruby
require 'sinatra'

get '/' do
  "<div style='border: 3px dashed red'>     
     <img src='http://bit.ly/1eze8aE'>    
   </div>"
end 
````

It works but you can already guess a problem: it doesn't scale. Web pages usually have hundreds, if not thousands lines of HTML and CSS code. That's on top of thousands of lines of Ruby code. Putting it all together in a single file would lead to a mess: lots of unstructured code that is very hard to maintain.

A better solution is to separate our Ruby and HTML code. Let's create a folder called **views**, located in the same directory as our _hello.rb_ file. Then create **views/index.erb**. Let's move the HTML code into the file we just created, so your project structure and the new file look like this:

![alt text](https://github.com/makersacademy/course/blob/master/pills/images/sinatra/sinatra_basic_6.png)

In our _hello.rb_ file we'll just put this instead:

````ruby
require 'sinatra'

get '/' do
  erb :index
end 
````

So, what's happening here? On line 4, we're calling **erb**, a templating system that ships with Ruby. We are asking it to render it a file called **index.erb** from the folder **views**. How does it know to look inside the folder **views**? The name of the folder is just a convention: if you don't specify any other name, erb will assume that you want to use the file in the **views** folder.

We just called **erb** a templating system. The reason is that it's actually much more powerful than it may seem on the surface. Erb stands for Embedded Ruby. This means that the templates can combine plain text, such as HTML code, with executable Ruby code.

Let's say we want to give our kitten a name. We aren't sure what the name actually is, so let's select it from an array of kitten names randomly.

````ruby
get '/' do
  @name = %w(Amigo Oscar Viking).sample
  erb :index
end
````

We've just selected a name for the kitten in the instance variable **@name**. Let's now display it on the web page. Update your HTML to look like this:

````html
<div style='border: 3px dashed red'>
  My name is <%= @name %>   
  <img src='http://bit.ly/1eze8aE'>
</div>
````

The second line contains the text and an embedded ruby tag. The code that begins with <% and ends with %> is an _erb_ tag, it is not part of HTML. Everything inside this tag is executed as Ruby code. In this case, we're just getting the value of **@name** variable. Because there is an = sign after the opening tag, the value will be "printed" to the resulting HTML. After erb processes this template, the HTML code that your browser actually sees will look like this:

````html
<div style='border: 3px dashed red'>
  My name is Oscar   
  <img src='http://bit.ly/1eze8aE'>
</div>
````

Technically, the **erb()** method reads the input file, processes Ruby that is inside and returns resulting HTML. This HTML is then returned by the block passed to the **get()** method.

So, we've just learned how to extract HTML into separate files and how to transfer data from Ruby code into templates. Let's add some more sophistication to our kitten website.

## Parameters (aka Params)

Our current web page is not interactive. It doesn't take any input from the user but that could be a very useful feature. Pretty much any website you see online is interactive and that's what makes the web such an exciting place.

Let's make our kitten say hello to the visitor of the website. Add this method to 

````ruby
get '/hello' do
  @visitor = params[:name]   
  erb :index 
end 
````

This method expects a parameter called name that can be provided like this:

`http://localhost:4567/hello?name=James`

This parameter can be accessed using the **params** hash. This is provided to you by Sinatra, you don't have to declare it anywhere. So, if we pass the parameter "name" as part of the URL, then "James" will be available in params[:name]. If necessary, you can specify multiple parameters separated by ampersands:

`http://localhost:4567/hello?name=James&last_name=Cameron`

The question mark in the url serves to separate the address from the list of parameters.

Now, if you modify your erb template to expect this value, you'll see a welcome message if a name is provided:

````html
<div style='border: 3px dashed red'>   
  <% if @visitor %>     
    Hello, <%= @visitor %>!   
  <% end %>   
  <% if @name %>
    My name is <%= @name %>   
  <% end %>
  <img src='http://bit.ly/1eze8aE'> 
</div>
````

Notice that we're not just printing the name of the visitor on the screen, we're putting a welcome message "Hello, #{@visitor}" only if the visitor is defined. This way it won't be printed when we open the root url ("/") that displays the same template. To achieve this we're using a usual if statement, embedding it inside <% %> tags. Because we don't want to output the results of the if statement, that is, line 2 into the HTML, we don't put = after the opening tag or the closing tag on line 4. We do the same for the @name variable.

Now, if we go to _http://localhost:4567/hello?name=James_, we'll get the welcome message.

![alt text](https://github.com/makersacademy/course/blob/master/pills/images/sinatra/sinatra_basic_7.png)

### Forms

It's inconvenient to enter the visitor's name directly in the URL. Let's create a form to ask for the visitor's name. Modify your erb template:

````html
<div style='border: 3px dashed red'>
  <% if @visitor %>  
    Hello, <%= @visitor %>!
  <% else %>
    <form action="/hello">
      My name is <%= @name %>.
      What's your name?
      <input type="text" name="name">
      <input type="submit">
    </form>
  <% end %>
  <img src='http://bit.ly/1eze8aE'>
</div>
````

This is what it's going to look like:

![alt text](https://github.com/makersacademy/course/blob/master/pills/images/sinatra/sinatra_basic_8.png)

So, what is happening in this code? First, we check if we have a value in @visitor. If we do, we greet the user. If we don't we display a form, described by yet another HTML tag.

The form tag creates a form that sends the data back to the server when it's submitted. The URL that the form data is sent to is defined by the **action** attribute. The data that is sent is determined by the fields that are present inside the form (before the closing </form> tag).

In this case we have two "input" fields. The first one is the input field (because it has type "text") and the second one is the submit button (because it has type "submit"). Even though they look and act differently, they are both created by the **input** tag.

Since the second input tag doesn't have any data in it (it's a button, after all), it won't be sent back to the server. But the first input tag will be. The string that you input into it will be sent back to the server as the "name" parameter because that's what we specified in the "name" attribute:

````html
<input type="text" name="name">
````

So, when you click the submit button, your browser sends a request to the URL specified in the **action** attribute of the form tag and sends all input fields from the **form** as parameters. That's why when you enter your name a click the button, you get redirected to /hello?name=YourName.

![alt text](https://github.com/makersacademy/course/blob/master/pills/images/sinatra/sinatra_basic_9.png)

## Static files

Earlier we've linked to an external image in our HTML. This is fine but it would be so much nicer to have the image as a part of our project. This would be a **static asset**, let's see how Sinatra handles them.

Let's put our image into **public/images/kitten.png** file in our project. The **public** folder doesn't exist, so create it as well as the images folder inside it. Now our file structure looks like this.

![alt text](https://github.com/makersacademy/course/blob/master/pills/images/sinatra/sinatra_basic_10.png)

Please note that the only file in the views folder so far is _index.erb. Gemfile, Gemfile.lock_ and _hello.rb_ are in the top-level project directory.

Now let's update our image tag to refer to the image:

````html
<img src='http://localhost:4567/images/kitten.png'>
````

You'll still see the image of the kitten but now it's loaded from localhost and not a remote server.

You probably have noticed that the address includes **images** folder but not the **public** folder. This is by design: Sinatra treats everything that's located inside the **public** folder as available via URLs. That's why by just putting a file there we were able to access it from the browser. This only works for the folder called **public**. You can't get to the views folder in the same way. The name is customisable, though: you can choose a different name for the **public** folder if you wish.

Of course, you can put anything you want inside this folder: not only images but also text files, executable files, CSS files (we'll get to them in a second) and many more things.

## Absolute vs relative URLs







