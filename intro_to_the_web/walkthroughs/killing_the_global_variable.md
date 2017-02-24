# Walkthrough - Killing the Global Variable

Did we mention that global variables are evil?  I can't remember...

The problem we are trying to solve is that instance variables defined inside a route handler...:
```ruby
post '/names' do
  player_1 = Player.new(params[:player_1_name])
  player_2 = Player.new(params[:player_2_name])
  @game = Game.new(player_1, player_2)
  redirect '/play'
end
```
...go out of scope once the response is sent back to the client.  So, in the example above `@game` goes out of scope and therefore the new `Game` instance it points to becomes unreachable (and Ruby will subsequently destroy it).

To fix this, we need to keep the object in a scope which outlasts the request/response.  Instead of using a using a global variable as before, we can introduce *static behaviour* to the `Game` class.  This means defining methods on the class itself rather than _instances_ of the class.  Can you think of any methods you already call on the _class_ rather than an instance of the class?

>  Psst... what about `::new()`?

We are now very familiar with storing state in an instance, but it's also possible to store state within the class itself.  In Ruby, _a class is just another object_ (actually, it's an instance of class `Class`, if you're into that sort of thing).  So you can actually define methods and state on the class object as well as on its instances.  Unlike our `@game` _instance_, which goes out of scope when the response is sent, the `Game` _class_ does not go out of scope (it's being pointed to by the constant `Game` for a start).

To define a class method, you prefix the method name with `self.` like so:
```ruby
class MyClass
  def self.my_class_method(some_arg)
    # to call this method you would do this:
    # MyClass.my_class_method('an argument')
    @arg = some_arg
  end
end
```

So what is the scope of `@arg`?  It looks like an instance variable, because it's prefixed with `@`, but it's in a _class method_; what _instance_ could it possibly refer to?  You can read more on Ruby metaprogramming if you are feeling comfortable; but it's sufficient to understand that `@arg` is not accessible to any _instances_ of `MyClass`.  It's only accessible to other _class methods_ (i.e. methods defined with `self.`).  To call the method defined above, we would do this:
```ruby
MyClass.my_class_method('an argument')
```

So what if we used a class instance variable to store our game instance?  It wouldn't go out of scope when a request/response finishes and we could access it using a class method if we defined one.  For example:

```ruby
def self.the_game
  @game
end
```
And call it thus:
```ruby
@game = Game.the_game
```
> Note: `@game` in the second example is a completely different variable to the one inside the class method.  They just happen to both be called `@game`.

OK, `the_game` is a bit of a questionable name.  Maybe we should call it something better, like `instance`:

```ruby
def self.instance
  @game
end
```
```ruby
@game = Game.instance
```

However, where does `@game` get assigned?  Perhaps we could use lazy initialization:

```ruby
def self.instance
  @game ||= Game.new
end
```
But that's not going to work if we need to pass `player_1` and `player_2` to `Game.new`.  So we need another class method to create the game in the first place:

```ruby
def self.create(player_1, player_2)
  @game = Game.new(player_1, player_2)
end

def self.instance
  @game
end
```
Because `create` and `instance` are both class methods, they both have access to the same class instance variable `@game`

So now, in our route handlers, we can do this:
```ruby
post '/names' do
  player_1 = Player.new(params[:player_1_name])
  player_2 = Player.new(params[:player_2_name])
  @game = Game.create(player_1, player_2)
  redirect '/play'
end

get '/play' do
  @game = Game.instance
end

# further route handlers below...
```

Since every route handler is likely to need to assign `@game = Game.instance` (except `/names`), we can DRY this out using a Sinatra filter:
```ruby
before do
  @game = Game.instance
end
```
Now, `@game` is already defined for us in every route; and in `/names`, it is simply overridden by `@game = Game.create(player_1, player_2)`.

The End.

Now let's move on to some extension exercises:
[Forward to the Challenge Map](../README.md)
