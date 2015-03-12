##Stage 4: Refactoring to remove a Design Smell




### Making the broken? method work properly

You may feel suspicious that our unit test passes while we don't have much code just yet. You're right, we're missing something. We're missing more examples! Let's write another one to enable the bike to be broken. After all, if the bike has both states, fixed and broken, it's fair to assume we'll need a method to break a bike as well.

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

**Now all our examples pass, a perfect time to commit our changes. Since our repository is not empty anymore, push it to Github (:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)), and this can also be a good time switch Driver/Navigator Roles again&nbsp;:twisted_rightwards_arrows: if someones been driving for too long.
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
