# Namespacing

Can we use modules on their own, without including them in classes? Yes, and it's fairly convenient way to group methods together to prevent name conflicts. For example, Ruby itself has a [Math](http://www.ruby-doc.org/core-2.0.0/Math.html) module that contains common trigonometric methods as well as constants PI and E. 

So, if you need to calculate a sine or PI / 2, you can do

````ruby
Math.sin(Math::PI/2) #=> 1.0
````

If Math were written in Ruby (in fact, it's written in C), it'd look something like this:

````ruby
module Math
  PI = 3.1415926
  def Math.sin(x)
    # implementation of the sine function
  end
end
````

The module math is not intended to be included in other classes (although it's possible) but simply serves as a namespace for methods and constants. Note that the method definition includes the name of the module (def Math.sin(x)). This makes it possible to call the sin() method without including Math in other classes.

It's also possible to include modules and classes inside other modules and classes. For example, let's say you're writing a system that has a Client class corresponding to a real person. But then you decide to write another Client class, to represent a programme that connects to some server, for example an git client to connect to a git server.

One solution would be to give them different names:

````ruby
class Client
end

class GitClient
end
````

The problem here is that you don't always control the namespace since your codebase is likely to include lots of different gems that may have their own Client classes. Choosing a name that's globally unique is rarely a good solution. Instead, you can separate your classes into modules.

````ruby
module Shop
  class Client
  end
end

module Git
  class Client
  end  
end

customer = Shop::Client.new
git_client = Git::Client.new
````

This approach significantly reduces the likelihood of class and constant clashes. Note the double-colon notation that is used to access a class/module inside another class/module. 