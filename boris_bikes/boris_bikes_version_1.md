## Version 1: Building the bike

We cannot possibly implement all functionality at once. We need to start somewhere and then increase the number of features until we are happy [TODO: do we need to intro MVP here?]. What is the absolute minimum we could implement? What is central to the entire system? A bike.

How do we model a bike? We need to distill everything that could be said about the bike to the most essential information about it that is relevant to the system we are building.

A bike has a great many properties. It has a number of gears, it has a certain weight, etc. but all that is not relevant for the task of renting them from our system. Therefore, we shouldn't be concerned with those properties. The only thing about the bike that concerns us right now is whether it's broken or not. Our bikes can be broken but we don't care about anything else at the moment. This is not the only possible starting point but it's a good start.

Let's write a specification for the bike that describes how we believe the bike should behave. We're intentionally keeping everything very simple right now. It's not because this is a tutorial for beginners but because it's a good thing to do. As you design the system, you should move in small steps regardless of your experience.

Create a file `spec/bike_spec.rb`. We'll put our bike examples there. The name should end in "_spec" since this is the convention :pill: [rspec](https://github.com/makersacademy/course/blob/master/pills/rspec.md) uses. The first part of the filename is the name of the class. So we have just implied that the class we'll be testing will be called Bike.

Now let's write our first test in spec/bike_spec.rb. Whatever you do, **DO NOT** copy and paste this code, you must type it out yourself (not the comments).  It is essential that you type the code out yourself or you will not learn effectively.

````ruby
#we're describing the functionality of a specific class, Bike
describe Bike do
  # this is a specific feature (behaviour)
  # that we expect to be present
  it 'should not be broken after we create it' do
    the_bike = Bike.new # initialise a new object of Bike class
    # expect an instance of this class to have
    # a method "broken?" that should return false
    expect(the_bike).not_to be_broken
  end
end
````

[TODO: should the above be introducing 'subject already'?]

Note that the comments here are simply to help you first time around.  Please don't include them in your code, and in general avoid comments, preferring to write code that is comprehensible without comments.

So, we begin by writing an example (`it`) that describes what we want to see happening. We tell [rspec](http://rspec.info) that we are describing the class Bike (`describe`) and we want our bike to have a single feature: _we are expecting it not to be broken when we create it_.

`expect(the_bike).not_to be_broken` seems to be quite complex, let's break it down and analyse it.

The `expect()` method is provided by [rspec](http://rspec.info). It takes the object under test as an argument and returns a special object that has different methods that make the example pass or fail, depending on their arguments. One of these methods is `not_to()` that takes yet another [rspec](http://rspec.info) method `be_broken()` as an argument. Then the `not_to()` method takes a look at its argument and realises that if we don't expect the bike to `be_broken`, we must have a method `broken?()` in the `Bike` class. So it calls this method on the bike object that we passed to the `expect()` method and if it returns true, fails the example because we expect it `not_to` be true (:pill: [RSpec - Predicate matchers](https://github.com/makersacademy/course/blob/master/pills/rspec_predicate.md)).

The paragraph above is still complicated. Read through it several times but if it still seems unclear, don't worry, it's a bit advanced for now. We still want to explain it so that you know that this line of code is some crazy magic. Once you get more experience with [rspec](http://rspec.info), you'll get used to how it works.

[TODO: This document is very wordy - can we pull that language into pills and have more diagrams here?]

Why does it have to be so complicated? Because [rspec](http://rspec.info) is designed to write tests that read like English:

````ruby
# Expect the bike not to be broken
expect(the_bike).not_to be_broken
````

In order to achieve this readability [rspec](http://rspec.info) goes to great lengths doing all those crazy things described above. That's why it's complicated.

Another way to rewrite this line is

```ruby
# Expect the method broken? of the object 'bike' to return false
expect(the_bike.broken?).to be_false # in RSpec version 2.x.x
# or
expect(the_bike.broken?).to be false # in RSpec version 3.x.x
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

This would be a great time to switch Driver/Navigator Roles!&nbsp;:twisted_rightwards_arrows:

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
  it 'should not be broken after we create it' do
    bike = Bike.new # initialise a new object of Bike class
    # expect an instance of this class to have a method "broken?" that should return false
    expect(bike).not_to be_broken
  end

end
````

Requiring a file is almost equivalent to just copy-pasting the contents of `bike.rb` on line 2 of the test from Ruby's perspective. However, since copy-pasting is a really bad idea, we require the file instead.  Note also that `require 'bike'` works here because the bike.rb file is in the lib directory.  The Ruby convention is that require will automatically look in a projects lib directory for Ruby files.

**Now our example fails.**

There's a difference between an error and a failure. An error happens when Ruby cannot run the example at all. For example, before we create a Bike class and required it, we couldn't run the test in principle – there was no class under test.

However, now the example is failing, which means that we can test the Bike class but it doesn't have the behaviour our example expects. Take a look at the list of failures in the output. There is only one: _"Bike should not be broken after we create it"_. Where does the message come from? Look at the structure of the example.

````ruby
describe Bike do
  it 'should not be broken after we create it' do
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

Our code is still extremely basic but we're getting somewhere. This is a good time to commit the changes. Since our repository is not empty anymore, push it to Github (:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)), and it's also a good time to switch Driver/Navigator Roles!&nbsp;:twisted_rightwards_arrows:


### Making the broken? method work properly

You may feel suspicious that our test suite passes while we don't have much code just yet. You're right, we're missing something. We're missing more examples! Let's write another one to enable the bike to be broken. After all, if the bike has both states, fixed and broken, it's fair to assume we'll need a method to break a bike as well.

````ruby
it 'should be able to break' do
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

**Now all our examples pass, a perfect time to commit our changes, and to switch Driver/Navigator Roles again&nbsp;:twisted_rightwards_arrows:.
**

### Fixing the bike

If a bike can be broken, it can be fixed too, right? Sounds like a test.

````ruby
it 'should be able to get fixed' do
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

Now it's a good time to check in the code. Stage and commit the files that changed and push to Github. It's a good practice to commit every time you are _green_.  It's also a good time to switch to switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:, depending on your pairing methodology.
