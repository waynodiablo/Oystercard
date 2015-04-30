## Stage 2: Creating a Docking Station via Unit Tests

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach these as challenges on which to polish your debugging skills - pull requests always welcome.***

So how did you try to deal with the error we saw at the end of stage 1?  Here it is again:

```
$ rspec
F

Failures:

  1) member of public accesses bike docking station releases a working bike
     Failure/Error: docking_station = DockingStation.new
     NameError:
       uninitialized constant DockingStation
     # ./spec/features/public_accesses_bike_spec.rb:3:in `block (2 levels) in <top (required)>'

Finished in 0.00066 seconds (files took 0.95704 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/features/public_accesses_bike_spec.rb:2 # member of public accesses bike docking station releases a working bike
```

Let's look through it piece by piece.  First we see the contents of the strings we passed to the RSpec `feature` and `scenario` methods that tell us what feature is under test.  Next we have information about a single failure.  RSpec helpfully prints out the precise code that is causing the problem `docking_station = DockingStation.new`, the type of error `NameError` and even tells us the line number and the complete file path where the issue occurred ` ./spec/features/public_accesses_bike_spec.rb:3:`.

In this case, the problem is in the file `spec/feature/public_accesses_bike_spec.rb` on line 3. The error that occurred is [NameError](http://www.ruby-doc.org/core-2.1.2/NameError.html) and its explanation is `uninitialized constant DockingStation`.

The `uninitialized constant DockingStation` means that Ruby doesn't know what `DockingStation` is.

Stop for a second and think about what could be the reason for this error. The answer may be obvious, but think about the most likely reason Ruby doesn't know about `DockingStation`.

If you guessed that the `uninitialized constant DockingStation` error happened because we never defined what a DockingStation is, you're correct. It was simple in this case but it will be less trivial as we encounter more complex bugs later.

You may be tempted now to jump in and fix the error.  However, **we have reached the crux of Behaviour Driven Development (BDD).  Before progressing any further, please read the [BDD pill&nbsp;:pill:](../pills/bdd.md).  In fact, we think BDD is so important, we've written two pills, so please read the [BDD Cycle pill&nbsp;:pill:](../pills/bdd.md) as well and use this understanding to anticipate the next move.  Discuss the next move with your pair partner - do you have the same idea?**


What we have here is a failing *feature test*.  Ideally, we want to test-drive our code using *unit tests*.  Take a moment to discuss this with your pair partner.  What is the difference between a feature test and a unit test?  How does this relate to TDD?


This would be a great time to switch Driver/Navigator Roles!&nbsp;:twisted_rightwards_arrows:  Let your partner start typing now.  One of you has written this first test, and got the first error.  Errors are a great time to switch roles so you can work to the ['change-the-message' pairing protocol](../pills/pairing.md#change-the-message-between-programmer-a-and-b).


We have identified that we need a DockingStation class.  But before we create one, we want a **failing unit test**.

Create the following code in `spec/docking_station_spec.rb`:

```ruby
describe DockingStation do

end
```

We haven't created any expectations yet - we are just setting up the test.  Try running RSpec.  Discuss the output with your pair partner.  What do you think it means?

You should see something similar to the following:
```
$ rspec
/Users/silvabox/source/makers_academy/boris-bikes/spec/docking_station_spec.rb:1:in `<top (required)>': uninitialized constant DockingStation (NameError)
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1226:in `load'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1226:in `block in load_spec_files'
	...and so on
```

Hopefully, you were able to recognize that this does not look like an RSpec failure.  This is a Ruby error.  What is the difference?  Why are we getting a Ruby error here, when we were getting an RSpec failure in our feature test?

**It is absolutely critical to understand the difference.**  You will spend a large amount of your time as a developer *debugging* code.  The primary skill in debugging is to read and understand error messages and test failures.  Please spend some more time discussing with your pair partner why these two tests behave differently.  You may need to ask an [Alumni Helper](https://github.com/makersacademy/course/blob/master/toc.md#resources) or coach to explain as it is not necessarily immediately obvious.  Please do not progress until you have understood this distinction.

Now, let's define the DockingStation class. Create `lib/docking_station.rb` and define an empty DockingStation class.

```ruby
class DockingStation

end
```

Why did we put this in a `lib` folder?  Why did we call it `docking_station.rb`?  Take a moment to discuss this with your pair partner.

The name of the file is `docking_station.rb` for a reason. If we're defining a class DockingStation, we should put it in `docking_station.rb`. It's not required strictly speaking, but it's a really good idea to put only one class in a `.rb` file and name it accordingly.

If you run the test now, will it pass? Again, stop for a moment and think before doing it.  You are predicting the result of a small experiment. If you have an expectation of whether it will pass or not, you will know whether everything is going according to your understanding of the program or not. So, will it pass or not and why?

```sh
$ rspec
```

You'll find out it doesn't. Same error again. Ruby still has no idea about the DockingStation class. But why, when we've just defined it in `docking_station.rb`?

Think about it from Ruby's perspective. There are lots and lots of ruby files on your computer, defining hundreds if not thousands of different classes. Should all of them be available in every other Ruby file? Probably not. It's the programmer's responsibility to decide what should be available to Ruby code at what point. In other words, we haven't established any link between `spec/docking_station_spec.rb` and `lib/docking_station.rb`. That they are in the same repo or nearby directories matters very little to Ruby. We need to explicitly link them together.

Add a `require` statement to the spec.

```ruby
require 'docking_station'

describe DockingStation do

end
```

Now run RSpec again - do you expect it will work?

You should be getting an RSpec failure again now, rather than a Ruby error.  Compare the failure with the failure we started with at the beginning of the stage.  Is it the same?  If not, why is it different?  Take some time to discuss this with your pair partner.  What will you do next?

It might feel like things are getting worse, but a new failure or error message is cause for celebration!  A new error or failure means more information that we can use to work out what is going on.  It might be hard to imagine it, but ultimately you will start to feel joy and excitement when you have a new error or failure:

```
F

Failures:

  1) member of public accesses bike docking station releases a working bike
     Failure/Error: bike = docking_station.release_bike
     NoMethodError:
       undefined method `release_bike' for #<DockingStation:0x007fd6cc85f868>
     # ./spec/features/public_accesses_bike_spec.rb:6:in `block (2 levels) in <top (required)>'

Finished in 0.00053 seconds (files took 0.96987 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/features/public_accesses_bike_spec.rb:4 # member of public accesses bike docking station releases a working bike
```

Our example is failing, which means that although we can now test the DockingStation class, it doesn't have the behaviour our scenario expects. Take a look at the list of failures in the output. There is only one: `member of public accesses bike docking station releases a working bike`. Where does the message come from? Look at the structure of the scenario.

```ruby
feature 'member of public accesses bike' do
  scenario 'docking station releases a working bike' do
    # the test goes here, omitted for brevity
  end
end
```

RSpec simply concatenates 'member of public accesses bike' from the `feature` statement and the 'docking station releases a working bike' from the `scenario` block.  So, what's the failure of the test?

```
Failure/Error: bike = docking_station.release_bike
NoMethodError:
  undefined method `release_bike' for #<DockingStation:0x007ff3c306ea28>
# ./spec/feature/public_accesses_bike_spec.rb:6:in `block (2 levels) in <top (required)>'
```

First, it shows us the [rspec expectation](https://www.relishapp.com/rspec/rspec-expectations/docs) that failed. Specifically, it tells us that the method `release_bike` is undefined. (``#<DockingStation:0x007ff3c306ea28>`` refers to the instance of the DockingStation class that we have in the `docking_station` variable. The long number following is the memory address).

So, the test is almost telling us what to do. We don't have the method `release_bike`, and it's tempting to just go ahead and create one, however we are at the *feature test* level, and we want to test-drive our code at the *unit test* level right?

It might seem as though we are writing the same tests twice over.  After all, so far adding the unit test for `DockingStation` has not made any difference.  But remember that the tests have a different *purpose*.  The feature test is intended to test an overall outcome of a sequence of *integrations* (i.e. a number of objects working together) and is not concerned with the detail of each component within that test.  A unit test is concerned with the detail of a *single component* and is not concerned with how it might be used in the wider program.  In a trivial example such as this, these tests do look very similar, but in a more complex system - as we will be building later in the course - they will not.

Let's create a unit test for `release_bike` in `spec/docking_station_spec.rb`:

```ruby
require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }
end
```

Notice that we are using the more common RSpec `describe`/`it` syntax here.  The test is remarkably succinct; but does it not also describe exactly what we want?  This is why we love RSpec.  Our test is beautifully readable and we are in no doubt as to what it does.

We are using [RSpec's one-liner syntax](https://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/one-liner-syntax).  We could just as easily have written the test like so:

```ruby
require 'docking_station'

describe DockingStation do
  it 'responds to release_bike' do
    expect(subject).to respond_to :release_bike
  end
end
```

...which uses the RSpec [implicitly defined subject](http://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/implicitly-defined-subject) syntax. The advantage of the one-liner syntax is that RSpec can infer the description from the syntax - so an additional description is unnecessary and just adds clutter.  As a developer you must constantly strive for readability and ensure that test descriptions correspond exactly with what is being tested.

Before you run `$ rspec`, discuss with your pair partner what outcome you expect.  How many failures will there be?


```
FF

Failures:

  1) DockingStation should respond to #release_bike
     Failure/Error: it { is_expected.to respond_to :release_bike }
       expected #<DockingStation:0x007f85816af5a0> to respond to :release_bike
     # ./spec/docking_station_spec.rb:4:in `block (2 levels) in <top (required)>'

  2) member of public accesses bike docking station releases a working bike
     Failure/Error: bike = docking_station.release_bike
     NoMethodError:
       undefined method `release_bike' for #<DockingStation:0x007f85816dd7c0>
     # ./spec/features/public_accesses_bike_spec.rb:5:in `block (2 levels) in <top (required)>'

Finished in 0.00201 seconds (files took 1.24 seconds to load)
2 examples, 2 failures

Failed examples:

rspec ./spec/docking_station_spec.rb:4 # DockingStation should respond to #release_bike
rspec ./spec/features/public_accesses_bike_spec.rb:3 # member of public accesses bike docking station releases a working bike
```

That the feature test and the unit test are getting stuck on the same point (the absence of the 'release_bike' method), is good.  It is telling us that if we can make the unit test pass, that it should help the feature test pass.  We're breaking down the larger problem of implementing the whole feature into little slices.

Let's pass this unit test by updating the DockingStation class:

```ruby
class DockingStation
  def release_bike

  end
end
```

Now our DockingStation unit test should pass, and our acceptance test should be reporting a new failure.  This is progress worth celebrating!  Woohoo!

```
.F

Failures:

  1) member of public accesses bike docking station releases a working bike
     Failure/Error: expect(bike).to be_working
       expected  to respond to `working?`
     # ./spec/features/public_accesses_bike_spec.rb:6:in `block (2 levels) in <top (required)>'

Finished in 0.00395 seconds (files took 1.21 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/features/public_accesses_bike_spec.rb:3 # member of public accesses bike docking station releases a working bike
```

This error is a little more difficult to interpret.  At the moment our `release_bike` method returns nothing; a `nil` in fact.  `nil` is represented as an empty string in the failure message `expected  to respond to 'working?'`.  It might have been better if RSpec had reported `expected NilClass to respond to 'working?'` and maybe in a future release it will.

Let's just check our code in irb, manually stepping through our feature test:

```sh
$ irb
2.2.1 :001 > require './lib/docking_station'
 => true
2.2.1 :002 > station = DockingStation.new
 => #<DockingStation:0x007f8433082578>
2.2.1 :003 > bike = station.release_bike
 => nil
2.2.1 :004 > bike.working?
NoMethodError: undefined method `working?' for nil:NilClass
	from (irb):4
	from /Users/tansaku/.rvm/rubies/ruby-2.2.1/bin/irb:11:in `<main>'
```

Note that we can see exactly the same problem as is identified by the tests.  If we didn't have feature tests we'd have to be manually checking this by hand every time, and you can imagine how laborious that would become as the system grows in size.

Anyhow, to fix this issue, we need to drop from our feature test level into our unit test level again.  Also, since we've changed the error message, it's naturally a good time to switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:, following the [change-the-message pairing methodology](../pills/pairing.md#change-the-message-between-programmer-a-and-b).

Before progressing to [Stage 3](boris_bikes_stage_3.md), discuss with your pair partner what you need to test next.  What needs to respond to `working?`?
