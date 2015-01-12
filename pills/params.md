# Params

## Overview

In the context of HTTP requests, parameters provide a way for information to be passed from a user to your application. Bearing in mind that browsers essentially 'forget' information between in each page refresh, params are necessary to allow interactivity on a website. 

Params are passed in the form of a hash, a series of key-value pairs.

There are several types of parameters that you can use to submit information to your app:

### Form Params

Form params are parameters that are passed from a web page to an application via a form submission. Consider the following code:

```
server.rb

  post ‘/form’ do
    @name = params[:name]
    puts params
    erb :params
  end
  
```

```
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

Exercise: 
  * create a small application with a form
  * upon form submission, display a new page to the user with the contents of the form
  * print the params hash to console

### Query String Params

Query string parameters are passed to the application through the address bar, using a ? as so:

```
http://localhost:9393/whatsup?name=bruce&surname=wayne
```

The application can handle these params in the controller as follows:

```
get '/whatsup' do
  "Whats up " + params[:name] + " " + params[:surname]"
end
```
### URL Path Parameters

These parameters are passed to the application as a part of the URL Path:
```
http://localhost:9393/hello/clark/kent
```

This can then be handled in the controller as follows:

```
get '/hello/:name/:surname' do
  "Hello " + params[:name] + " " + params[:surname]"
end
```








