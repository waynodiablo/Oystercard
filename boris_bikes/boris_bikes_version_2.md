## Stage 2: First Unit Test

So how do we model a bike, the subject of our first unit test? We need to distill everything that could be said about the bike to the most essential information about it that is relevant to the system we are building.

A bike has a great many properties. It has a number of gears, it has a certain weight, etc. but all that is not relevant for the task of renting them from our system. Therefore, we shouldn't be concerned with those properties. Our feature test is indicating that the only thing about the bike that concerns us right now is whether it's broken or not. Our bikes can be broken but we don't care about anything else at the moment. This is not the only possible starting point but it's a good start, and since we have started with a user story and feature test it seems likely that this functionality will be relevant to the end user.

Let's write a specification for the bike that describes how we want the bike to behave. We're intentionally keeping everything very simple right now. It's not because this is a tutorial for beginners but because it's a good thing to do. As you design the system, you should move in small steps regardless of your experience.

Create a file `spec/bike_spec.rb`. We'll put our bike examples there. The name should end in "_spec" since this is the convention :pill: [rspec](https://github.com/makersacademy/course/blob/master/pills/rspec.md) uses. The first part of the filename is the name of the class. So we have just implied that the class we'll be testing will be called Bike.

Now let's write our first unit test in spec/bike_spec.rb. Note that we are placing our unit test in the spec folder, and our feature tests go in spec/feauture.  Our file structure should look like this:

```sh
→ tree
.
├── README.md
├── Rakefile
├── lib
│   └── docking_station.rb
└── spec
    ├── bike_spec.rb
    └── feature
        └── public_bike_access_spec.rb
```

Again, whatever you do, **DO NOT** copy and paste this code, you must type it out yourself (not the comments).  It is essential that you type the code out yourself or you will not learn effectively.

````ruby
#we're describing the functionality of a specific class, Bike
describe Bike do
  # this is a specific feature (behaviour)
  # that we expect to be present
  it 'is not broken initially' do
    # expect an instance of the Bike class to have
    # a method "broken?" that should return false
    expect(subject).not_to be_broken
  end
end
````

Again, note that the comments here are simply to help you first time around.  Please don't include them in your code, and in general avoid comments, preferring to write code that is comprehensible without comments.

So, we begin by writing an example (`it`) that describes what we want to see happening. We tell [rspec](http://rspec.info) that we are describing the class Bike (`describe`) and we want our bike to have a single feature: _we are expecting it not to be broken when we create it_.

So, now that you have an idea of what this test does, let's run it.  Assuming you have no RuboCop style offences it will fail with a new type of error.

````
→ rake
Running RuboCop...
Inspecting 4 files
....

4 files inspected, no offenses detected
/Users/tansaku/.rvm/rubies/ruby-2.1.5/bin/ruby -I/Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib:/Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-support-3.2.2/lib /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/exe/rspec --pattern spec/\*\*\{,/\*/\*\*\}/\*_spec.rb
/Users/tansaku/Documents/Github/MakersAcademy/bdd_boris_bikes/spec/bike_spec.rb:1:in `<top (required)>': uninitialized constant Bike (NameError)
	from /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib/rspec/core/configuration.rb:1226:in `load'
	from /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib/rspec/core/configuration.rb:1226:in `block in load_spec_files'
	from /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib/rspec/core/configuration.rb:1224:in `each'
	from /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib/rspec/core/configuration.rb:1224:in `load_spec_files'
	from /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib/rspec/core/runner.rb:97:in `setup'
	from /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib/rspec/core/runner.rb:85:in `run'
	from /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib/rspec/core/runner.rb:70:in `run'
	from /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib/rspec/core/runner.rb:38:in `invoke'
	from /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/exe/rspec:4:in `<main>'
/Users/tansaku/.rvm/rubies/ruby-2.1.5/bin/ruby -I/Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib:/Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-support-3.2.2/lib /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/exe/rspec --pattern spec/\*\*\{,/\*/\*\*\}/\*_spec.rb failed

````

What you see here is called a [stack trace](https://en.wikipedia.org/wiki/Stack_trace). We need to learn how to read it to understand where exactly the problem lies. If you can't read the [stack trace](https://en.wikipedia.org/wiki/Stack_trace), you won't be able to pinpoint and fix it.

The first line is the most important one. It explains what the problem was and where it occurred:

````
/Users/tansaku/Documents/Github/MakersAcademy/bdd_boris_bikes/spec/bike_spec.rb:1:in `<top (required)>': uninitialized constant Bike (NameError)
````

In this case, the problem is in the file `bike_spec.rb` on line 1. The `<top (required)>` means that the code causing trouble is not part of any specific method. The error that occurred is of the type [NameError](http://www.ruby-doc.org/core-2.1.2/NameError.html) and it's human-readable explanation is _"uninitialized constant Bike"_.

This is the same sort of error we had with the DockingStation in stage 1, however the format of the overall error is different.  RSpec has not been able to run completely, detect the error and present the error using it's own formatting.  This time a lower level Ruby error has been encountered that has preventing RSpec from completing its run.  We're seeing here a raw Ruby error, not an error that has been caught and formatted by RSpec as we saw with our feature test.

Other lines in the output show the path in the code Ruby went through before encountering the error on line 1 of `bike_spec.rb`. The second line was executed right before the line 1 was executed.

````ruby
/Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib/rspec/core/configuration.rb:1226:in `load'
````

This tells us that a line 1226 in the file `configuration.rb` that is inside a method "load" called our line in bike_spec that ultimately caused an error. This file is part of the [rspec-core](https://github.com/rspec/rspec-core) gem, version 3.2.1 that's installed for the version of Ruby 2.1.5 managed by rvm (hence these files are all in ~/.rvm). Normally you wouldn't go there unless you suspect a gem misbehaves or you want to really understand how it works. However, if this stack trace goes through your code for a while before raising an error, this information would be far more valuable.

The next line in the stack trace shows what was executed directly before `configuration.rb:1226` and so on. In this case the stack trace is showing the flow of execution through the underlying system code before the error was encountered.  In general you'll be hunting through stack traces to see if there are any parts of your code being hit and focusing on those.

Anyhow, the part of our code that is responsible is clear and since we've already solved this sort of error once for in our feature test for DockingStation you likely have a good idea about how to fix this one.  However you might be curious about why we get a Ruby error rather than an RSpec error.  Look closely at our Bike spec:

````ruby
describe Bike do
  it 'is not broken initially' do
    expect(subject).not_to be_broken
  end
end
````

Notice that on the first line we have `describe Bike do` where we are referring to the class Bike.  We're not using a string as we did in the feature test, where the string described the high level user story.  Here we are saying that our test will describe the Bike class.  As RSpec works on this file it has to go look for a Bike class before it can even run the tests specified in the 'it' blocks.  That's why we get the lower level Ruby error.

This new error of course means its a great time to switch Driver/Navigator Roles!&nbsp;:twisted_rightwards_arrows:

It seems likely we can fix this error by defining the bike. Create `lib/bike.rb` and define an empty Bike class.

````ruby
class Bike
end
```

And what's the other thing we'll need?  Of course we'll also need a `require` statement in the spec.

````ruby
require 'bike'
describe Bike do
  it 'is not broken initially' do
    expect(subject).not_to be_broken
  end
end
````

**Now our example fails.**

There's a difference between an error and a failure. An error happens when Ruby cannot run the example at all. For example, before we create a Bike class and required it, we couldn't run the test in principle – there was no class under test.

However, now the example is failing, which means that we can test the Bike class but it doesn't have the behaviour our example expects. Take a look at the list of failures in the output.  We have two, one from our existing feature test and another from our unit test: _Bike is not broken initially_.

````ruby
Failure/Error: expect(subject).not_to be_broken
  expected #<Bike:0x007f9d2c0b2ef0> to respond to `broken?`
# ./spec/bike_spec.rb:5:in `block (2 levels) in <top (required)>'
````

First, it shows us the [rspec expectation](https://www.relishapp.com/rspec/rspec-expectations/docs) that failed. Specifically, it tells us that the method `broken?` is undefined. (As before with the Docking Station #<Bike:0x007f9d2c0b2ef0> refers to the instance of the Bike class that we have in the "bike" variable).

So, the test is almost telling us what to do. We don't have the method `broken?`, so let's create one. Update the Bike class to include this method.

````ruby
class Bike
  def broken?
  end
end
````

Note that the method is empty. Why? Because RSpec didn't complain about anything else. It failed because there was no method? Let's do the minimum required to get over that failure: create the method. Now run the test again. Will it pass or fail? Why? Think about this question every time you run a test, don't just run it blindly.

So it passed. However, you may have expected it to fail. That would have been a reasonable assumption since there's no implementation of the method. However, in Ruby a nil value is treated as false if a boolean value is needed. Given that a method returns nil if nothing else is returned, an empty method always returns nil. So, by writing an empty method, we satisfy the test's expectation that the bike must not be broken.

[TODO: policy on commiting with broken feature test?]
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


Now it's a good time to check in the code. Stage and commit the files that changed and push to Github. It's a good practice to commit every time you are _green_.  It's also a good time to switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:, depending on your pairing methodology.


## Version 2: Refactoring

[TODO: use of subjects would annull the second refactoring here - could use a context/describe to extract subject/bike.break from a couple of tests]

Let's pause for a while before continuing implementing more features. Is our code really good? Is there any chance to refactor it?

Refactoring is the process of changing the structure of the code in order to make it more readable, maintainable or extendable without adding any new functionality.

Software developers, even (and especially) experienced ones, don't write perfect code on their first attempt. First you write the code that works, then you refactor it to make it good. Let's refactor the code we have so far.

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

One of the problems is the code repetition. Lines 4 and 16 are the same. Code repetition violates the **DRY principle**: [Don't Repeat Yourself](http://en.wikipedia.org/wiki/Don't_repeat_yourself). Repeating anything in the code or system design is a possible source of nasty bugs.

Instead of setting the instance variable in the initialiser, let's call the `fix!()` method instead.

Now run your tests to see if they pass. They should. This is how you know that the refactoring was successful: it didn't change the functionality while reducing the repetition in the code.

Now take a look at the tests. What could be improved here?

````ruby
require './lib/bike'

describe Bike do

  it 'should not be broken after we create it' do
    bike = Bike.new
    expect(bike).not_to be_broken
  end

  it 'should be able to break' do
    bike = Bike.new
    bike.break!
    expect(bike).to be_broken
  end

  it 'should be able to get fixed' do
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

  it 'should not be broken after we create it' do
    expect(bike).not_to be_broken
  end

  it 'should be able to break' do
    bike.break!
    expect(bike).to be_broken
  end

  it 'should be able to get fixed' do
    bike.break!
    bike.fix!
    expect(bike).not_to be_broken
  end

end
````

Line 5 calls an rspec helper `let()` that defines a local variable "bike" using the block provided (`{ Bike.new }`) before every test. This makes our tests more DRY. Run them to see if they still work. They should.

Even though there are other repeated lines (8 and 19), it doesn't make sense to extract them into their own methods for readability's sake. However, in some cases it may be better to extract them: always use your best judgement. The code should look and feel elegant to you.  

Note also that each time that you extract a commonality that you are adding a dependency.  DRYing out your code is very important, but developing an intuition for when to do it is critical.

Now that we've finished with refactoring, it's a good time to push to Github and to switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.
