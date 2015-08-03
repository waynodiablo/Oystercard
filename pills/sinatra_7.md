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
      <input type="submit" value="Submit">
    </form>
  <% end %>
  <img src='http://bit.ly/1eze8aE'>
</div>
````

This is what it's going to look like:

![alt text](images/sinatra/sinatra_basic_8.png)

So, what is happening in this code? First, we check if we have a value in @visitor. If we do, we greet the user. If we don't, we display a form, described by yet another HTML tag.

The form tag creates a form that sends the data back to the server when it's submitted. The URL that the form data is sent to is defined by the **action** attribute. The data that is sent is determined by the fields that are present inside the form (before the closing </form> tag).

In this case we have two "input" fields. The first one is the input field (because it has type "text") and the second one is the submit button (because it has type "submit"). Even though they look and act differently, they are both created by the **input** tag.

Since the second input tag doesn't have any data in it (it's a button, after all), it won't be sent back to the server. But the first input tag will be. The string that you input into it will be sent back to the server as the "name" parameter because that's what we specified in the "name" attribute:

````html
<input type="text" name="name">
````

So, when you click the submit button, your browser sends a request to the URL specified in the **action** attribute of the form tag and sends all input fields from the **form** as parameters. That's why when you enter your name a click the button, you get redirected to /hello?name=YourName.

![alt text](images/sinatra/sinatra_basic_9.png)

Github and switch! :twisted_rightwards_arrows:

Next up, we'll chat about how to better organise our static assets, like images.

[Go to part 8](sinatra_8.md)

Resources
--------

* [Sinatra Main Site](http://www.sinatrarb.com/)
* [Sinatra Main Intro Documentation](http://www.sinatrarb.com/intro.html)
* [Talk Slides on Sinatra Chat Server](http://obfusk.org/achatwithsinatra/#1)
* [Detailed Talk Slides on Sinatra](http://www.slideshare.net/BobNadlerJr/sinatra-flatiron)
* [Sinatra Up and Running (Book)](http://shop.oreilly.com/product/0636920019664.do)
* [Jump Start Sinatra (Book)](http://www.sitepoint.com/store/jump-start-sinatra/)
