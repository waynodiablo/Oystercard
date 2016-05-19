# Section 4: Controllers

Running `rspec` again, we get another `RoutingError` – this time, there's no Restaurants controller.

```sh
uninitialized constant RestaurantsController
```

Time to make a controller!

##### Creating controllers

Controllers are a bit like methods in a Sinatra server file – they contain the 'verbs' that handle incoming requests and do something in response to them.

`$ bin/rails g controller restaurants`

Note, `g` is short for generate.  This command will generate a file restaurants_controller.rb in app/controllers as well as some other files (helpers and JS/CSS).

Now, RSpec gives us a different error – that there's no action /index for restaurants.

```sh
The action 'index' could not be found for RestaurantsController
```

Which indicates that we need to add an index method in our controller. If we were using Sinatra we might be tempted to use something like the following:

```ruby
get '/restaurants' do

end
```

However rails is a little simpler, and we can just define a method like so:

```ruby
class RestaurantsController < ApplicationController
  def index
    raise 'Hello from the index action'
  end  
end
```

Let's now take a little detour to see what this generates if we view the live site in a browser.  To run our rails server use the following command:

```sh
bin/rails server
```

which creates a web server running on port 3000 that we can browse to at http://localhost:3000, which will have a friendly welcome page for us. [Note that to shut the server down we type Ctrl-C]

Go to http://localhost:3000/restaurants and we'll see an error response in the RestaurantsController index action.  Notice the error page is showing us exactly the line in the controller where the error we raised occurred.  To move on we'll need a view and a model to give a response back to the user. Let's start with a view, which we'll explore in the next section.

### [Next Section - Views](5_views.md)
