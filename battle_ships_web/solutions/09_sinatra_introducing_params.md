# Solution – Sinatra: Introducing `params`

[Back to the Challenge](../09_sinatra_introducing_params.md)

Our current web page is not interactive. It doesn't take any input from the user. That could be a very useful feature! Pretty much any website you see online is interactive and that's what makes the web such an exciting place.

Let's change the name of our kitten depending on the user's preferences. Add a new _route_ to your application:

````ruby
get '/named-cat' do
  @name = params[:name]
  erb :index
end
````

The code here calls `params[:name]`, but where does that come from?  `params`, also known as the **params hash**, is provided by Sinatra; you don't have to declare it anywhere.  The params hash is a collection of all the parameters from the HTTP request.  One way to pass params to the HTTP request is to use the _query string_ portion of the URL.  For example:

http://localhost:4567/named-cat?name=James

The part that comes after `?` is the query string; `name=James`.  So, if we pass the parameter `name=James` as part of the URL, then "James" will be in `params[:name]`. If necessary, you can specify multiple parameters separated by ampersands:

http://localhost:4567/named-cat?name=James&last_name=Cameron

Now, if you modify your erb template to expect this value, you'll see a welcome message if a name is provided:

```html
<% if @name %>
<h1>My name is <%= @name %></h1>
<% end %>
<div style='border: 3px dashed red'>
  <img src='http://bit.ly/1eze8aE'>
</div>
```

Notice that we're not just printing the name of the visitor on the screen, we're printing `My name is #{@name}` only if the visitor is defined. This way it won't be printed when we open the root url ("/") that displays the same template. To achieve this we're using a usual `if` statement, embedding it inside `<% %>` tags. Because we don't want to output the results of the `if` statement, that is, line 2 into the HTML, we don't put `=` after the opening tag or the closing tag.

Now, if we go to http://localhost:4567/named-cat?name=James, we can change the name of our cat.

By playing with the query string, we can learn more about how it works. So we can better understand the link between the query string and `params`, let's print our `params` to the server logs on each visit to the `/named-cat` route:

```ruby
get '/named-cat' do
  p params
  @name = params[:name]
  erb :index
end
```

Let's visit the `/named-cat` route. We should expect something like this in our Terminal:

![`params` printed to the Terminal](../images/sinatra_params_terminal.jpg)

Keeping an eye on the printed `params` hash in the Terminal, let's change the query string in the following ways:

- **Values**. e.g. Go to http://localhost:4567/named-cat?name=Peter
- **Keys**. e.g. Go to http://localhost:4567/named-cat?color=blue
- **Number of `params`**. e.g. Go to http://localhost:4567/named-cat?name=Peter&color=blue&adorable=true

By experimenting further, you should be able to get a pretty good idea of how `params` work.

Github and switch! :twisted_rightwards_arrows:

It's a pain to interact with our app via the URL bar. Next up, let's allow our users to interact with our app via a `<form>` element.

[Forward to the Challenge Map](../00_challenge_map.md)