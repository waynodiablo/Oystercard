Excerpt From: Metz, Sandi. “Practical Object-Oriented Design in Ruby: An Agile Primer (Addison-Wesley Professional Ruby Series).”

Always wrap instance variables in accessor methods instead of directly referring to variables, like the ratio method does below:”

```
class Gear
    def initialize(chainring, cog)
      @chainring = chainring
      @cog       = cog
    end
    
    def ratio
      @chainring / @cog.to_f    # <-- road to ruin
    end
  end
```

Hide the variables, even from the class that defines them, by wrapping them in methods. Ruby provides attr_reader as an easy way to create the encapsulating methods:

```
  class Gear
    attr_reader :chainring, :cog  # <-------
    
    def initialize(chainring, cog)
      @chainring = chainring
      @cog       = cog
    end
  
    def ratio
      chainring / cog.to_f        # <-------
    end
  end
```

Using attr_reader caused Ruby to create simple wrapper methods for the variables. Here’s a virtual representation of the one it created for cog:

```
# default implementation via attr_reader
  def cog
    @cog
  end

# a simple reimplementation of cog
  def cog
    @cog * unanticipated_adjustment_factor
  end

# a more complex one
  def cog
    @cog * (foo? ? bar_adjustment : baz_adjustment)
  end
```
The first example could arguably have been done by making one change to the value of the instance variable. However, you can never be sure that you won’t eventually need something like the second example. The second adjustment is a simple behavior change when done in a method, but a code destroying mess when applied to a bunch of instance variable references.

Dealing with data as if it’s an object that understands messages introduces two new issues. The first issue involves visibility. Wrapping the @cog instance variable in a public cog method exposes this variable to the other objects in your application; any other object can now send cog to a Gear. It would have been just as easy to create a private wrapping method, one that turns the data into behavior without exposing that behavior to the entire application. Choosing between these two alternatives is covered in Chapter 4, Creating Flexible Interfaces.

The second issue is more abstract. Because it’s possible to wrap every instance variable in a method and to therefore treat any variable as if it’s just another object, the distinction between data and a regular object begins to disappear. While it’s sometimes expedient to think of parts of your application as behavior-less data, most things are better thought of as plain old objects.
Regardless of how far your thoughts move in this direction, you should hide data from yourself. Doing so protects the code from being affected by unexpected changes. Data very often has behavior that you don’t yet know about. Send messages to access variables, even if you think of them as data.


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/wrapping_instance_variables_in_accessor_methods.md)
