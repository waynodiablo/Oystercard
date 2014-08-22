# Meta-programming

You'll hear the phrase Meta-programming thrown around a lot. Entire books are dedicated to the subject. 
In this short tutorial we'll touch on the basics and by the end create a small application.

length: approximately 2-4 hours

So what is Meta Programming? The definition of Meta is 'referring to itself or to the conventions of its genre.' 
We can infer from this that Meta-Programming is Self-Programming. That's exactly what it is. A program which can create itself, or more importantly it can create its own methods. 

We'll start with that...

## How do you write code to create a method in Ruby?

Within each class in Ruby there is a private method called 'define_method'. Calling private methods is tricky but not impossible. We simply have to call it from within the class using the 'send' method. We'll first need to get the name of the class we want to call it from. 

```ruby
self.class
```

will give us the name of the class we're currently in. So now we want to call a method on this class...

```ruby
self.class.send(:define_method)
```

This will call the private method define_method. However, this method takes an argument. The argument it takes is the name of the method you want to define. You can do this in either "string" or :symbol form. You don't pass this argument in parenthesis like you would normally do but simply separated by a comma. 

```ruby
self.class.send(:define_method, :new_method_name)
```

So this is great. We have our new method defined. This is equivalent to writing 

```ruby
def new_method_name
end
```
from within our class. As we know though, the defining characteristics of a method are the bits inside. We can simply pass this part in, using a block of code afterwards. So here's an example of us defining a method which returns TRUE. 

```ruby
self.class.send(:define_method, :does_it_return_true?){true}
```

Ok so we've got our class defining its own methods with whatever name we give it- and we've told it what to return. This is great but we can use something else to give this a little more kick. 

## Method Missing

So what happens when we call a method which hasn't been defined? Try it!
You've probably seen this a few times before...

```ruby
NameError: undefined local variable or method `method_name' for main:Object
``` 

To go into what's happening here is quite complicated, but there's a way to intercept this error by patching over an invisible method which is in every class- and it's called method_missing. 

Try this from within a class.  

```ruby
def method_missing(method_name)
 "It's all good, the method #{method_name} doesn't exist but I've got your back!"
end

```

Now create a new instance of that class and run a method you're sure doesn't exist. You shouldn't get an error, instead you should get the above message back with the name of the method inside it.

method_missing intercepts the error message and the first argument it receives is the name of the method it was trying to call. method_missing can take two additional arguments after the name of the called method, its arguments and a block. 

This can look like the following: 

```ruby
def method_missing(name, *args, &block)
end
```

This could give you the power to not only see the name of the method which you were trying to call but also all of its arguments and any block you're trying to call on that method. 

The possibilities are endless. 

So here's a challenge for you. I want you to pass these tests without writing the name of the methods required. You'll need to implement both define_method and method_missing to pass these tests. 
```
spec/students_spec.rb
```
```ruby
require 'student'

describe Student do
	let(:student){Student.new}
	it "does not have an award" do 
		expect(student).not_to have_unixoid
	end
	
	it "can have badges awarded" do 
		student.award :unixoid
		expect(student).to have_unixoid
	end
end
```

### Additional information

We need to implement a method on the student called 'has_something?'. The 'something' can be anything. If the class doesn't know what we're talking about then we can logically infer we don't have that something and respond with false. It's like me asking you if you have a STIS (which stands for Space Telescope Imaging Spectrograph). You may not know what the hell that is and because of this, you're likely to answer 'No'. So I think if we ask our program if it has something - and if it doesn't know that is, then it should just answer 'No' (or false). 

A real-world analogy might be if we were to hand somebody an item they had no previous experience with, and the mere act of putting it in their hands is enough for them to automatically know everything about that object.

PLEASE NOTE: 
Our original method exception is still useful. So let's make sure we only create these has_something? methods when we're trying to called a method which looks like /^has_.+?\?/ 
If it doesn't match this pattern then we should continue doing what we were originally doing (i.e refer to the superclass for instructions). 

Good luck students, and when you're done go and call has_metaroid? on yourself and return a big fat 'true'. 


