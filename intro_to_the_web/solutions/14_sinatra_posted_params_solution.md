# Solution – Sinatra: `POST`ed `params`

[Back to the Challenge](../11_sinatra_posted_params.md)

There are many parts to any HTTP request. Using the Sinatra server logs, here is an example:

![Annotated `GET` request](../images/sinatra_get_request_annotated.jpg)

Most relevant to us now is the **method**. There are two main HTTP methods (also called 'verbs'):

- **GET**: retrieve information
- **POST**: modify a resource

> There are [8 methods in total](http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html). Based on that link, why do you think we are focussing on these two only (for now)?

Since our form submission intends to change the name of our cat, we're (sort of) 'modifying' a resource, rather than retrieving information.

> Nothing will break if we mess up our HTTP methods. Sinatra is very configurable: if we want to, we could use write our app so it uses `POST` requests for retrieving stuff and `GET` requests only when pages to be retrieved had a green background. But there are conventions to HTTP: the ones outlined above. Messing with the conventions won't break anything, but it will be very difficult for future developers to work with highly unconventional code.

Let's separate our form and our image:

```ruby
# in app.rb
# first, let's write a form-displaying route
get '/cat-form' do
  erb :cat_form
end
```

Let's refactor our view, extracting the form to a separate `cat_form.erb` view:

```erb
<form action="/named-cat">
  <input type="text" name="name">
  <input type="submit" value="Submit">
</form>
```

Our app works just as before, with one difference: first, our users visit the `/cat-form` path. When they submit the form, they move on to the `/named-cat` path. The form submit happens via `GET` (this is the default). We can see the query string parameters when we submit the form from the first page.

Now, let's ask our form to submit its data as a `POST` request instead:

```erb
<form action="/named-cat" method="post">
  <input type="text" name="name">
  <input type="submit" value="Submit">
</form>
```

Now when we submit the form, we get Sinatra's 'undefined route' error. That's because we've only defined a route that can handle the request `GET /named-cat`. We don't have a route that can handle `POST /named-cat`.

Let's change our `/named-cat` route to handle `POST` requests instead of `GET` ones:

```ruby
# in app.rb
# first, let's write a form-displaying route
get '/cat-form' do
  erb :cat_form
end

post '/named-cat' do
  p params
  @name = params[:name]
  erb :index
end
```
Now try using your app. It should work just fine.

Some interesting things have happened as a result of changing our `GET` request to a `POST` request. 

First of all, the query string on the `/named-cat` page has disappeared. This is because `POST` requests do not story their query parameters in the request string. Instead, they store them in the body of the request as 'Form Data'.

Secondly, the `params` we print to the console have not changed. This is what we expect: although `POST` sends parameters from clients to servers in a different way to `GET`, it still sends them, and they are interpreted the same way by Sinatra.

In the next challenge, we will take a closer look at the HTTP requests we are sending by using the Chrome inspector.

[Forward to the Challenge Map](../00_challenge_map.md)