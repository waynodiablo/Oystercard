## Stage 3: Creating a Bike via Unit Tests

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

So how do we model a bike?

A bike has a great many properties. It has a number of gears, it has a certain weight, etc. but none of that is relevant to the task of renting a bike from our system. Therefore, we shouldn't be concerned with those properties. Our feature test is indicating that the only thing about the bike that concerns us right now is whether it's working or not.

Let's write a specification for the bike that describes how we want the bike to behave. We're intentionally keeping everything very simple right now. It's not because this is a tutorial; it's just a good thing to do. As you design the system, you should move in small steps regardless of your experience.

Create a file `spec/bike_spec.rb`. The name should end in "_spec" since this is the convention [RSpec&nbsp;:pill:](https://github.com/makersacademy/course/blob/master/pills/rspec.md) uses. The first part of the filename is the name of the class. So we have just implied that the class we'll be testing will be called Bike.

Now let's write our first unit test in spec/bike_spec.rb. Note that we are placing our unit tests in the spec folder, and our feature tests in spec/features.  Our file structure should look like this:

```sh
$ tree
.
├── README.md
├── lib
│   └── docking_station.rb
└── spec
    ├── bike_spec.rb
    ├── docking_station_spec.rb
    └── features
        └── public_accesses_bike_spec.rb
```

Again, whatever you do, **DO NOT** copy and paste this code, you must type it out yourself.  It is essential that you type the code out yourself or you will not learn effectively.

```ruby
describe Bike do
  it { is_expected.to respond_to :working?}
end
```

Note that as before we are simply starting with the least demanding kind of test; that bikes respond to the 'working?' method using [RSpec's one-liner syntax](https://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/one-liner-syntax).

```
$ rspec
/Users/silvabox/source/makers_academy/boris-bikes/spec/bike_spec.rb:1:in `<top (required)>': uninitialized constant Bike (NameError)
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1226:in `load'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1226:in `block in load_spec_files'
	...and so on
```

The output you can see here is called a [stack trace;&nbsp;:pill:](../pills/stack_trace.md). We need to learn how to read it to understand exactly where the problem lies. If you can't read the stack trace, you won't be able to pinpoint the error and fix it.

This is the same sort of error we had with the DockingStation in Stage 2. The part of our code that is responsible is clear and since we've already solved this sort of error once in our unit test for DockingStation you likely have a good idea about how to fix this one.  However you might be curious about why we get a Ruby error rather than an RSpec error.  Look closely at our Bike spec:

```ruby
describe Bike do
  it { is_expected.to respond_to :working?}
end
```

Notice that on the first line we have `describe Bike do` where we are referring directly to the class Bike.  We're not using a string description as we did in the feature test.  This is a feature of RSpec that gives us some great conveniences such as the [implicitly defined subject](http://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/implicitly-defined-subject).  However, as Ruby executes this file it has to look for a Bike class, even before it can run the tests specified in the `it` blocks.  That's why we get the lower-level Ruby error.

This new error of course means its a great time to switch Driver/Navigator Roles!&nbsp;:twisted_rightwards_arrows:

It seems likely we can fix this error by defining the bike. Create `lib/bike.rb` and define an empty Bike class.

```ruby
class Bike

end
```

And what's the other thing we'll need?  Of course we'll also need a `require` statement in the spec.

```ruby
require 'bike'

describe Bike do
  it { is_expected.to respond_to :working?}
end
```

**Now our example fails.**

```
Bike should respond to #working?
   Failure/Error: it { is_expected.to respond_to :working? }
     expected #<Bike:0x007fb053c828b8> to respond to :working?
   # ./spec/bike_spec.rb:4:in `block (2 levels) in <top (required)>'
```

First, it shows us the [rspec expectation](https://www.relishapp.com/rspec/rspec-expectations/docs) that failed. Specifically, it expected an instance of the `Bike` class to respond to `working?`. (As before with the docking station, #<Bike:0x007f9d2c0b2ef0> refers to the instance of the Bike class that is being tested.)  Where does this instance of the `Bike` class come from.  Discuss this with your pair parter.  Did we just read about it?

Note also that RSpec will generate two failures here - one from the feature test and one from the unit test; both related to the absence of the 'working?' method - this is good and reassures us that our unit test is going to help us fix our feature test.

Further, the test is almost telling us what to do. We don't have the method `working?`, so let's create one. Update the Bike class to include this method.

```ruby
class Bike
  def working?

  end
end
```

Our code is still extremely basic but we're getting somewhere.  Our Bike is not complete, but it has sufficient functionality to now participate in our feature test.  Running RSpec we should see that our unit test passes, but our feature test does not.  It is still stuck on the same error as before, indicating there is more work to do :-/

However we've changed the error message again so it's a great time to switch driver/navigator roles&nbsp;:twisted_rightwards_arrows:.

```
$ rspec
..F

Failures:

  1) member of public accesses bike docking station releases a working bike
     Failure/Error: expect(bike).to be_working
       expected  to respond to `working?`
     # ./spec/features/public_accesses_bike_spec.rb:6:in `block (2 levels) in <top (required)>'

Finished in 0.00431 seconds (files took 1.27 seconds to load)
3 examples, 1 failure

Failed examples:

rspec ./spec/features/public_accesses_bike_spec.rb:3 # member of public accesses bike docking station releases a working bike
```

We have a similar problem as before in that RSpec is telling us that it expects `nil` to respond to `working?`.  Again, it would have been helpful if the message said `expected NilClass to respond to 'working?'`.  So what is `nil`?  Look at the line that the error is occurring on.  Check the code in your feature test.  Decide in you pair what thing is `nil`.  Try manually running the feature test in irb if you are having trouble working it out.

You should have ascertained that it is the `bike` variable.  But why?  Have a look at the code that assigns the bike variable `bike = docking_station.release_bike`.  What is returned by `docking_station.release_bike`?

Do we just go ahead and fix this now?  Or do we need to write some sort of test?  What sort of test?


```ruby
describe DockingStation do
  it { is_expected.to respond_to :release_bike }

  it 'releases working bikes' do
    bike = subject.release_bike
    expect(bike).to be_working
  end
end
```

Now we have a matched pair of failing tests again (one feature and one unit) but don't worry - that's progress; we're chipping away at the functionality needed for the feature with a succession of unit tests.  Let's focus our attention on the unit test:

```
DockingStation releases working bikes
     Failure/Error: expect(bike).to be_working
       expected  to respond to `working?`
     # ./spec/docking_station_spec.rb:8:in `block (2 levels) in <top (required)>'
```

So `release_bike` needs to return *something*.  We've already defined the `Bike` class, so let's return an *instance* of `Bike`:

```ruby
require_relative 'bike'

class DockingStation
  def release_bike
    Bike.new
  end
end
```

Notice the `require_relative 'bike'` at the top of the file.  Is this necessary?  Try removing it and run RSpec again.  Does it fail?  Discuss the output with your pair partner.  With this line still removed from your file, try running Boris Bikes in `irb`:

```
2.0.0-p195 :001 > require './lib/docking_station.rb'
 => true
2.0.0-p195 :002 > station = DockingStation.new
 => #<DockingStation:0x007fe2241b2700>
2.0.0-p195 :003 > bike = station.release_bike
NameError: uninitialized constant DockingStation::Bike
	from /Users/silvabox/source/makers_academy/boris-bikes/lib/docking_station.rb:3:in `release_bike'
	from (irb):3
	from /Users/silvabox/.rvm/rubies/ruby-2.0.0-p195/bin/irb:16:in `<main>'
2.0.0-p195 :004 >
```
What is going on here?  **It is very important that you understand this error message**.  Your code is running in two different environments.  One is provided by RSpec, the other by `irb`.  Take some time to discuss this with your pair partner.  Ask an [Alumni Helper](https://github.com/makersacademy/course/blob/master/toc.md#resources) or coach to explain it if you don't understand.

Add the `require_relative 'bike'` back in and repeat the test in `irb`.  **It's extremely good practice to break out and test in `irb` at appropriate intervals.**  Research the difference between `require` and `require_relative`.  Can you tell why we needed `require_relative` in this instance?

Ironically, given how carefully we have test-driven our code via feature and unit tests, there is a problem it does not catch.  This is a fairly common experience for developers.  Tests are great for taming complex systems but they are not bulletproof.  A sanity check of the actual user interface is always recommended.

Anyway, back to our tests.  Are they passing?  Why?

Let's do the simplest thing we can to pass our unit test:

```ruby
class Bike
  def working?
    true
  end
end
```

This change should ensure the feature test passes as well as the unit test.  It is not necessarily the best practice to just create Bikes in DockingStations like this, but it is arguably the simplest thing to do in order to get this test to pass.  Sometimes, in the name of simplicity, we will write code that we will change later.  The code allows a DockingStation to be an unlimited generator of new Bikes.  This is not how real Boris Bike docking stations work, however our feature and unit tests are not yet specifying any other constraints.  Any new functionality that you create in your system should be created through the process of writing new feature tests and then unit tests.  If you are tempted to add more complexity than is demanded by your tests then you will create code that is not completely tested and may not be needed.  If you find yourself thinking "oh yes, we must have that, we must have this", hold that thought.  Add a note of the extra thing to your user stories - check with the client.  In the first instance always do the simplest thing possible thing.  Like a Zen Garden your code should grow in tiny simple steps.

So now we have our working system, test-driven and sanity checked. We can compare this with the original specification of what we wanted the user to experience via the irb interface and see that we are getting approximately the behavior we expect. **Please ensure you do run the feature test manually in IRB before proceeding.** More seriously, doing the simplest thing possible has introduced a nasty design smell into our code.  DockingStation is now very tightly coupled to the Bike class.  It now can't be tested independently of Bike, and we are missing an opportunity to make our classes more flexible and maintainable.  Let's see how we can improve on our existing design with a refactoring step.

**However all our examples pass, so it's a perfect time to commit our changes and push it to Github ([Version Control with Git&nbsp;:pill:](https://github.com/makersacademy/course/blob/master/pills/git.md)).**

:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial.

Time to move on to [Stage 4](boris_bikes_stage_4.md)!
