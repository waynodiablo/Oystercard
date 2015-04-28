# Boris Bikes intro
```
As a member of the public,
So that I am not frustrated trying to find a bike,
I'd like to know if a docking station has working bikes available.

As a member of the public,
So that I am not frustrated trying to return a bike,
I'd like to know if a docking station has reached capacity and cannot receive any more bikes.
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


Notice that this code still doesn't check that the Bike is initially not broken.  This corresponds to a more rigorous test, actually checking what the method returns.  We can do that with the following [predicate](https://www.relishapp.com/rspec/rspec-expectations/
docs/built-in-matchers/predicate-matchers) syntax:

````ruby
require 'bike'
describe Bike do
  it { is_expected.to respond_to :broken? }
  context 'when created' do
    it { is_expected.not_to be_broken}
  end
end
````


However interestingly even though this is a more rigorous test it will just pass as is.  Can you work out why?

Notice also that our first it statement is redundant.  Since we call the method 'broken?' in the second 'it' statement DockingStation is implicitly checked for responding to 'broken?'.  Arguably we could delete the first 'it' statement with no loss.  Let's do that.  It's good habit to get into; deleting code that is not doing anything for you.


# Boris Bikes Stage 4

Here is the corresponding test:

```ruby
it 'releases bikes that are not broken' do
  bike = subject.release_bike
  expect(bike).not_to be_broken
end
```

The initial bike in a DockingStation is nil.  We might be tempted to try and dock a symbol :bike as we do with the 'can dock a bike' test, however in this case we need something that will respond to the broken? method.  But this is a DockingStation unit test, we can't use Bike ... so let's use a double:

```ruby
it 'releases bikes that are not broken' do
  subject.dock double :bike, broken?: false
  bike = subject.release_bike
  expect(bike).not_to be_broken
end
```

Here we've created a mock object that will always respond to the 'broken?' method with a false return value.  It's a bit of a self fulfilling test in that we pass in something that is not broken and check that what we get back is not broken.  Either way it's testing the DockingStation completely independently of Bike. Now we just have to throw an error when we try to release a bike and none is present.

To do that we'll have to at least partially back out of the 'alias_method' fix like so:

```ruby
class DockingStation
  attr_writer :bike
  alias_method :dock, :bike=

  def release_bike
    fail 'No bikes available' unless @bike
    @bike
  end
end
```
