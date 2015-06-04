## Stage 2: Creating a Docking Station via Unit Tests

***As with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach these as challenges on which to polish your debugging skills - pull requests always welcome.***

So how did you try to deal with the error we saw at the end of stage 1?  Here it is again:

```sh
$ irb
2.2.2 :001 > station = DockingStation.new
NameError: uninitialized constant DockingStation
	from (irb):1
	from /Users/tansaku/.rvm/rubies/ruby-2.2.2/bin/irb:11:in '<main>'
2.2.2 :002 >
```

Let's look through it piece by piece.  We have information about a single failure.  Ruby helpfully prints out the type of error `NameError` and even tells us the line number and the complete file path where the issue occurred ` .rvm/rubies/ruby-2.2.2/bin/irb:11:`.

In this case, the information that the error ocurred in file `.rvm/rubies/ruby-2.2.2/bin/irb` on line 11 is not particularly useful, because that's just telling us where the irb program encountered the error.  We know that the last line of code we typed into irb was `station = DockingStation.new`, so know the code that's causing the error.  That said the 'stack trace', of which the file path and line number are part of is going to be very important in future when we move out of irb.  More important in this case is the name of the error that occurred: [NameError](http://www.ruby-doc.org/core-2.1.2/NameError.html) and its explanation is `uninitialized constant DockingStation`.

The `uninitialized constant DockingStation` means that Ruby doesn't know what `DockingStation` is.

Stop for a second and think about what could be the reason for this error. The answer may be obvious, but think about the most likely reason Ruby doesn't know about `DockingStation`.

If you guessed that the `uninitialized constant DockingStation` error happened because we never defined what a DockingStation is, you're correct. It was simple in this case but it will be less trivial as we encounter more complex bugs later.

You may be tempted now to jump in and fix the error by writing a DockingStation class in irb, or in a file somewhere.  However, **we have reached the crux of Test Driven Development (TDD).  Before progressing any further, please read the [TDD pill&nbsp;:pill:](../pills/tdd.md).  Discuss the next move with your pair partner - do you have the same idea?**

We know what we need to do in order to start implementing our user story.  We might be tempted to just make a DockingStation class, but if we are following the TDD approach we never write any application code in our editor without writing a test FIRST.  We want to test-drive our code using *unit tests*.  Take a moment to discuss this with your pair partner.  Why do you think this is so important?


This would be a great time to switch Driver/Navigator Roles!&nbsp;:twisted_rightwards_arrows:  Let your partner start typing now.  One of you has started an initial play in IRB, and got the first error.  Errors are a great time to switch roles so you can work to the ['change-the-message' pairing protocol](../pills/pairing.md#change-the-message-between-programmer-a-and-b).

We have identified that we need a DockingStation class.  But before we create one, we want a **failing unit test**.  We'll be using RSpec, a handy testing tool in Ruby, but there are many other testing tools such as MiniTest and Cucumber to name a couple of popular alternatives.  RSpec provides a syntax that, while pure Ruby, reads very like English.

Create the following code in `spec/docking_station_spec.rb`.  Again, whatever you do, **DO NOT** copy and paste this code, you must type it out yourself (not the comments).  It is essential that you type the code out yourself or you will not learn effectively:

```ruby
describe DockingStation do

end
```

Your project layout should now look like this:

```sh
$ tree
.
└── spec
    ├── docking_station_spec.rb
    └── spec_helper.rb
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

Hopefully, you were able to recognize that this does not look like an RSpec failure.  This is a Ruby error.  What is the difference?  Why are we getting a Ruby error here, rather than a normal RSpec failure?

**It is absolutely critical to understand the difference.**  You will spend a large amount of your time as a developer *debugging* code.  The primary skill in debugging is to read and understand error messages and test failures.  Please spend some more time discussing with your pair partner why these two tests behave differently.  You may need to ask an [Alumni Helper](https://github.com/makersacademy/course/blob/master/toc.md#resources) or coach to explain as it is not necessarily immediately obvious.  Please do not progress until you have understood this distinction.

Now, let's define the DockingStation class. Create `lib/docking_station.rb` and define an empty DockingStation class.

```ruby
class DockingStation

end
```

Why did we put this in a `lib` folder?  Why did we call it `docking_station.rb`?  Take a moment to discuss this with your pair partner, while ensuring your project layout looks like the following:

```sh
$ tree
.
├── lib
│   └── docking_station.rb
└── spec
    ├── docking_station_spec.rb
    └── spec_helper.rb
```

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

RSpec should now pass, so let's go back and check that this will work in IRB. You will need to restart IRB each time and re-type out the code in order to pick up the changes we make to Ruby files in our lib directory.  Going forward we'll also have to require our docking_station.rb file in IRB, just as we do in our unit test:

```sh
$ irb
2.2.2 :001 > require './lib/docking_station'
 => true
2.2.2 :002 > station = DockingStation.new
 => #<DockingStation:0x007fdac915c8f8>
```

Notice the difference in the require statement.  In IRB we had to specify the path to the location of the docking_station.rb file.  We don't have to do that in RSpec as RSpec automatically adjusts things so that Ruby will look in the lib directory for any files it tries to require. BTW, if you get really tired of typing require for files in your lib directory at the start of every IRB session, check out the pro-tip in the [IRB pill :pill:](../pills/irb.md#advanced-irb).

Now that the first part of our user story is working, and showing us a representation of our newly created DockingStation object ('0x007fdac915c8f8' refers to the position of the object in the computer memory, and can safely be ignored), we can continue with the next elements of our user story like so:

```sh
$ irb
2.2.2 :001 > require './lib/docking_station'
 => true
2.2.2 :002 > station = DockingStation.new
 => #<DockingStation:0x007fdac915c8f8>
2.2.2 :003 > bike = station.release_bike
 NoMethodError: undefined method `release_bike' for #<DockingStation:0x007fc1d4866828>
 	from (irb):3
 	from /Users/tansaku/.rvm/rubies/ruby-2.2.2/bin/irb:11:in `<main>'
```

We have a new Ruby error! It might feel like things are getting worse, but a new failure or error message is cause for celebration!  A new error or failure means more information that we can use to work out what is going on.  It might be hard to imagine it, but ultimately you will start to feel joy and excitement when you have a new error or failure.

Compare this failure with the failure we started with at the beginning of the stage.  Is it the same?  If not, why is it different?  Take some time to discuss this with your pair partner.  What will you do next?

Our user story still isn\'t working, which means that although we can now test the DockingStation class, it does not have the behaviour we want.  Let\'s look through the error carefully to work out what Ruby is telling us. Specifically, it tells us that the method `release_bike` is undefined. (``#<DockingStation:0x007fc1d4866828>`` refers to the instance of the DockingStation class that we have in the `docking_station` variable.).

So, the error is almost telling us what to do. We don\'t have the method `release_bike`, and it\'s tempting to just go ahead and create one, however we want to test-drive our code by *unit tests* right?

Let\'s create a unit test for `release_bike` in `spec/docking_station_spec.rb`:

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

... which uses the RSpec [implicitly defined subject](http://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject/implicitly-defined-subject) syntax. The advantage of the one-liner syntax is that RSpec can infer the description from the syntax - so an additional description is unnecessary and just adds clutter.  As a developer you must constantly strive for readability and ensure that test descriptions correspond exactly with what is being tested.

Before you run `$ rspec`, discuss with your pair partner what outcome you expect.


```
$ rspec

DockingStation
  should respond to #release_bike (FAILED - 1)

Failures:

  1) DockingStation should respond to #release_bike
     Failure/Error: it { is_expected.to respond_to :release_bike }
       expected #<DockingStation:0x007fb9c18a1d08> to respond to :release_bike
     # ./spec/docking_station_spec.rb:4:in `block (2 levels) in <top (required)>'

Finished in 0.00106 seconds (files took 0.07215 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/docking_station_spec.rb:4 # DockingStation should respond to #release_bike
```

Notice how our unit test is stuck on exactly the same point as we were in IRB (the absence of the 'release_bike' method). This is good.  It is telling us that if we can make the unit test pass, that it should help us with our user story.  We\'re breaking down the larger problem of implementing the whole feature into little slices.

Let\'s pass this unit test by updating the DockingStation class:

```ruby
class DockingStation
  def release_bike

  end
end
```

Now our DockingStation unit test should pass, and we should be able to continue our user story in IRB and get a new failure.  This is progress worth celebrating!  Woohoo!

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

To fix this issue, we need more unit tests.  Also, since we've changed the error message, it's naturally a good time to switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:, following the [change-the-message pairing methodology](../pills/pairing.md#change-the-message-between-programmer-a-and-b).

Before progressing to [Stage 3](boris_bikes_stage_3.md), discuss with your pair partner what you need to test next.  What needs to respond to `working?`?
