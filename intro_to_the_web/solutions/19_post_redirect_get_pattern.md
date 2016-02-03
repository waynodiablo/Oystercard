# Walkthrough – POST/`redirect`/GET pattern

[Back to the Challenge](../19_post_redirect_get_pattern.md)

Let's enable the `session` so we can store information between requests.

> A `session` is a short-term information store that lives on the server. It's very small, but it allows the server to store basic pieces of information, like the name of the current user, across multiple requests. In Sinatra, `session` is a Hash, and you can set values for its keys. `session` is most often used to store details of a logged in user.

```ruby
# in app.rb
class Battle < Sinatra::Base
  enable :sessions

  get '/' do
    erb :index
  end
 
  post '/names' do
    # etc.
```

In the `post '/names'` route, let's store the player names in the session instead of assigning them to instance variables:

```ruby
# in app.rb
post '/names' do
  session[:player_1_name] = params[:player_1_name]
  session[:player_2_name] = params[:player_2_name]
  erb :play
end
```

Running `rspec`, we can see our test is now failing: by removing the `@player_1_name` and `@player_2_name` instance variables, we can no longer access them from the `play.erb` view. Let's render that view from a new `get '/play'` route, where we'll extract the required instance variables from the `session` instead:

```ruby
# in app.rb
get '/play' do
  @player_1_name = session[:player_1_name]
  @player_2_name = session[:player_2_name]
  erb :play
end
```

Now, we want the user to:

1. submit the form to `post '/names'`
2. extract the submitted names from the `params` into the `session`
3. redirect to `get '/play'`
4. extract the names from the `session` to instance variables

So we need to redirect the user after they post to `/names`:

```ruby
# in app.rb
post '/names' do
  session[:player_1_name] = params[:player_1_name]
  session[:player_2_name] = params[:player_2_name]
  redirect '/play'
end
```

> `redirect '/route'` will issue an 'internal GET request' within the server. Check your server logs when you submit the form: you'll see a POST request with the form params, followed by a GET request (the redirect). That internal GET request will activate the `get '/play'` action, which will render the `play.erb` view.

If we run `rspec` again, our feature test will pass. Congratulations, you have refactored a POST request that renders a view to use a POST-redirect loop! OK, let's do another user story.

[Forward to the Challenge Map](../00_challenge_map.md)