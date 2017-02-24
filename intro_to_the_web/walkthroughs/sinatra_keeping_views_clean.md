# Walkthrough – Sinatra: Keeping views clean

[Back to the Challenge](../sinatra_keepig_views_clean.md)

Let's refactor our code to push the 'heavy logical lifting' of random name generation out of the view, and in to the controller. Views shouldn't concern themselves with this sort of complexity.

Before we refactor, our view looks something like this:

```erb
<h1>My name is <%= ["Amigo", "Oscar", "Viking"].sample %></h1>
<div style='border: 3px dashed red'>
  <img src='http://bit.ly/1eze8aE'>
</div>
```

Our route for this looks something like this:

```ruby
# in app.rb

get '/cat' do
  erb :index
end
```

First, let's move the complex randomisation into the route. We'll assign it to an instance variable so we can access the return value from within the view.

```ruby
# in app.rb

get '/cat' do
  @name = ["Amigo", "Oscar", "Viking"].sample
  erb :index
end
```

Now, we can just access the instance variable within the view:

```erb
<h1>My name is <%= @name %></h1>
<div style='border: 3px dashed red'>
  <img src='http://bit.ly/1eze8aE'>
</div>
```

That's much easier to read! Also, we've pushed the 'heavy lifting' of name randomisation a bit 'further down the stack'.

> Although you are used to instance variables being accessible throughout an instance of a class, the `@name` instance variable is _only accessible within the scope of the route in which is was defined_. In other words, you cannot visit `/cat` to set `@name`, and then visit another route that uses that same `@name`. **The instance variable cannot be accessed by any other routes.**

Let's dive a bit more into the `erb` method. Technically, the **erb()** method reads the input file, processes Ruby that is inside and returns resulting HTML. This HTML is then returned by the block passed to the **get()** method:

![Rendering erb in Sinatra](../images/sinatra_rendering_erb_diagram.jpg)

Before proceeding, you'll want to commit the code, push it to Github and switch Driver/Navigator Roles &nbsp;:twisted_rightwards_arrows:.

Next up, let's use _parameters_ to add some more sophistication to our kitten website.

[Forward to the Challenge Map](../README.md)
