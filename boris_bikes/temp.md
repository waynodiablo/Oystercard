
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
