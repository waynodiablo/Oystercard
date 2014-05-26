# Boris Bikes

The goal of this project is to introduce you to [Object-Oriented Programming (OOP) ](https://en.wikipedia.org/wiki/Object-oriented_programming)and show you the very basics of [Object-Oriented Design (OOD)](https://en.wikipedia.org/wiki/Object-oriented_design).

We are creating a simple system for managing [Boris Bikes in London](https://en.wikipedia.org/wiki/Barclays_Cycle_Hire). Our system will keep track of a number of docking stations and the bikes. It will allow you to rent the bikes and return them. Occasionally the bikes will break and then they will be unavailable for rental. There will also be a garage to fix the bikes and a van to move the bikes between the stations and the garage.

A system like this (in a much more complex form) is actually used by the real Boris bikes system in London. Every time you rent a bike or return it some objects get created somewhere in the system that tracks the usage of all bikes.

## Version 0: Building a domain model

The first step of the process (even before we think about a single line of code) is to create the [domain model](https://en.wikipedia.org/wiki/Domain_model). The [domain model](https://en.wikipedia.org/wiki/Domain_model) describes key concepts in the domain and the relationships between them. In other words, it helps us understand what classes we may have and what methods they may implement.

Remember that a class is a collection of data and related methods that operate on this data. In order to build a [domain model](https://en.wikipedia.org/wiki/Domain_model) we need to understand what data we'll have in the system and what operations will be performed on that data.

The first step in creating the domain model is to describe the problem in plain English.

> We are building a system that manages bikes that can be rented by users from docking stations and returned there at the end of the rental. The bikes can break while being used, in which case they will not be available for rental after they are returned. There is a garage that can fix broken bikes. A van is used to move broken bikes from the stations to the garage. It can also be used to take fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot take more bikes that they can hold.

The easy way to start thinking about what classes you may have is to take a look at all nouns in the text. They are prime candidates for classes.

> We are building a system that manages **bikes** that can be rented by **users** from **docking stations** and returned there at the end of the **rental**. The **bikes** can break while being used, in which case they will not be available for **rental** after they are returned. There is a **garage** that can fix broken **bikes**. A **van** is used to move broken **bikes** from the **stations** to the **garage**. It can also be used to take fixed **bikes** back to the **station(s)**. The **van**, all **stations** and the **garage** have fixed capacity, so they cannot take more **bikes** that they can hold.

Not every noun will become a class and not every class we'll create will correspond to a noun in a plain English description. However, it's a good starting point. All data we'll have in the system will somehow be related to some class. For example, a number of bikes in a certain station is related to the station itself, not to a van or garage.

Our classes will implement a number of methods. To get an idea of what they may be, we can take a look at the verbs in our description.

> We are building a system that manages bikes that can be **rented** by users from docking stations and **returned** there at the end of the rental. The bikes can **break** while being **used**, in which case they will not be available for rental after they are **returned**. There is a garage that can **fix** broken bikes. A van is used to **move** broken bikes from the stations to the garage. It can also be used to **take** fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot **take** more bikes that they can **hold**.

Again, not all verbs will become methods and we'll have methods that don't correspond to any verbs in this description but that's ok. Right now we just need a idea of what they could be.

**TODO: add crc cards primer**

## Version 1: Setting up the project & building the bike

It's time to write some code. The first step should be describing what you will build using specs. Create a new repository in your projects directory (mine is called ~/makers) and add a `README.md` file to the repository.

````
mkdir boris_bikes
cd boris_bikes
git init
…
````

By now you must have [rspec](http://rspec.info) installed. If you don't, install it now (:pill: [rspec](https://github.com/makersacademy/course/blob/master/pills/rspec.md)).

We cannot possibly implement all functionality at once. We need to start somewhere and then increase the number of features until we are happy. What is the absolute minimum we could implement? What is central to the entire system? A bike.

How do we model a bike? We need to distill everything that could be said about the bike to the most essential information about it that is relevant to the system we are building.

A bike has a great many properties. It has a number of gears, it has a certain weight, etc. but all that is not relevant for the task of renting them from our system. Therefore, we shouldn't be concerned with those properties. The only thing about the bike that concerns us right now is whether it's broken or not. Our bikes can be broken but we don't care about anything else at the moment. This is not the only possible starting point but it's a good start.

Let's write a specification for the bike that describes how we believe the bike should behave. We're intentionally keeping everything very simple right now. It's not because this is a tutorial for beginners but because it's a good thing to do. As you design the system, you should move in small steps regardless of your experience.

Create a file `spec/bike_spec.rb`. We'll put our bike examples there. The name should end in "_spec" since this is the convention [rspec](http://rspec.info) uses. The first part of the filename is the name of the class. So we have just implied that the class we'll be testing will be called Bike.

Now let's write our first test in spec/bike_spec.rb.

````ruby
#we're describing the functionality of a specific class, Bike
describe Bike do
  # this is a specific feature (behaviour) 
  # that we expect to be present
  it "should not be broken after we create it" do
    the_bike = Bike.new # initialise a new object of Bike class
    # expect an instance of this class to have 
    # a method "broken?" that should return false
    expect(the_bike).not_to be_broken
  end
end
````

So, we begin by writing an example (`it`) that describes what we want to see happening. We tell [rspec](http://rspec.info) that we are describing the class Bike (`describe`) and we want our bike to have a single feature: _we are expecting it not to be broken when we create it_.

`expect(the_bike).not_to be_broken` seems to be quite complex, let's break it down and analyse it.

The `expect()` method is provided by [rspec](http://rspec.info). It takes the object under test as an argument and returns a special object that has different methods that make the example pass or fail, depending on their arguments. One of these methods is `not_to()` that takes yet another [rspec](http://rspec.info) method `be_broken()` as an argument. Then the `not_to()` method takes a look at its argument and realises that if we don't expect the bike to `be_broken`, we must have a method `broken?()` in the `Bike` class. So it calls this method on the bike object that we passed to the `expect()` method and if it returns true, fails the example because we expect it `not_to` be true (:pill: [RSpec - Predicate matchers](https://github.com/makersacademy/course/blob/master/pills/rspec_predicate.md)).

The paragraph above is still complicated. Read through it several times but if it still seems unclear, don't worry, it's a bit advanced for now. We still want to explain it so that you know that this line of code is some crazy magic. Once you get more experience with [rspec](http://rspec.info), you'll get used to how it works.

Why does it have to be so complicated? Because [rspec](http://rspec.info) is designed to write tests that read like English:

````ruby
# Expect the bike not to be broken
expect(the_bike).not_to be_broken
````

In order to achieve this readability [rspec](http://rspec.info) goes to great lengths doing all those crazy things described above. That's why it's complicated.

Another way to rewrite this line is

```ruby
# Expect the method broken? of the object 'bike' to return false
expect(the_bike.broken?).to be_false
````

This is slightly less readable, isn't it? Yet it's exactly the same thing. Yet another way to write the same expectation is to use an old [rspec](http://rspec.info) syntax:

````ruby
# The method broken? of the object 'bike' should return false
bike.broken?.should be(false)
````

The newer `expect` syntax should be used whenever possible but you'll come across older codebases using `should` syntax, so you should be familiar with it as well.

So, now that you have an idea of what this test does, let's run it. It will fail.

````
rspec spec/bike_spec.rb
/Users/ecomba/dev/boris_bikes/bike_spec.rb:1:in `<top (required)>': uninitialized constant Bike (NameError)
	from /usr/local/Cellar/rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/gems/rspec-core-2.14.7/lib/rspec/core/configuration.rb:896:in `load'
	from /usr/local/Cellar/rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/gems/rspec-core-2.14.7/lib/rspec/core/configuration.rb:896:in `block in load_spec_files'
	from /usr/local/Cellar/rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/gems/rspec-core-2.14.7/lib/rspec/core/configuration.rb:896:in `each'
	from /usr/local/Cellar/rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/gems/rspec-core-2.14.7/lib/rspec/core/configuration.rb:896:in `load_spec_files'
	from /usr/local/Cellar/rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/gems/rspec-core-2.14.7/lib/rspec/core/command_line.rb:22:in `run'
	from /usr/local/Cellar/rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/gems/rspec-core-2.14.7/lib/rspec/core/runner.rb:80:in `run'
	from /usr/local/Cellar/rbenv/versions/2.1.0/lib/ruby/gems/2.1.0/gems/rspec-core-2.14.7/lib/rspec/core/runner.rb:17:in `block in autorun'
````

What you see here is called a [stack trace](https://en.wikipedia.org/wiki/Stack_trace). We need to learn how to read it to understand where exactly the problem lies. If you can't read the [stack trace](https://en.wikipedia.org/wiki/Stack_trace), you won't be able to pinpoint and fix it.

The first line is the most important one. It explains what the problem was and where it occurred:

````
/Users/ecomba/dev/boris_bikes/bike_spec.rb:1:in `<top (required)>': uninitialized constant Bike (NameError)
````

In this case, the problem is in the file `/Users/ecomba/dev/boris_bikes/bike_spec.rb` on line 1. The `<top (required)>` means that the code causing trouble is not part of any specific method. The error that occurred is of the type [NameError](http://www.ruby-doc.org/core-2.1.2/NameError.html) and it's human-readable explanation is _"uninitialized constant Bike"_.

The _"uninitialized constant Bike"_ means that Ruby doesn't know what `Bike` is.

Now, stop for a second and think about what could be the reason for the error. The answer may be obvious because this particular problem is so simple but it's important to take this step and ask yourself the question every time you see an error. Don't assume the first thing that comes to mind. Think about what is the most likely reason Ruby doesn't know about `Bike`.

Other lines in the output show the path in the code Ruby went through before encountering the error on line 5 of `bike_spec.rb`. The second line was executed right before the line 5 was executed.

````ruby
from /Users/ecomba/.rvm/gems/ruby-2.0.0-p0/gems/rspec-core-2.14.5/lib/rspec/core/configuration.rb:896:in `load'
````

This tells us that a line 896 in the file `configuration.rb` that is inside a method "load" called our line in bike_spec that ultimately caused an error. This file is part of the [rspec-core](https://github.com/rspec/rspec-core) gem, version 2.14.5 that's installed for the version of Ruby 2.0.0-p0 managed by rvm (hence these files are all in ~/.rvm). Normally you wouldn't go there unless you suspect a gem misbehaves or you want to really understand how it works. However, if this stack trace goes through your code for a while before raising an error, this information would be far more valuable.

The next line in the stack trace shows what was executed directly before `configuration.rb:896` and so on. Ruby only shows the top few lines in the stack trace because they are the most useful.

So, getting back to our error. If you guessed that `uninitialized constant Bike` error happened because we never defined what Bike is, you're correct. It was simple in this case but it will be less trivial as we encounter more complex bugs later.

Let's define the bike. Create `lib/bike.rb` and define an empty Bike class.

````ruby
class Bike
end
````

The name of the file is `bike.rb` for a reason. If we're defining a class Bike, we should put it in `bike.rb`. It's not required, strictly speaking but it's a really good idea to put only one class in a `.rb` file and name it accordingly.

If you run the test right now, will it pass? Again, stop for a second and think before doing it. Right now you're predicting the result of a small experiment. If you have an expectation of whether it will pass or not, you will know whether everything is going according to your understanding of the program or not. So, will it pass or not and why? Then run it.

You'll find out it doesn't. Same error again. Ruby still has no idea about the Bike class. But why, when we've just defined it in `bike.rb`?

Think about it from Ruby's perspective. There are lots and lots of ruby files on your computer, defining hundreds if not thousands of different classes. Should all of them be available in every other Ruby file? Probably not. It's the programmer's responsibility to decide what should be available to Ruby code at what point. In other words, we haven't established any link between `bike_spec.rb` and `bike.rb`. That they are in the same repo or adjacent directories matters very little to Ruby. We need to explicitly link them together. 

Add a `require` statement to the spec.

````ruby
# link to the Bike class
require 'bike'

# we're describing the functionality of a specific class, Bike
describe Bike do

  # this is a specific feature (behaviour) that we expect to be present
  it "should not be broken after we create it" do
    bike = Bike.new # initialise a new object of Bike class
    # expect an instance of this class to have a method "broken?" that should return false
    expect(bike).not_to be_broken
  end

end
````

Requiring a file is almost equivalent to just copy-pasting the contents of `bike.rb` on line 2 of the test from Ruby's perspective. However, since copy-pasting is a really bad idea, we require the file instead.

**Now our example fails.**

There's a difference between an error and a failure. An error happens when Ruby cannot run the example at all. For example, before we create a Bike class and required it, we couldn't run the test in principle – there was no class under test.

However, now the example is failing, which means that we can test the Bike class but it doesn't have the behaviour our example expects. Take a look at the list of failures in the output. There is only one: _"Bike should not be broken after we create it"_. Where does the message come from? Look at the structure of the example.

````ruby
describe Bike do
  it "should not be broken after we create it" do
    # the test goes here, omitted for brevity
  end
end
````

We describe Bike and we specify what it should do. [RSpec](http://rspec.info) simply concatenates "Bike" from the describe statement and the description of the feature from the "it" block.

````ruby
So, what's the failure of the test?

Failure/Error: expect(bike).not_to be_broken
     NoMethodError:
       undefined method `broken?' for #<Bike:0x007f9ae30470b0>
     # ./spec/bike_spec.rb:14:in `block (2 levels) in <top (required)>'
````

First, it shows us the [rspec expectation](https://www.relishapp.com/rspec/rspec-expectations/docs) that failed. Specifically, it tells us that the method `broken?` is undefined. (#<Bike:0x007f9ae30470b0> refers to the instance of the Bike class that we have in the "bike" variable. The long number is the memory address).

So, the test is almost telling us what to do. We don't have the method `broken?`, so let's create one. Update the Bike class to include this method.

````ruby
class Bike
  def broken?
  end
end
````

Note that the method is empty. Why? Because [rspec](http://rspec.info) didn't complain about anything else. It failed because there was no method? Let's do the minimum required to get over that failure: create the method. Now run the test again. Will it pass or fail? Why? Think about this question every time you run a test, don't just run it blindly.

So it passed. However, you may have expected it to fail. That would have been a reasonable assumption since there's no implementation of the method. However, in Ruby a nil value is treated as false if a boolean value is needed. Given that a method returns nil if nothing else is returned, an empty method always returns nil. So, by writing an empty method, we satisfy the test's expectation that the bike must not be broken.

Our code is still extremely basic but we're getting somewhere. This is a good time to commit the changes. Since our repository is not empty anymore, push it to Github (:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)).

### Making the broken? method work properly

You may feel suspicious that our test suite pass while we don't have much code just yet. You're right, we're missing something. We're missing more example! Let's write another one to enable the bike to be broken. After all, if the bike has both states, fixed and broken, it's fair to assume we'll need a method to break a bike as well.

````ruby
it "should be able to break" do
  bike = Bike.new
  bike.break!
  expect(bike).to be_broken
end
````

So in our example we are creating a new bike, telling it to break and finally we expect it to be broken.

Before you run the example, ask yourself again. What do you expect to see? Will it pass? Will it fail? Why? _It is a good practice if you get yourself into this mode of thinking_

This is the test output:

````ruby
1) Bike should be able to break
     Failure/Error: bike.break!
     NoMethodError:
       undefined method `break!' for #<Bike:0x007fe7a23fd7c0>
     # ./spec/bike_spec.rb:16:in `block (2 levels) in <top (required)>'
````

If we run it, we find out that it fails on `bike.break!` statement because of the `break!` method has not been defined on `Bike`. Fair enough, let's add it to our `Bike` class. Again, [rspec](http://rspec.info) complained about the lack of method, so we're doing the absolute minimum to make our code work.

````ruby
class Bike
  def broken?
  end

  def break!
  end
end
````

_Will the test pass this time? If not, will the error be different? If yes, what will it be?_

Ok, the example is telling us that we expect the bike to be broken but it isn't: the `broken?` method returns `nil` while we expect it to return `true`. _What does it tell us to do?_ If we just make it return `true`, the example will pass but then our first example will fail because it only works because `broken?` is returning nil at the moment ( _and `nil` happens to equal to `false`_ ).

Time to write some real code. Now we have two examples that force us to write some logic. Apparently, our bike should maintain some internal state that should be changed when we break it.

Let's introduce an instance variable that holds this information. This must be an instance variable because this data is applicable only to a specific instance of the `Bike` class. One bike (instance of `Bike`) may be broken, whereas another one may not be. So we need an instance variable to save it.

````ruby
class Bike
  
  # the initialize method is always called when you create a new
  # class by typing Bike.new
  def initialize
    # all instance variables begin with "@"
    # this must be an instance variable because we'll need it
    # in other methods
    @broken = false
  end

  def broken?
    # instance variables are accessible in all methods
    @broken
  end

  def break!
    # and any instance method can update them
    @broken = true
  end
  
end
````

**Now all our examples pass, perfect time to commit our changes.**

### Fixing the bike

If a bike can be broken, it can be fixed too, right? Sounds like a test.

````ruby
it "should be able to get fixed" do
  bike = Bike.new
  bike.break!
  bike.fix!
  expect(bike).not_to be_broken
end
````

Why don't we assert that it's broken after we break but before we fix it? Also, why don't we assert that it's not broken before we break it? Because these cases are covered by other examples. We don't want to test the same thing again, it would be a waste of time. Other examples make sure that a new bike is not broken and, after we break it, it is broken.

If we run the test, we'll find that the method `fix!()` is undefined.

````ruby
1) Bike should be able to get fixed
     Failure/Error: bike.fix!
     NoMethodError:
       undefined method `fix!' for #<Bike:0x007fe9ed903010 @broken=true>
     # ./spec/bike_spec.rb:23:in `block (2 levels) in <top (required)>'
````

Easy enough to fix it ( _pun intended_). Add the method to the class.

````ruby
def fix!   
end
````

Again, don't write the implementation even though it may be obvious to you. Run the example again. What message do you expect to see this time?

````ruby
1) Bike should be able to get fixed
     Failure/Error: expect(bike).not_to be_broken
       expected broken? to return false, got true
     # ./spec/bike_spec.rb:24:in `block (2 levels) in <top (required)>'
````

As you can see the message changed. In fact this is one of the _little tricks_ you can use to learn your way around rspec. While you are in the TDD cycle, just make sure to change the message rspec gives you with every run of rspec.

So, the example tells us that the bike should not be broken after we fix it but it actually is. Now it's a good time to implement the `fix!()` method.

````ruby
def fix!
  @broken = false
end
````

**Do you expect the tests to pass?** Check it to make sure they do.

Now it's a good time to check in the code. Stage and commit the files that changed and push to Github. It's a good practice to commit every time you are _green_.

## Version 2: Refactoring

Let's pause for a while before continuing implementing more features. Is our code really good? Is there any chance to refactor it?

Refactoring is the process of changing the structure of the code in order to make it more readable, maintainable or extendable without adding any new functionality.

Software developers, even (and specially) experienced ones, don't write perfect code on their first attempt. First you write the code that works, then you refactor it to make it good. Let's refactor the code we have so far.

Before starting refactoring, always make sure all the examples pass. If your examples fail or if you have no examples, you have no idea whether your refactored code is doing the same thing as before. Just hoping that it does is not enough: some changes in functionality are subtle and non-obvious even to experienced developers and may produce ripple effects. So, make sure the examples pass before you begin.

Take a look at the `Bike` class. What is the most obvious thing that is wrong here? Think for yourself before reading the answer below.

````ruby
class Bike
  
  def initialize
    @broken = false
  end

  def broken?
    @broken
  end

  def break!
    @broken = true
  end

  def fix!   
    @broken = false
  end
  
end
````

One of the problems is the code repetition. Lines 4 and 16 are the same. Code repetition violates the **DRY principle**: [Don't Repeat Yourself](http://en.wikipedia.org/wiki/Don't_repeat_yourself). Repeating anything in the code or system design is a likely source of nasty bugs.

Instead of setting the instance variable in the initialiser, let's call the `fix!()` method instead.

Now run your tests to see if they pass. They should. This is how you know that the refactoring was successful: it didn't change the functionality while reducing the repetition in the code.

Now take a look at the tests. What could be improved here?

````ruby
require './lib/bike'

describe Bike do

  it "should not be broken after we create it" do
    bike = Bike.new
    expect(bike).not_to be_broken
  end

  it "should be able to break" do
    bike = Bike.new
    bike.break
    expect(bike).to be_broken
  end

  it "should be able to get fixed" do
    bike = Bike.new
    bike.break!
    bike.fix!
    expect(bike).not_to be_broken
  end

end
````

It should be obvious by now that lines 6, 11 and 17 are crying to be refactored. We're doing the same operation at the start of every test. Fortunately, rspec provides a way to define variables that are used by all tests. Try this:

````ruby
require './lib/bike'

describe Bike do

  let(:bike) { Bike.new }

  it "should not be broken after we create it" do    
    expect(bike).not_to be_broken
  end

  it "should be able to break" do    
    bike.break
    expect(bike).to be_broken
  end

  it "should be able to get fixed" do    
    bike.break!
    bike.fix!
    expect(bike).not_to be_broken
  end

end
````

Line 5 calls an rspec helper `let()` that defines a local variable "bike" using the block provided (`{ Bike.new }`) before every test. This makes our tests more DRY. Run them to see if they still work. They should.

Even though there are other repeated lines (8 and 19), it doesn't make sense to extract them into their own methods for readability's sake. However, in some cases it may be better to extract them: always use your best judgement. The code should look and feel elegant to you.

Now that we've finished with refactoring, it's a good time to push to Github.

## Version 3: The Docking Station

If the bike is the only thing we've got, our system isn't going to be very functional. At the very least we'll need docking stations. Let's think about the functionality we need for the docking station.

A docking station must be able to accept a bike and to release it. It should also have some capacity limit, because we shouldn't be able to put an infinite number of bikes into it. If a bike is broken, the docking station should not release it (or, rather, it should only release it to the van but we haven't got a van yet). Finally, a station must know how many bikes it has.

Let's start with the most basic functionality: accepting the bikes. As usual, we need to start with the test describing what's going on. Put your test in `spec/docking_station_spec.rb`.

````ruby
describe DockingStation do
  
  it "should accept a bike" do
    bike = Bike.new
    station = DockingStation.new
    # we expect the station to have 0 bikes
    expect(station.bike_count).to eq(0)
    # let's dock a bike into the station
    station.dock(bike)    
    # now we expect the station to have 1 bike
    expect(station.bike_count).to eq(1)
  end

end
````

Why did we choose to name the method that puts a bike into the station `dock()`. Naming things is one of [two hardest problems in Computer Science](http://martinfowler.com/bliki/TwoHardThings.html). We could have chosen a different name but this one seems good enough.

Now let's run it. We'll get an error straight away.

````ruby
docking_station_spec.rb:1:in `<top (required)>': uninitialized constant DockingStation (NameError)
````

Unless the reason for this error is immediately obvious, stop and think for a second about why it happened. Why would uninitialised constant (whatever this means) be a problem? Why would Ruby expect DockingStation to be initialised? Which line in the file raises the error? Why would line one be a problem?

It looks like we are referencing the class DockingStation on line one but since we never defined it, Ruby has no idea what DockingStation is. This is obviously a problem because in our test we're instantiating the class and calling its methods. So Ruby definitely needs it. However, it doesn't exist yet. Let's create it.

Create an empty class in lib/docking_station.rb

````ruby
class DockingStation
end
````

If you run the test now, you'll get the same an error again. Again, unless it's immediately obvious, think about what's going on. We created the class but Ruby can't link the test to the class definition because we never "required" the file. Remember, we had exactly the same problem with the Bike class? Fix the problem by requiring the class file just like we've done it in the Bike test (I'm omitting the exact line of code as a tiny exercise for you).

If you've done it correctly, you should now see a test failure

````
1) DockingStation should accept a bike
     Failure/Error: expect(station.bike_count).to eq(0)
     NoMethodError:
       undefined method `bike_count' for #<DockingStation:0x007fcab45c3678>
     # ./spec/docking_station_spec.rb:9:in `block (2 levels) in <top (required)>'
````

Why do we get "undefined method 'bike_count'"? Because we haven't written it. Create an empty bike_count() method in the DockingStation class. Don't put any implementation because the test isn't asking us to do it yet. Let the test drive your code.

If your method is empty, the next error you should see is

````
1) DockingStation should accept a bike
     Failure/Error: expect(station.bike_count).to eq(0)
       
       expected: 0
            got: nil
       
       (compared using ==)
     # ./spec/docking_station_spec.rb:9:in `block (2 levels) in <top (required)>'
````

Can you explain why this is happening? An empty method always return nil, whereas we expect the bike_count to be 0 in our tests. Let's update the method to return 0.

This may sound unnecessary. Why would you make the method return 0 if it's an obviously incorrect implementation that will be changed before the next commit? The reason we do this is that this approach forces us to write the absolute minimum necessary to make the test pass. It also ensures that we don't write the code that's not covered by the tests. Let the tests drive your code.

In fact, please forgive me for digressing, I have yet to meet a developer who would use TDD really well, writing good tests and letting them to drive the code, who would be a bad coder. Quite the opposite, I've seen many programmers who ignored tests because they were "slowing them down" only to produce a piece of unmaintainable code that would be a pain to work with. 

You can argue that it's possible to take the tests too far, testing absolutely every possible scenario and not writing a single line without a test telling you to do it. Use your best judgement. If it were possible to tell exactly when and how to write tests, we'd have computers writing them for us. TDD isn't a silver bullet but it's a very powerful weapon in your arsenal. Let the tests drive your code. Trust the tests.

So, our DockingStation isn't terribly useful right now.

````ruby
class DockingStation

  def bike_count
    0
  end

end
````

However, it gets us to the next error.

````
  1) DockingStation should accept a bike
     Failure/Error: station.dock(bike)
     NoMethodError:
       undefined method `dock' for #<DockingStation:0x007fd369c95bc8>
     # ./spec/docking_station_spec.rb:11:in `block (2 levels) in <top (required)>'
````

By now you know that you need to create the method `dock()` and rerun the test. Don't forget that the method `dock()` takes an argument, a bike. After you do it, you'll get to the error that finally forces you to write some real code:

````
  1) DockingStation should accept a bike
     Failure/Error: expect(station.bike_count).to eq(1)
       
       expected: 1
            got: 0
       
       (compared using ==)
     # ./spec/docking_station_spec.rb:13:in `block (2 levels) in <top (required)>'
````

Now we can't just make the method return 1 to get rid of this error because that would make the test break on a line above. So we need to write some real code.

Our docking station needs to know how many bikes it's got. In principle, we could get away with creating a counter that just increments every time a bike is docked without actually storing a reference to the bike. The test would still pass. However, there's a difference between making a test return a constant instead of a real implementation and writing an obviously incorrect implementation that we'll need to change later. In this particular case, I choose to actually store the bike inside a station instead of just pretending to do it.

We need to retain a reference to the bike inside the station. The best place for this would be an instance variable. Let's create an array of bikes and return its size and the number of bikes in the station.

````ruby
class DockingStation

  def initialize
    @bikes = []
  end

  def bike_count
    @bikes.count
  end

  def dock(bike)    
  end

end
````

Let's now rerun the test to makes sure the error is still the same. Since the array is empty, the `bike_count()` method should return 0. The reason we're running the test now to see the same error is to make sure that we didn't introduce any other problems along the way.

However, to make this error go away, we need to write a real implementation of the `dock()` method.

````ruby
def dock(bike)    
  @bikes << bike
end
````

The << is called a shovel operator. [It puts an element in the array](http://ruby-doc.org/core-2.0.0/Array.html#method-i-3C-3C). Now our bike_count method will return the correct value after we dock a bike. All tests should pass.

Now that our tests pass it's a good time to check the code in.

If our docking station can accept bikes, it will need to release them at some point. Let's write a test to release a bike.

````ruby
it "should release a bike" do
  station.dock(bike)
  station.release(bike)
  expect(station.bike_count).to eq(0)
end
````

To get rid of code repetition, I also put a couple `let()` statements at the very beginning of the "describe" block, just like we've done earlier in the Bike spec.

````ruby
let(:bike) { Bike.new }
let(:station) { DockingStation.new }
````

Run rspec, create an empty `release()` method, run rspec again. Now the reason for the failure is that the method doesn't work. Let's implement it.

````ruby
def release(bike)
  @bikes.delete(bike)
end
````

Now all tests should pass. Great news: we can now dock bikes and release them! Let's check in the code

Let's now make our docking stations more realistic. Right now you can dock any number of bikes in there and it'll be ok as long as you have available memory on your machine (that'll be many, many millions of bikes). Let's introduce some limit on the capacity, set when the station is being initialised. As always, first comes the example.

````ruby
it "should know when it's full" do
  expect(station).not_to be_full
  20.times { station.dock(Bike.new) }
  expect(station).to be_full
end
````

Why 20? Let's pass the capacity as a a parameter to the initialiser.

````ruby
let(:station) { DockingStation.new(:capacity => 20) }
````

So we're initialising the station as the station that has the capacity of 20 and we're filling it with 20 bikes. We expect it to be full after that. Run the test (it will complain about the wrong number of arguments for the initialiser). Let's fix the problem the test has uncovered.

````ruby
def initialize(options = {})    
  @capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
  @bikes = []
end
````

Let's stop and discuss this code. The first question is why pass the capacity as a key-value pair of an options hash. We could have passed it as the first argument:

````ruby
def initialize(capacity=DEFAULT_CAPACITY)
````

However, then we'd have to use it like this:

````ruby
DockingStation.new(20)
````

The problem with this code is that it doesn't communicate what 20 is. Is it the capacity? Do we want to create 20 docking stations in one go? Is it the number of bikes a station should be initialised with? Our code must communicate the intent well.

The second question is what this line does:

````ruby
@capacity = options.fetch(:capacity, DEFAULT_CAPACITY)
````

This is a common pattern for passing optional arguments into Ruby. The [Hash.fetch method](http://www.ruby-doc.org/core-1.9.3/Hash.html#method-i-fetch) retrieves the value for the given key (`options[:capacity]` in this case) and if the key is not found, it returns the second argument (`DEFAULT_CAPACITY`). So if the capacity is passed, it's used, otherwise the default one will be assigned.

Finally, you'll need to define the default capacity at the top of the `DockingStation` class.

````ruby
class DockingStation
  DEFAULT_CAPACITY = 10 
````

There's a different way of achieving the same effect: [named arguments in Ruby 2.0](http://brainspec.com/blog/2012/10/08/keyword-arguments-ruby-2-0/). However, since this is a relatively new feature, you're likely to see the pattern we're using in the real world.

Let's run rspec again...

Undefined method `full?()`. That's because we don't have it. Create it but leave it empty. Next error:

````ruby
 1) DockingStation should know when it's full
     Failure/Error: expect(station).to be_full
       expected full? to return true, got nil
````

Now let's implement it. What does it mean for a station to be full? To have the number of bikes to be equal to the capacity.

````ruby
def full?
  bike_count == @capacity
end
````

Why are we using `bike_count` as opposed to `@bikes.count`? Doing so would lead to repetition. If we have a method for giving us the bike count, we must use it.

Do you think the tests would pass now? Make a prediction, then run them. If they do, it's a good time to commit the code.

However, what happens if we try to dock the bike into a station that's full?

````ruby
it "should not accept a bike if it's full" do
  20.times { station.dock(Bike.new) }
  expect(lambda { station.dock(bike) }).to raise_error(RuntimeError)
end
````

From now on I'll start skipping the test failures because you've seen quite of few of them now.

This test expects that docking a bike into a station should not raise an error. It will fail because this functionality isn't implemented yet. Let's update the `dock()` method.

````ruby
def dock(bike) 
  # if the capacity is reached, raise an exception   
  raise "Station is full" if full?
  @bikes << bike
end
````

Now our tests should pass but we have a long line of code in our tests that is repeated twice.

````ruby
20.times { station.dock(Bike.new) }
````

Let's refactor the code by extracting the method to a helper method (put it inside the `describe DockingStation` block).

````ruby
def fill_station(station)
  20.times { station.dock(Bike.new) }
end
````

Now our test look better.

````ruby
it "should not accept a bike if it's full" do
  fill_station station
  expect(lambda { station.dock(bike) }).to raise_error(RuntimeError)
end
````

If everything passes, it's a good time to check everything in.

When you need to get a bike from a station, you need to know what bikes are available. Some bikes can be broken and they shouldn't be available for rental. Let's create a method that will return the list of bikes that are available.

````ruby
it "should provide the list of available bikes" do
  working_bike, broken_bike = Bike.new, Bike.new    
  broken_bike.break
  station.dock(working_bike)
  station.dock(broken_bike)
  expect(station.available_bikes).to eq([working_bike])
end
````

The implementation is fairly simple.

````ruby
def available_bikes
  @bikes.reject {|bike| bike.broken? }
end
````

Now that the tests pass, it's time to check the code in.

Our station is mostly done but there are a few more things, listed in the Exercises section below for you to finish.

## Version 4: Van & Garage

Before writing more code, let's discuss what the other classes are and why we need them, starting with the van.

The van is moving broken bikes from the stations to the garage. Once they are fixed, the van moves them back to the stations. So the van must be able to accept the bikes at the source and release them at the destination. Obviously, the van must have some limit on the capacity, just like the station.

However, the van isn't going to be very different from the station. It may have some additional methods to interact with the station and the garage but overall it's fairly similar to the station.

The situation with the garage is very similar. What's the difference between a garage and a docking station? Only a van is supposed to take bikes out of a garage. Also, the bikes get fixed once they get to the garage. Otherwise, the garage is not much different from the station.

## Version 5: Extracting the common functionality

By now it should be obvious that if we just implement the Garage and the Van classes in the same way we've done the DockingStation class, we'll be duplicating significant amounts of code. In this situation you need to extract common functionality into a new class or module that will be reused later.

This week we'll be discussing two strategies for extracting common functionality: inheritance and composition. In this particular case we should use composition over inheritance.

Inheritance is mostly useful when there is a clear **is-a** relationship. For example, an ElectricCar **is a** Car. A Cat **is a** Mammal. A Report **is a** Document.

Composition is usually more suitable when there is a **has-a** relationship. A Car **has a** Gearbox. A Cat **has a** Tail. A Report **has a** Attachment.

In our case three objects – docking station, van and garage – have common functionality. However, they are not the same thing conceptually. Even though the Garage is almost like a DockingStation with minor changes to functionality, we can't say that a garage is a docking station. A van is not a docking station either. We could invent an artificial ObjectThatCanDockBikes but that would be a really poor solution. We must show some compassion for the developers that will be maintaining this code base in the future, trying to make sense of what we've written.

Instead, we need to use composition. A garage has a special area where to store the bikes. So do the docking station and the van. All of them have other things: a van has an engine, a docking station has a payment terminal and a garage has a set of tools but all that doesn't concern us right now. The common thing is that they all have a place to store the bikes. Let's call it a BikeContainer. So a Van has a BikeContainer, a DockingStation has a BikeContainer and a Garage has a Bike Container. Since it's a clear has-a relationship, we must be using composition, and not inheritance in this case.

Let's begin by extracting the common functionality from the DockingStation to BikeContainer. Since we are not adding any new functionality, this process is refactoring. Therefore, we are not writing any new tests but using existing tests to make sure that we are not breaking anything in the process.

Run the tests to make sure they pass. Then create `lib/bike_container.rb` file for our new module. Let's extract all methods from the docking station into the bike container. We'll discuss this code more in details a minute later.

````ruby
module BikeContainer

  DEFAULT_CAPACITY = 10

  def bikes
    @bikes ||= []
  end

  def capacity    
    @capacity ||= DEFAULT_CAPACITY
  end

  def capacity=(value)    
    @capacity = value
  end

  def bike_count
    bikes.count
  end

  def dock(bike)
    raise "Station is full" if full?
    bikes << bike
  end

  def release(bike)
    bikes.delete(bike)
  end

  def full?
    bike_count == capacity
  end

  def available_bikes
    bikes.reject {|bike| bike.broken? }
  end
end
````

The first thing to note is that this is a module, not a class. A module is just like a class, except it cannot be instantiated, that is, you cannot do `BikeContainer.new`. The second interesting thing is that we have created "accessor" methods for `@capacity` and `@bikes` instance variables.

````ruby
def bikes
  @bikes ||= []
end

def capacity    
  @capacity ||= DEFAULT_CAPACITY
end

def capacity=(value)    
  @capacity = value
end
````

This enables us to avoid working directly with the instance variables, [encapsulating](http://en.wikipedia.org/wiki/Encapsulation_(object-oriented_programming)) the implementation inside the module. Because of this change, all other methods now use the accessor methods instead of manipulating the instance variables directly. Consider this method:

````ruby
def full?
  bike_count == capacity
end
````

Here, `capacity` refers to the accessor method `capacity()` that we defined above.

The third interesting thing is the use of the `||=` operators to initialise values. Consider this method:

````ruby
def capacity    
  @capacity ||= DEFAULT_CAPACITY
end
````

Whenever any other method calls `capacity()`, it will return the value of the instance variable `@capacity`. However, if `@capacity` is nil, it will assign `DEFAULT_CAPACITY` to it first. This operator is short for `@capacity = @capacity || DEFAULT_CAPACITY`.

This trick enables us to call the method `capacity()` before the value was set: it will be set to the default the first time it's accepted.

The DockingStation now looks like this.

````ruby
# load BikeContainer
require_relative 'bike_container'

class DockingStation

  # this gives us all the methods that used to be in this class
  include BikeContainer

  def initialize(options = {})    
    # self.capacity is calling the capacity=() method 
    # (note the equals sign) defined in BikeContainer
    # capacity (the second argument to fetch()) is calling 
    # the capacity() method in BikeContainer
    self.capacity = options.fetch(:capacity, capacity)
  end

end
````

Now our DockingStation class is very small because we extracted all methods (except the initialiser) into BikeContainer. We retain the initialiser, though, because we want to be able to set a custom capacity for the station, if we want to.

The tests should still pass because the functionality is equivalent. However, we need to refactor the tests before we check them in. The problem is that all tests that cover the functionality of BikeContainer are in docking_station_spec.rb, which is misleading. Let's create a separate suite of tests for the bike container.

Since we can't instantiate a module, we will need to create an artificial class for test purposes. The only job of that class will be to include BikeContainer. This is what the beginning of the test looks like (most tests omitted for brevity, refactor them on your own).

````ruby
require './lib/bike_container'

class ContainerHolder; include BikeContainer; end

describe BikeContainer do
  
  let(:bike) { Bike.new }
  let(:holder) { ContainerHolder.new }
    
  it "should accept a bike" do        
    # we expect the holder to have 0 bikes
    expect(holder.bike_count).to eq(0)
    # let's dock a bike into the holder
    holder.dock(bike)    
    # now we expect the holder to have 1 bike
    expect(holder.bike_count).to eq(1)
  end
end
````

This is pretty much the same test we used to have for the station, except that we're using an artificial class instead of a docking station. The DockingStation test now has only one test that checks that the initialiser is working correctly.

````ruby
require './lib/docking_station'

describe DockingStation do
    
  let(:station) { DockingStation.new(:capacity => 123) }

  it "should allow setting default capacity on initialising" do
    expect(station.capacity).to eq(123)
  end
end
````

Check that all tests still pass. If they do, push your code to Github.

Now you can create Van and Garage classes that will reuse BikeContainer. You'll need to think how to extend the functionality of the existing methods, though. For example, the garage must fix the bikes as they arrive. However, the dock() method knows nothing about fixing the bikes:

````ruby
def dock(bike)
  raise "There is no more room for bikes" if full?
  bikes << bike
end
````

There are several way of doing this. The simplest would be to use a different method to put bikes in a garage:

````ruby
def accept(bike)
    bike.fix
    dock(bike)
end
````

The advantage is the simplicity. The disadvantage is that the interface for docking the bikes is different.

Another way would be to not to fix the bikes automatically in the first place. Then we'd call the fix_bikes() method (or similar) after we dock them.

````ruby
garage.dock(bike)
garage.fix_bikes
````

The advantage is that we have the same interface. The disadvantage is that we have to make two method calls (that's a big one).

There's a really good overview of [potential strategies you could use on StackOverflow](http://stackoverflow.com/questions/4470108/when-monkey-patching-a-method-can-you-call-the-overridden-method-from-the-new-i_). Try using `alias_method` and `prepend` (and maybe others) and discuss their advantages and disadvantages with other students and teachers.

## Exercises

1. Make the `release()` method more robust. What if we try to release a bike that's not there? What if we pass an empty argument? What if we pass an argument that is not a bike at all? Anything else that can go wrong? Write tests for it and make them pass. Do the same for `dock()` method.
2. Write the `empty?()` method for the docking station.
3. How will the van check out broken bikes if the `available_bikes()` method doesn't return broken bikes? Extend the station to be able to interact with the van.
4. If you chose to create methods that return broken bikes and working bikes separately, why do we need `bike_count()` method? Should we keep it or leave it? If we keep it, when will it be used?
5. Design the methods that the van needs to have to move broken bikes from a station to the garage and back (once they are fixed). Implement them.
6. Write the Garage class. Assume that the bikes are fixed instantly when they are put into the garage. See the discussion above on how to do it.
7. Write the Van class. How is it different from other classes? What extra methods will it have? A van would normally take several bikes in one go. How do we do it? How will it take into account the space available in the van. Write tests for all use cases.
8. The method that releases the bike takes an argument: a bike to release. Would in make sense to rewrite the method to not to take any arguments? What are the pros and cons? How will you release broken bikes in this case? Discuss with other students and update the code, if necessary.
9. Go over your code and identify if there are any scenarios that are not covered with tests and write tests for them. Think of things that could go wrong. What if the capacity is not a number? What if it's negative?
10. Finally, identify any places in your code that could be refactored and refactor them. Is there any duplication anywhere? Is any method longer than 1-2 lines? Does anything look ugly to you?