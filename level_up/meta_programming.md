# Meta-programming

You'll hear the phrase Meta-programming thrown around a lot. Entire books are dedicated to the subject. 
In this short tutorial we'll touch on the basics and by the end create a small application.

length: approximately 2-4 hours

So what is Meta Programming? The defenition of Meta is 'referring to itself or to the conventions of its genre' 
We can infer from this that Meta-Programming is Self-Programming. That's exactly what it is. A program which can create itself, more importantly it can create it's own methods. 

We'll start with that...

## How do you write code to create a method in ruby?

Within each Class in Ruby there is a Private method called 'define_method'. Calling Private methods is tricky but not impossible. We simply have to call it from within the class using the 'send' method. We'll first need to get the name of the class we want to call it from. 

```ruby
self.class
```

Will give us the name of the class we're currently in. So now we want to call a method on this class..

```ruby
self.class.send(:define_method)
```

This will call the Private method Define_method. However this method takes an argument. The argument it takes is the name of the method you want to define. You can do this in either "string" or :symbol form. You don't pass this argument in parenthisis like you would normally do but simply seperated by a comma. 

```ruby
self.class.send(:define_method, :new_method_name)
```

So this is great. We have our new method defined. This is equivelent of writing 

```ruby
def new_method_name
end
```
from within our class. As we know though the thing which makes methods a method is the bit inside. We can simply pass this part in using a block of code afterwards. So here's an example of a us defining a method which returns TRUE. 

```ruby
self.class.send(:define_method, :does_it_return_true?){true}
```

Ok so we've got our class defining it's own methods with whatever name we give it and we've told it what to return. This is great but we can use something else to give this power a little more kick. 

## Method missing

So what happens when we call a method which hasn't been defined? try it. 
You've probably seen this a few times before...

```ruby
NameError: undefined local variable or method `method_name' for main:Object
``` 

To go into what happening here is quite complicated but there's a way to intercept this error by patching over an invisible method which is in every class called method_missing. 

try this from within a class.  

```ruby
def method_missing(method_name)
 "It's all good, the method #{method_name} doesn't exist but I've got your back!"
end

```

Now create a new instance of that class and run any method you like on it. You shouldn't get an error, instead you should get that message back with the name of the method inside there.

method_missing intercepts the error message and the first argument it receives is the name of the method it was trying to call. Method_missing can take two additional arguments after the name of the called method, it's arguments and a block. 

This can look like this. 

```ruby
def method_missing(name, *args, &block)
end
```

This could give you the power to now only see the name of the method which was trying to be called but all of it's arguments and any block you we're trying to call on that method. 

The possibilities are endless. 

So here's a challenge for you. I want you to pass these tests without writing the name of the methods required. You'll need to impliment both define_method and method_missing to pass these tests. 
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

We need to inpliment and method on the student called 
'has_something?' the something  can be anything. If the class doesn't know what we're talking about then we can logically infer we don't have that something and respond with false. It's like me asking you if you have a STIS (which stands for Space Telescope Imaging Spectrograph), You may not know what the hell that is and because of this you're like to answer No. So I think if we ask our program if it has something which it doesn't know what it is then it should just answer No (or False). 

The same could be said if we have something, If we give our student something then the moment we give it to it it should then suddently know what it is and know that it has it. 

Word or warning: 
Our original method exception is still useful. So lets make sure we only create these have_something? methods when we're trying to called a method which looks like /^has_.+?\?/ 
If it doens't match this pattern then we should continue doing what we were originally doing (i.e super). 

Good luck students, and when you're done go and call has_metaroid? on yourself and return a big fat True. 


