
## Version 2: Refactoring

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
