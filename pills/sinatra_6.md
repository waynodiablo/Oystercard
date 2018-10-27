## Parameters (aka Params)

Our current web page is not interactive. It doesn't take any input from the user but that could be a very useful feature. Pretty much any website you see online is interactive and that's what makes the web such an exciting place.

Let's make our kitten say 'hello' to the visitor of the website. Add a new _route_ to your application:

````ruby
get '/hello' do
  @visitor = params[:name]
  erb :index
end
````

The code here calls `params[:name]`, but where does that come from?  `params`, also known as the **params hash**, is provided by Sinatra; you don't have to declare it anywhere.  The params hash is a collection of all the parameters from the HTTP request.  One way to pass params to the HTTP request is to use the _query string_ portion of the URL.  For example:

http://localhost:4567/hello?name=James

The part that comes after `?` is the query string; `name=James`.  So, if we pass the parameter `name=James` as part of the URL, then "James" will be in `params[:name]`. If necessary, you can specify multiple parameters separated by ampersands:

http://localhost:4567/hello?name=James&last_name=Cameron

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

Notice that we're not just printing the name of the visitor on the screen, we're putting a welcome message `Hello, #{@visitor}` only if the visitor is defined. This way it won't be printed when we open the root url ("/") that displays the same template. To achieve this we're using a usual `if` statement, embedding it inside `<% %>` tags. Because we don't want to output the results of the `if` statement, that is, line 2 into the HTML, we don't put `=` after the opening tag or the closing tag on line 4. We do the same for the `@name` variable.

Now, if we go to http://localhost:4567/hello?name=James, we'll get the welcome message.

![alt text](images/sinatra/sinatra_basic_7.png)

Github and switch! :twisted_rightwards_arrows:

Next up, let's allow our visitor to interact with our app via a `<form>` element.

[Go to part 7](sinatra_7.md)

Resources
--------

* [Sinatra Main Site](http://www.sinatrarb.com/)
* [Sinatra Main Intro Documentation](http://www.sinatrarb.com/intro.html)
* [Talk Slides on Sinatra Chat Server](http://obfusk.org/achatwithsinatra/#1)
* [Detailed Talk Slides on Sinatra](http://www.slideshare.net/BobNadlerJr/sinatra-flatiron)
* [Sinatra Up and Running (Book)](http://shop.oreilly.com/product/0636920019664.do)
* [Jump Start Sinatra (Book)](http://www.sitepoint.com/store/jump-start-sinatra/)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/sinatra_6.md)
