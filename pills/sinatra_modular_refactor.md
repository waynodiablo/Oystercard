# How to Refactor with Sinatra

## The Problem.
Unlike Rails, Sinatra allows us a great deal of flexibility in how we organize our code. One benefit of this is that it allows a natural development process: our app can start as a small single, easily understandable unit, and as it grows, its parts can gradually be broken out.

Things get messy when we don't take that refactor step.

This pill will take you through the process of refactoring your routes. Consider the following (as we're not concerned with the body of the routes they've been omitted):


``` ruby
# /app/app.rb
require 'sinatra'

get '/links' do
  # etc
end

post '/links' do
  # etc
end

get '/user/:id' do
  # etc
end

post '/users' do
  # etc
end

get '/session/new' do
  # etc
end

post '/session' do
  # etc
end

delete '/session' do
  # etc
end
```

There are a couple of problems here:
1. As we add more routes, our `app.rb` file will become unmanageably large.
2. We're mixing routes associated with different resources, links, users, and sessions in the same file

We might be better off splitting out our routes into separate ["controllers"](http://blog.codinghorror.com/understanding-model-view-controller/) files to get the following directory structure:

```bash
├── app.rb
├── models
│   ├── user.rb
│   └── link.rb
├── controllers
│   ├── link.rb
│   ├── session.rb
│   └── user.rb
└── views
    ├── link
    │   ├── index.erb
    │   └── new.erb
    ├── session
    │   └── new.erb
    └── user
        └── new.erb

```
And, for example, our `/controllers/link.rb` would look like:


```ruby
# /app/controllers/link.rb
get '/links' do
  # etc
end

post '/links' do
  # etc
end
```

And our app.rb just looks like the following:

```ruby
# /app/app.rb
require 'sinatra'
require './app/controllers/link'
require './app/controllers/user'
require './app/controllers/session'
```

Nice! =D

## Refactoring to the Modular Style

So far, we've assumed that our app is using the classical style. Check 
