## Stage 3: Creating a Bike via Unit Tests

***Please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

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

```ruby
describe Bike do
  it { is_expected.to respond_to :broken?}
end
```

Note that as before we are again starting with the least demanding kind of test, simple that bikes can respond to the 'broken?' method. So, we begin by writing an example (`it`) that describes what we want to see happening. We tell [rspec](http://rspec.info) that we are describing the class Bike (`describe`) and we want our bike to have a single feature: _we are expecting it to be able to respond to the broken? method_.  Here again we are using [RSpec's 'one liner' syntax](https://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/one-liner-syntax).

Given we have an idea of what this test does, let's run it.  Assuming you have no RuboCop style offences it will fail with a new type of error.

````
→ rake
Running RuboCop...
Inspecting 5 files
.....

5 files inspected, no offenses detected
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

In this case, the problem is in the file `bike_spec.rb` on line 1. The `<top (required)>` means that the code causing trouble is not part of any specific method. The error that occurred is of the type [NameError](http://www.ruby-doc.org/core-2.1.5/NameError.html) and it's human-readable explanation is _"uninitialized constant Bike"_.

This is the same sort of error we had with the DockingStation in stage 1, however the format of the overall error is different.  RSpec has not been able to run completely, detect the error and present the error using it's own formatting.  This time a lower level Ruby error has been encountered that has preventing RSpec from completing its run.  We're seeing here a raw Ruby error, not an error that has been caught and formatted by RSpec as we saw with our feature test.

Other lines in the output show the path in the code Ruby went through before encountering the error on line 1 of `bike_spec.rb`. The second line was executed right before the line 1 was executed.

````ruby
/Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib/rspec/core/configuration.rb:1226:in `load'
````

This tells us that a line 1226 in the file `configuration.rb` that is inside a method "load" called our line in bike_spec that ultimately caused an error. This file is part of the [rspec-core](https://github.com/rspec/rspec-core) gem, version 3.2.1 that's installed for the version of Ruby 2.1.5 managed by the Ruby Version Manager rvm (hence these files are all in ~/.rvm). Normally you wouldn't go there unless you suspect a gem is misbehaving or you want to really understand how it works. However, if this stack trace goes through your code for a while before raising an error, this information would be far more valuable.

The next line in the stack trace shows what was executed directly before `configuration.rb:1226` and so on. In this case the stack trace is showing the flow of execution through the underlying system code before the error was encountered.  In general you'll be hunting through stack traces to see if there are any parts of your code being hit and focusing on those.

Anyhow, the part of our code that is responsible is clear and since we've already solved this sort of error once for in our feature test for DockingStation you likely have a good idea about how to fix this one.  However you might be curious about why we get a Ruby error rather than an RSpec error.  Look closely at our Bike spec:

````ruby
describe Bike do
  it { is_expected.to respond_to :broken?}
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
  it { is_expected.to respond_to :broken?}
end
````

**Now our example fails.**

There's a difference between an error and a failure. An error happens when Ruby cannot run the example at all. For example, before we create a Bike class and required it, we couldn't run the test in principle – there was no class under test.

However, now the example is failing, which means that we can test the Bike class but it doesn't have the behaviour our example expects. Take a look at the list of failures in the output.  We have two, one from our existing feature test and another from our unit test: _Bike should respond to #broken?_.

````ruby
   Failure/Error: it { is_expected.to respond_to :broken? }
     expected #<Bike:0x007fe2e92369b8> to respond to :broken?
   # ./spec/bike_spec.rb:3:in `block (2 levels) in <top (required)>'
````

First, it shows us the [rspec expectation](https://www.relishapp.com/rspec/rspec-expectations/docs) that failed. Specifically, it tells us that the method `broken?` is undefined. (As before with the Docking Station #<Bike:0x007f9d2c0b2ef0> refers to the instance of the Bike class that we have in the "bike" variable).

So, the test is almost telling us what to do. We don't have the method `broken?`, so let's create one. Update the Bike class to include this method.

````ruby
class Bike
  def broken?
  end
end
````

Our code is still extremely basic but we're getting somewhere.  Our Bike is not really complete, but it has suffcient functionality to now participate in our feature test.

We've changed the error message again so it's a great time to switch driver/navigator roles&nbsp;:twisted_rightwards_arrows:.

Notice that this code still doesn't check that the Bike is initially not broken.  This corresponds to a more rigorous test, actually checking what the method returns.  We can do that with the following [predicate](https://www.relishapp.com/rspec/rspec-expectations/
docs/built-in-matchers/predicate-matchers) syntax:

````ruby
require 'bike'
describe Bike do
  it { is_expected.to respond_to :broken? }
  context 'when created' do
    it { is_expected.to not_to be_broken}
  end
end
````

However interestingly even though this is a more rigorous test it will just pass as is.  Can you work out why?

Notice also that our first it statement is redundant.  Since we call the method 'broken?' in the second 'it' statement DockingStation is implicitly checked for responding to 'broken?'.  Arguably we could delete the first 'it' statement with no loss.  Let's do that.  It's good habit to get into; deleting code that is not doing anything for you.


### Making the feature test pass

So all our unit tests now pass, but still not our feature test.  As usual we want to do the absolutely simplest thing possible to make our test pass.  We might be tempted to bash away at application code, but it's our feature test that's failing, so we need a new unit test:

```ruby
describe DockingStation do
  it { is_expected.to respond_to :release_bike }
  it 'releases bikes that are not broken' do
    bike = subject.release_bike
    expect(bike).not_to be_broken
  end
end
```

Running our tests now we should have a matching unit and acceptance test.  BTW, can you see any code that could safely be deleted now?

Now, assuming that we have no more unrevealed feature test errors, what's the simplest thing we could possibly do to make this unit test pass?  How about updating our Docking Station as follows:

```ruby
class DockingStation
  def release_bike
    Bike.new
  end
end
```

Assuming no style violations this change should ensure the feature test passes as well as the unit test.  It is not necessarily the best practice to just create Bikes in DockingStations like this, but it is arguably the absolutely simplest thing to do in order to get this test to pass.  Sometimes in the name of simplicity we will write code that we will refactor away later.  This code basically allows a DockingStation to be an unlimited generator of new Bikes.  This may not be how real Boris Bike docking stations work, however our feature and unit tests are not currently specifying anything different.  Any new functionality that you create in your system should be created through the process of writing new feature-tests and then unit-tests.  If you are tempted to add more complexity than is demanded by your tests then you are in a dangerous area.  You are creating code that will not be completely tested and may not be needed.  If you find yourself thinking "oh yes, we must have that, we must have this", hold that thought.  Add a note of the extra thing to your user stories - check with the client.  In the first instancce always do the simplest thing possible thing.  Like a Zen Garden your code should grow in tiny simple steps.

Ironically given how we have carefully test driven our code via feature and unit tests, there is actually a problem that it does not catch.  This is a fairly common experience for developers.  Even with great care, the best laid tests can fail to catch something that a user will then experience through the real interface.  Tests are great for taming complex systems but they are not bullet proof.  A sanity check of the actual user interface is always recommended.  For example if we try to run our system in IRB we get the following result:

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

The problem is that RSpec, has eagerly loaded all the necessary files, and so our tests all pass.  Outside of the Rspec environment however, the DockingStation does not know about the Bike class.  If we fix that like so:

```ruby
require_relative 'bike'

class DockingStation
  def release_bike
    Bike.new
  end
end
```

Research the difference between require and require_relative.  Can you tell why we needed require_relative in this instance?

```sh
→ irb
2.1.5 :001 > d = DockingStation.new
 => #<DockingStation:0x007fe6ab15bb40>
2.1.5 :002 > b = d.release_bike
 => #<Bike:0x007fe6ab16b540>
2.1.5 :003 > b.broken?
 => nil
```

So now we have our working system, test driven and sanity checked. We can compare this with the original interface specification and see that we are getting apprxcimately the behavior we expect.  We get a nil instead of a false, but those are equivalent in Ruby.  More seriously, doing the simplest thing possible has introduced a nasty design smell into our code.  DockingStation is now very tightly coupled to the Bike class.  It now can't be tested independently of Bike, and we are missing an opportunity to make our classes more flexible and maintainable.  Let's see how we can improve on our existing design with a refactoring step.

**However all our examples pass, so it's a perfect time to commit our changes and push it to Github (:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)).**

:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial.

Time to move on to [Stage 4](boris_bikes_stage_4.md)!
