# Meta-programming

You'll hear the phrase Meta-programming thrown around a lot. Entire books are dedicated to the subject. 
In this short tutorial we'll touch on the basics and by the end create a small application.

length: approximately 2-4 hours

So what is Meta Programming? The defenition of Meta is 'referring to itself or to the conventions of its genre' 
We can infer from this that Meta-Programming is Self-Programming. That's exactly what it is. A program which can create itself, more importantly it can create it's own methods. 

We'll start with that...

## How do you write code to create a method in ruby?

Within each Class in Ruby there is a Private method called 'define_method'. Calling Private methods is tricky but not impossible. We simply have to call it from within the class using the 'send' method. Well first need to get the name of the class we want to call it from. 

````ruby
self.class
````

Will give us the name of the class we're currently in. So now we want to call a method on this class..

````ruby
self.class.send(:define_method)
````

This will call the Private method Define_method. However this method takes an argument. The argument it takes is the name of the method you want to define. You can do this in either "string" or :symbol form. You don't pass this argument in parenthisis like you would normally do but simply seperated by a comma. 

````ruby
self.class.send(:define_method, :new_method_name)
````

So this is great. We have our new method defined. This is equivelent of writing 
````ruby
def new_method_name
end
````
from within our class. As we know though the thing which makes methods a method is the bit inside. We can simply pass this part in using a block of code afterwards. So here's an example of a us defining a method which returns TRUE. 

````ruby
self.class.send(:define_method, :does_it_return_true?){true}
````

Ok so we've got our class defining it's own methods with whatever name we git it and we've told it what to return. This is great but we can use something else to give this power a little more kick. 

## Method missing

So what happens when we call a method which hasn't been defined? 
