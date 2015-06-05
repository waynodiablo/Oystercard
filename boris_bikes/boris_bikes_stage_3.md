## Stage 3: Creating a Bike via Unit Tests

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

So how do we model a bike?

A bike has a great many properties. It has a number of gears, it has a certain weight, etc. but none of that is relevant to the task of renting a bike from our system. Therefore, we shouldn't be concerned with those properties; the only thing about the bike that concerns us right now is whether it's working or not.

Let's write a specification for the bike that describes how we want the bike to behave. We're intentionally keeping everything very simple right now. It's not because this is a tutorial; it's just a good thing to do. As you design the system, you should move in small steps regardless of your experience.

Create a file `spec/bike_spec.rb`. The name should end in "_spec" since this is the convention [RSpec&nbsp;:pill:](../pills/rspec.md) uses. The first part of the filename is the name of the class. So we have just implied that the class we'll be testing will be called Bike.

Now let's write our first unit test in spec/bike_spec.rb.  Our file structure should now look like this:

```sh
$ tree
.
├── lib
│   └── docking_station.rb
└── spec
    ├── bike_spec.rb
    ├── docking_station_spec.rb
    └── spec_helper.rb
```

Having the file locations set up correctly is absolutely essential for the correct running of your tests and the system itself.  Later on we'll learn how to adjust the file layout when needed, but for now just focus on ensuring that the files you create are in the exact same locations as described above.

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

**Now our example 'fails', rather than 'errors'.**

```
Bike should respond to #working?
   Failure/Error: it { is_expected.to respond_to :working? }
     expected #<Bike:0x007fb053c828b8> to respond to :working?
   # ./spec/bike_spec.rb:4:in `block (2 levels) in <top (required)>'
```

First, it shows us the [rspec expectation](https://www.relishapp.com/rspec/rspec-expectations/docs) that failed. Specifically, it expected an instance of the `Bike` class to respond to `working?`. (As before with the docking station, #<Bike:0x007f9d2c0b2ef0> refers to the instance of the Bike class that is being tested.)  Where does this instance of the `Bike` class come from.  Discuss this with your pair parter.  Did we just read about it?

Note also that this failure corresponds closely (although not exactly) to the error from our manual feature test at the end of stage 2.  Check back to reflect on the differences and similarities.

Further, the test is almost telling us what to do. We don't have the method `working?`, so let's create one. Update the Bike class to include this method.

```ruby
class Bike
  def working?

  end
end
```

Our code is still extremely basic but we're getting somewhere.  Our Bike is not complete, but it has sufficient functionality to now participate in our feature test.  Running RSpec we should see that our unit test passes, but restarting IRB we see that our manual feature test does not.  It is still stuck on the same error as before, indicating there is more work to do :-/

However we've changed the error message again so it's a great time to switch driver/navigator roles&nbsp;:twisted_rightwards_arrows:.

```
$ irb
2.2.2 :001 > require './lib/docking_station'
 => false
2.2.2 :002 > station = DockingStation.new
 => #<DockingStation:0x007fd45b884208>
2.2.2 :003 > bike = station.release_bike
 => nil
2.2.2 :004 > bike.working?
NoMethodError: undefined method `working?' for nil:NilClass
	from (irb):4
	from /Users/tansaku/.rvm/rubies/ruby-2.2.2/bin/irb:11:in `<main>'
```

The problem here seems to be that we have no method `working?` defined for `nil:NilClass`.  So what is `nil:NilClass` or `nil`?  Look at the result that IRB shows for the 3rd statement in the above feature test.

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

This error is a little more difficult to interpret.  At the moment our `release_bike` method returns nothing; a `nil` in fact.  `nil` is represented as an empty string in the failure message `expected  to respond to 'working?'`.  It might have been better if RSpec had reported `expected NilClass to respond to 'working?'` and maybe in a future release it will.

Anyhow `release_bike` needs to return *something*.  We've already defined the `Bike` class, so let's return an *instance* of `Bike`:

```ruby
require_relative 'bike'

class DockingStation
  def release_bike
    Bike.new
  end
end
```

Notice the `require_relative 'bike'` at the top of the file.  Is this necessary?  Try removing it and run RSpec again.  We should have moved on to a new failure from the last one, but does the absence of presence of `require_relative 'bike'` change that error?  Discuss the output with your pair partner.  How does DockingStation know what a Bike is without `require_relative 'bike'`?  With this line still removed from your file, try running the manual feature test in IRB:

```
$ irb
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

Add the `require_relative 'bike'` back in and repeat the feature test in `irb`.  It should work now, or at least get you as far as:

```
2.2.2 :003 > bike = station.release_bike
 => #<Bike:0x007faade0399c8>
2.2.2 :004 > bike.working?
 => nil
```

**As you can see this process of manual feature testing in `irb` is absolutely essential to ensure that your objects play well together.**  Research the difference between `require` and `require_relative`.  Can you tell why we needed `require_relative` in this instance?

Ironically, given how carefully we have test-driven our code via unit tests in RSpec, there is a problem they failed to catch.  This is a fairly common experience for developers.  Tests are great for taming complex systems but they are not bulletproof.  A sanity check of the actual user interface is always recommended.

So we've almost got our entire manual feature test working as specified at the beginning of stage 1.  The only thing missing is that when we ask our bike if it is working we get a nil and not a true :-(

Let's look at our unit tests again.  Are they passing?  Why not?

We got sidetracked here dealing with the require_relative issue, but our currently failing unit test corresponds precisely to the last problem with our manual feature test:

```sh
1) DockingStation releases working bikes
   Failure/Error: expect(bike).to be_working
     expected `#<Bike:0x007ff95b891b68>.working?` to return true, got nil
   # ./spec/docking_station_spec.rb:7:in `block (2 levels) in <top (required)>'
```

Hopefully this RSpec unit test failure is relatively easy to analyse. Let's do the simplest thing we can to pass this unit test:

```ruby
class Bike
  def working?
    true
  end
end
```

This change should ensure that we can run our complete manual feature test as specified at the start of stage 1 as well as the unit test.  It is not necessarily the best practice to just create Bikes in DockingStations like this, but it is arguably the simplest thing to do in order to get this test to pass.  Sometimes, in the name of simplicity, we will write code that we will change later.  The code allows a DockingStation to be an unlimited generator of new Bikes.  This is not how real Boris Bike docking stations work, however our feature and unit tests are not yet specifying any other constraints.  Any new functionality that you create in your system should be created through the process of specifying new feature tests and then unit tests.  If you are tempted to add more complexity than is demanded by your tests then you will create code that is not completely tested and may not be needed.  If you find yourself thinking "oh yes, we must have that, we must have this", hold that thought.  Add a note of the extra thing to your user stories - check with the client.  In the first instance always do the simplest thing possible thing.  Like a Zen Garden your code should grow in tiny simple steps.

**All our examples pass, so it's a perfect time to commit our changes and push it to Github ([Version Control with Git&nbsp;:pill:](https://github.com/makersacademy/course/blob/master/pills/git.md)).**

So now we have our working system, test-driven and sanity checked. We can compare this with the original specification of what we wanted the user to experience via the irb interface and see that we are getting exactly the behavior we expect.

:running_shirt_with_sash: ATHLETIC WAYPOINT - try re-creating the code so far from scratch without looking at the tutorial.

Time to move on to [Stage 4](boris_bikes_stage_4.md)!
