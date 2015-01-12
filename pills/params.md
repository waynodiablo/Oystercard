# Params

## Overview

In the context of HTTP requests, parameters provide a way for information to be passed from a user to your application. Params are used to allow interactivity on a website, for example by allowing form data to be sent. 

Params are passed in the form of a hash, a series of key-value pairs.

There are several types of parameters that you can use to submit information to your app:

### Form Params

Form params are parameters that are passed from a web page to an application via a form submission. Consider the following code:

``` ruby
server.rb

  post ‘/form’ do
    @name = params[:name]
    puts params
    erb :params
  end
  
```

``` ruby
form.erb
  <form name="input" action=“/form” method=“post”>
  username: <input type=“text” name=“user”>
  password: <input type=“password” name=“password”>

  <input type=“submit” value=“Submit”>
  </form>
```

In form.erb you can see the first <form> tag contains 3 attributes: 
* name - This is the name of the form
* action - this is the path to which the form will be sent
* method - this is the type of HTTP request via which the form will be sent

When the user fills in their username and password, a POST request is sent to the /form path with a params hash. The server identifies this request and defines an instance variable @name that is available to the erb. It then prints the params to the console and serves a new template params.erb to the user.

### Query String Params

Query string parameters are passed to the application through the address bar, using a ? as so:

```
http://localhost:9393/whatsup?name=bruce&surname=wayne
```

The application can handle these params in the controller as follows:

``` ruby
get '/whatsup' do
  "Whats up " + params[:name] + " " + params[:surname]"
end
```

Query String params are fantastic because they allow you to have desc

### URL Path Parameters

These parameters are passed to the application as a part of the URL Path:
```
http://localhost:9393/hello/clark/kent
```

This can then be handled in the controller as follows:

``` ruby
get '/hello/:name/:surname' do
  "Hello " + params[:name] + " " + params[:surname]"
end
```

It is important to note that, unlike query string params, path params are sequential - that is, they have to appear in the URL in the order prescribed in the controller. 

Path params are great because they allow you to have descriptive paths that can be even be edited directly by the user. For a great example of this, check out Kayak.com - when you search for a flight, they use path params to display the result, e.g. ``` http://www.kayak.co.uk/flights/LON-SIN/2015-01-16/2015-02-12 ```

### Splat Parameters

Splat params are similar to Path params, but they use the wildcard '*' as a placeholder for anything.

Consider this URI:

```
http://localhost:9393/say/hello/to/snoopy
```

And this controller:

``` ruby
get '/say/*/to/*' do
  params[:splat][0] + ' ' + params[:splat][1] + '!'
end

# => 'hello snoopy!'
```

Sinatra will actually take the splat values and put them into an array that is stored in the params hash. So in this case, params would look something like this:

``` ruby
{:splat => ['hello', 'snoopy']}
```
### External resources
[Sinatra route matching](http://www.sinatrarb.com/intro.html)




### Exercise: 
*To-Do List*

* Write a to-do list - a simple 2 page sinatra application.

* On the 1st page, have a form with an input and a submit button. This form should post a request to the second page which should display the list. 

* There should be a list class that the server writes to - this could be an array. The second page should display the contents of this array.

* The code should of course be fully tested with Cucumber and/or RSpec.






