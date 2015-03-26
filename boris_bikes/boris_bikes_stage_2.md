## Stage 2: Creating a Docking Station via Unit Tests

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

So how did you try to deal with the error we saw at the end of stage 1?  Here it is again:

```sh
→ rake
Running RuboCop...
Inspecting 2 files
..

2 files inspected, no offenses detected
/Users/tansaku/.rvm/rubies/ruby-2.1.5/bin/ruby -I/Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib:/Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-support-3.2.2/lib /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/exe/rspec --pattern spec/\*\*\{,/\*/\*\*\}/\*_spec.rb

member of public accesses bike
  docking station releases a bike that is not broken (FAILED - 1)

Failures:

  1) member of public accesses bike docking station releases a bike that is not broken
     Failure/Error: docking_station = DockingStation.new
     NameError:
       uninitialized constant DockingStation
     # ./spec/feature/public_bike_access_spec.rb:3:in `block (2 levels) in <top (required)>'

Finished in 0.00049 seconds (files took 0.18432 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/feature/public_bike_access_spec.rb:2 # member of public accesses bike is not broken
```

Let's look through it piece by piece.  The very first output is just RuboCop checking for style violations.  After that we have the RSpec output.  Let's read through it carefully.  First we see the contents of the strings we passed to the RSpec 'feature' and 'scenario' methods that tell us what feature is under test.  Next we have information about a single failure.  RSpec helpfully prints out the precise code that is causing the problem 'docking_station = DockingStation.new', the type of error 'NameError' and even tells us the line number and the complete file path where the issue occurred.

In this case, the problem is in the file `spec/feature/public_bike_access_spec.rb` on line 3. The `<top (required)>` means that the code causing trouble is not part of any specific method. The error that occurred is of the type [NameError](http://www.ruby-doc.org/core-2.1.2/NameError.html) and it's human-readable explanation is _"uninitialized constant DockingStation"_.

The _"uninitialized constant DockingStation"_ means that Ruby doesn't know what `DockingStation` is.

Now, stop for a second and think about what could be the reason for the error. The answer may be obvious because this particular problem is relylative simple but it's important to take this step and ask yourself this question every time you see an error. Don't assume the first thing that comes to mind. Think about what is the most likely reason Ruby doesn't know about `DockingStation`.

If you guessed that the `uninitialized constant DockingStation` error happened because we never defined what a DockingStation is, you're correct. It was simple in this case but it will be less trivial as we encounter more complex bugs later.

This would be a great time to switch Driver/Navigator Roles!&nbsp;:twisted_rightwards_arrows:  Let your partner start typing now.  One of you has written this first test, and got a first error.  Errors are a great time to switch roles so you can work to the ['change-the-message' pairing protocol](https://github.com/makersacademy/course/blob/master/pills/pairing.md#change-the-message-between-programmer-a-and-b).

Let's define the DockingStation class. Create `lib/docking_station.rb` and define an empty DockingStation class.

````ruby
class DockingStation
end
````

The name of the file is `docking_station.rb` for a reason. If we're defining a class DockingStation, we should put it in `docking_station.rb`. It's not required, strictly speaking but it's a really good idea to put only one class in a `.rb` file and name it accordingly.

If you run the test right now, will it pass? Again, stop for a second and think before doing it. Right now you're predicting the result of a small experiment. If you have an expectation of whether it will pass or not, you will know whether everything is going according to your understanding of the program or not. So, will it pass or not and why? Then run it.

You'll find out it doesn't. Same error again. Ruby still has no idea about the DockingStation class. But why, when we've just defined it in `docking_station.rb`?

Think about it from Ruby's perspective. There are lots and lots of ruby files on your computer, defining hundreds if not thousands of different classes. Should all of them be available in every other Ruby file? Probably not. It's the programmer's responsibility to decide what should be available to Ruby code at what point. In other words, we haven't established any link between `public_bike_access_spec.rb` and `docking_station.rb`. That they are in the same repo or nearby directories matters very little to Ruby. We need to explicitly link them together.

Add a `require` statement to the spec.

```ruby
require 'docking_station'
require 'capybara/rspec'

feature 'member of public accesses bike' do
  scenario 'docking station releases a bike that is not broken' do
    docking_station = DockingStation.new
    bike = docking_station.release_bike
    expect(bike).not_to be_broken
  end
end
```
Requiring a file is almost equivalent to just copy-pasting the contents of `docking_station.rb` at the top of the test from Ruby's perspective. However, since copy-pasting is a really bad idea, we require the file instead.  Note also that `require 'docking_station'` works here because the bike.rb file is in the lib directory.  The Ruby convention is that require will automatically look in a projects lib directory for Ruby files.

Now assuming no style violations and leaving out the RuboCop output we have a new failure.  This might feel like things are getting worse, but a new failure or error message is cause for celebration!  A new error or failure means more information that we can use to work out what is going on.  It might be hard to imagine it, but ultimately you will start to feel joy and excitement when you have a new error or failure:

```sh
member of public accesses bike
  docking station releases a bike that is not broken (FAILED - 1)

Failures:

  1) member of public accesses bike docking station releases a bike that is not broken
     Failure/Error: bike = docking_station.release_bike
     NoMethodError:
       undefined method `release_bike' for #<DockingStation:0x007ff3c306ea28>
     # ./spec/feature/public_bike_access_spec.rb:6:in `block (2 levels) in <top (required)>'

Finished in 0.00046 seconds (files took 0.13175 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/feature/public_bike_access_spec.rb:4 # member of public accesses bike bike is not broken
```

Our example is failing, which means that we can test the DockingStation class but it doesn't have the behaviour our example expects. Take a look at the list of failures in the output. There is only one: _"member of public accesses bike is not broken"_. Where does the message come from? Look at the structure of the example.

```ruby
feature 'member of public accesses bike' do
  scenario 'docking station releases a bike that is not broken' do
    # the test goes here, omitted for brevity
  end
end
```

RSpec simply concatenates 'member of public accesses bike' from the describe statement and the 'docking station releases a bike that is not broken' from the "it" block.  So, what's the failure of the test?

````ruby
Failure/Error: bike = docking_station.release_bike
NoMethodError:
  undefined method `release_bike' for #<DockingStation:0x007ff3c306ea28>
# ./spec/feature/public_bike_access_spec.rb:6:in `block (2 levels) in <top (required)>'
````

First, it shows us the [rspec expectation](https://www.relishapp.com/rspec/rspec-expectations/docs) that failed. Specifically, it tells us that the method `release_bike` is undefined. (#<DockingStation:0x007ff3c306ea28> refers to the instance of the DockingStation class that we have in the "docking_station" variable. The long number is the memory address).

So, the test is almost telling us what to do. We don't have the method `release_bike`, and it's tempting to just go ahead and create one, however we are at the feature test level, and in general we should avoid adjusting the code in our application until we are at the unit test level.

Instead let's use the more rigorous practice of creating a unit test that checks that DockingStations have this method:

```ruby
require 'docking_station'
describe DockingStation do
  it { is_expected.to respond_to :release_bike }
end
```

Notice that we are using the more common RSpec describe/it syntax here.  This code should go in spec/docking_station_spec.rb, and should fail with an error like this:

```sh
1) DockingStation should respond to #release_bike
   Failure/Error: it { is_expected.to respond_to :release_bike }
     expected #<DockingStation:0x007faf7c1a2c68> to respond to :release_bike
   # ./spec/feature/docking_station_spec.rb:3:in `block (2 levels) in <top (required)>'
```

This test is using [RSpec's one-liner syntax](https://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/one-liner-syntax). Notice how it has constructed a label for the test: "DockingStation should respond to #release_bike".  We could just as easily write the test like so:

```ruby
require 'docking_station'
describe DockingStation do
  it 'DockingStation should respond to #release_bike' do
    expect(subject).to respond_to :release_bike
  end
end
```

which uses the RSpec [implicitly defined subject](http://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/implicitly-defined-subject) syntax. The advantage of the one liner syntax is that it DRYs out our code.  This is such a simple test that its descripton is completely predictable.  As a developer you must constantly ensure that your test descriptions match what is tested and that your method names describe what happens when they are called.

Using either the 'implicitly defined subject' or the 'one_liner' syntaxes relies on us describing the DockingStation class directly via 'describe DockingStation', so that we can use the variables 'is_expected' and 'subject' as appropriate.  The variable 'subject' refers to an instance of a DockingStation.  RSpec is helping us out by doing the equivalent of 'subject = DockingStation.new' before the 'it' block runs.  The 'is_expected' variable is the equivalent of 'expect(subject)'.

Note also that the respond_to method is doing one of the least rigorous checks that RSpec can do on a Ruby objects behaviour - it just checks that their is a method of that name available to be called on the object in question. More rigorous checks include actually calling a method, checking the return value from a method, and checking for changes of state after a method has been called.  Choosing the way in which we check an objects behaviour is a critical part of the testing process.  In this case we're choosing the lightest possible check as the absence of the method is what our feature test is complaining about.  We mustn't let our unit tests get ahead of what's needed in order to pass our feature test.

In order to make this current unit-test to pass we need to update the DockingStation class to include this method.

````ruby
class DockingStation
  def release_bike
  end
end
````

Assuming no style isses, our DockingStation unit test will pass, and our acceptance test will move on to a new error: 'Woohoo!'.  More information to help us work out what is going on:

```sh
member of public accesses bike
  bike is not broken (FAILED - 1)

Failures:

  1) member of public accesses bike bike is not broken
     Failure/Error: expect(bike).not_to be_broken
       expected  to respond to `broken?`
     # ./spec/feature/public_bike_access_spec.rb:7:in `block (2 levels) in <top (required)>'

Finished in 0.00217 seconds (files took 0.18509 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/feature/public_bike_access_spec.rb:4 # member of public accesses bike bike is not broken
```

This error is a little more difficult to interpret.  At the moment our `release_bike` method on docking station returns nothing, a `nil` in fact, which gets represented as an empty string in the failure message "expected  to respond to `broken?`".  If we were writing a unit-test of the Docking Station this would be a point that we might want to start using a Bike 'double' (a kind of stunt stand in - see the [doubles pill&nbsp;:pill:](../pills/doubles.md)) to ensure that this test was isolated from the particular implementation of Bike.  However we are writing a feature or integration test that does not want to 'stub out' the behaviour of collaborator classes unless it is to avoid randomness or interaction with 3rd party services (e.g. Twitter, Google and so on).

This is a great point to drop from the acceptance/feature test level to the unit-test level again.  One way to make progress here is to unit-test drive the creation of a Bike class that can respond to a `broken?` method.  Have a think about how that would work before going to [Stage 3](boris_bikes_stage_3.md).

Also, since we've changed the error message again, it's naturally a good time to switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:, following the [change-the-message pairing methodology](../pills/pairing.md#change-the-message-between-programmer-a-and-b).
