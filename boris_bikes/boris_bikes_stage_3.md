## Stage 3: Creating a Bike via Unit Tests

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


Our code is still extremely basic but we're getting somewhere.  Our Bike is not really complete, but it has suffcient functionality to now participate in our feature test.

:twisted_rightwards_arrows:??


### Making the feature test pass

As usual we want to do the absolutely simplest thing possible to make our test pass.  In this case, that is to update our Docking Station as follows:

```ruby
class DockingStation
  def release_bike
    Bike.new
  end
end
```

Assuming no style violations this change should ensure the feature test passes as well as the unit test.

[Subtle problem relating to order of file loading]

```sh
→ irb
2.1.5 :001 > require './lib/docking_station'
 => true
2.1.5 :002 > d = DockingStation.new
 => #<DockingStation:0x007ffd41275df8>
2.1.5 :003 > d.release_bike
NameError: uninitialized constant DockingStation::Bike
	from /Users/tansaku/Documents/Github/MakersAcademy/bdd_boris_bikes/lib/docking_station.rb:3:in `release_bike'
	from (irb):3
	from /Users/tansaku/.rvm/rubies/ruby-2.1.5/bin/irb:11:in `<main>'
```


[probably too advanced ... bad habit?]

```ruby
Dir['./lib/*.rb'].each { |f| require f }
```
but does fix the above. Alternative is to ensure that the DockingStation knows about the Bike class:

```ruby
require_relative 'bike'

class DockingStation
  def release_bike
    Bike.new
  end
end
```

```sh
→ irb
2.1.5 :001 > d = DockingStation.new
 => #<DockingStation:0x007fe6ab15bb40>
2.1.5 :002 > b = d.release_bike
 => #<Bike:0x007fe6ab16b540>
2.1.5 :003 > b.broken?
 => nil
```

We can compare this with the original interface specification and see that we are getting approcimately the behavior we expect.  We get a nil instead of a false, but those are equivalent in Ruby.  More seriously, doing the simplest thing possible has introduced a nasty design smell into our code.  DockingStation is now very tightly coupled to the Bike class.  It now can't be tested independently of Bike, and we are missing an opportunity to make our classes more flexible and maintainable.  Let's see how we can improve on our existing design with a refactoring step.

**However all our examples pass, so it's a perfect time to commit our changes and push it to Github (:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)).
**

[TODO link to stage 4 refactoring]
