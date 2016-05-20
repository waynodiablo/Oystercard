# Section 3: Routes

We currently have a failing test, which informs us that 'No route matches [GET] "/restaurants"'

Rails separates the routing concerns from the controller action concerns by placing them in different files.

> Why is it a good idea to separate concerns in this way?

In Rails, our routing concerns live in the `config/routes.rb` file, and our controller action (methods) live in `app/controllers/<controller name>_controller.rb`. So we need to update both concerns. We will cover controller actions in a later segment, but for now, we should make a change in 'config/routes.rb'

```ruby
get 'restaurants' => 'restaurants#index'
```

which links up the '/restaurants' URL to the index action on the restaurants controller (if you are unsure where to put this line, look at the auto-generated comments in `config/routes.rb` for clues.) As we have more actions we could continue to add individual routes such as `get 'restaurants/new' => 'restaurants#new'`, but rails gives us a shortcut for creating all the commonly used routes associated with a resource, e.g.

```ruby
resources :restaurants
```

### Wait, Resources?

> What is a RESTful resource? Why are `restaurants` a RESTful resource? What routes will be generated to interact with it?

If the mention of `resources` is confusing, fear not! That just means it's time to dive into the world of REST and start with these links:

[Leo's Pill on REST](https://github.com/makersacademy/course/blob/master/pills/rest.md)

[RESTful Resources - Basics](http://restfulrouting.com/#basics)


### Rails Routing

If you now run `bin/rake routes` you'll get a list of the different routes created by `resources :restaurants`. **This is one of the more powerful features of Rails:** it has conventions about routing that do a lot of work for you.  Here's the output from the `bin/rake routes` command:

```sh

          Prefix  Verb    URI Pattern                     Controller#Action
     restaurants  GET     /restaurants(.:format)          restaurants#index
                  POST    /restaurants(.:format)          restaurants#create
 new_restaurants  GET     /restaurants/new(.:format)      restaurants#new
edit_restaurants  GET     /restaurants/:id/edit(.:format) restaurants#edit
      restaurant  GET     /restaurants/:id(.:format)      restaurants#show
                  PATCH   /restaurants/:id(.:format)      restaurants#update
                  PUT     /restaurants/:id(.:format)      restaurants#update
                  DELETE  /restaurants/:id(.:format)      restaurants#destroy

```

On the left we see special prefixes that we can use to refer to these routes in  our rails code.  More on those soon.  The Verb is the HTTP verb used to access this route given the specific URI pattern, which includes optional formatting and in some cases id variables.  Each route is mapped to a specific action method on a controller; for example a 'GET' request to '/restaurants/3/edit' would lead us to call the edit action on the restaurants controller with an id variable set to the value 3.

Notice also the way `resources :restaurants` has automatically created paths for `create`, `read`, `update` and `destroy` methods. You can see how fast it can be to get a simple [CRUD](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) app off the ground!


Running `rspec` again, we get another `RoutingError` – this time, there's no Restaurants controller.

### [Next Section - Routing](4_controllers.md)
