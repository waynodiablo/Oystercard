# How to Refactor with Sinatra

## The Problem.
Unlike Rails, Sinatra allows us a great deal of flexibility in how we organize our code. One benefit of this is that it allows a natural development process: our app can start small and easily understandable. As it grows, its parts can gradually be broken out.

Things get messy, however, when we don't take that that step of breaking up and refactoring.

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

We would be better off splitting out our routes into separate ["controllers"](http://blog.codinghorror.com/understanding-model-view-controller/) files to get the following directory structure:

```bash
├── app.rb
├── models
│   └── # etc
├── controllers
│   ├── link.rb
│   ├── session.rb
│   └── user.rb
└── views
    └── # etc

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

So far, we've been assuming that our app is using the *classical style*, and not the *modular* style. In the classical style, all our routes are compiled within a class given to us by Sinatra, called `Sinatra::Application`. Hence, our `config.ru` looks like this:
```ruby
require './app/app'

run Sinatra::Application
```
It's questionable whether we need to go any further. The Sinatra docs themselves say that ['contrary to popular belief, there is nothing wrong with the classic style'](http://www.sinatrarb.com/intro.html#Modular%20vs.%20Classic%20Style). That said there are a few reasons why we might prefer the modular style (note: *these are in descending order from 'generally agreed upon' to 'my personal opinion' - Ptolemy*)
* It's possible to run multiple Sinatra apps if using the modular style.
* It's very easy to pollute the global namespace with the classical style.
* The modular style just feels more Ruby-esque.
* The modular style gives us some insight into how Rails might work.

Firstly, we need to `require sinatra/base` instead of just `sinatra`. Rather than making Sinatra's DSL available at the top level (aka "main"), it exposes a class `Sinatra::Base`, which our app can inherit from like so:

```ruby
# /app/app.rb
require 'sinatra/base'
require './app/controllers/link'
require './app/controllers/user'
require './app/controllers/session'

class MyApp < Sinatra::Base


end
```

Secondly, let's [namespace](https://rubymonk.com/learning/books/1-ruby-primer/chapters/35-modules/lessons/80-modules-as-namespaces) our app within a module:

```ruby
module Armadillo # totally arbitrary Armadillo
  class MyApp < Sinatra::Base

  end
end
```

Within the `Armadillo` namespace, we'll define at least 2 further modules:
- `Routes`, containing subclasses associated with the three resources, users, links, and sessions.
- `Models`, containing subclasses associated with the same three resources.

To get started on `Routes`, create a file `./app/controllers/base.rb`, containing the following:
```ruby
module Armadillo
  module Routes
    class Base < Sinatra::Base
      # within here we can have configuration common to all our route subclasses.
    end
  end
end
```

Then, for example, `./app/controllers/link.rb` should look like this:
```ruby
module Armadillo
  module Routes
    class Link < Base # thus making available both Sinatra's DSL
      # and the configuration common to all route sub-classes.

      get '/links' do
        # etc
      end

      post '/links' do
        # etc
      end

    end
  end
end
```

Do the same with your other controller files. Ensure that you require `/app/controllers/base` in `app.rb`. Note that you need to require it *above* the require statements for the individual controllers. I'll let you figure out why.

One last thing: we need to have all our routes compiled within `Armadillo::MyApp` to make them available to incoming requests. We instruct Sinatra to do that with the #use method (what this is actually doing is beyond the scope of this tutorial):

```ruby
# ./app/app.rb
module Armadillo # totally arbitrary Armadillo
  class MyApp < Sinatra::Base

    use Routes::Link
    use Routes::User
    use Routes::Session

  end
end
```

Rewrite your config.ru to `run Armadillo::MyApp`, and you're done!

Note that we haven't touched our models or helpers. Go through the same process, nesting them within `Armadillo::Models`. Good luck!

(*by Ptolemy. Questions / comments to ptolemy@makersacademy.com, or raise an issue)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/sinatra_modular_refactor.md)
