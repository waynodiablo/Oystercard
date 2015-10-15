In the current issue, we are being asked to build functionality to track the movements of an Oystercard user.

- [ ] Write tests for `touch_in`, `touch_out` and `in_use?` methods
- [ ] Write implementation of these methods that will make the tests pass
- [ ] Use an RSpec predicate matcher to check if the card is in use

These methods all share a common feature - they are responsible for tracking when the oyster card is being used. Make this first test pass by defining a touch_in method, then let's think about adding some functionality. We want `touch_in` to change an internal status `in_use` from false to true. Our first test could look something like this:

```ruby
it 'is initially not in use' do
  expect(subject).not_to be_in_use
end
```

When we run this test we should see the following error:
```
Failures:

  1) Oystercard tracking usage is initially not in use
     Failure/Error: expect(subject).not_to be_in_use
       expected `#<Oystercard:0x007f9431a830a0 @balance=0>.in_use?` to return false, got true
     # ./spec/oystercard_spec.rb:7:in `block (3 levels) in <top (required)>'

```
Let's make this pass, remembering to only write the minimum amount of code to change the message.
```ruby
def in_use?
  false 
end
```
Now we need to think about the functionality of our 'touch_in' method. We want this method to mark the card as being in use, so that should form the basis of our expectation:

```ruby
it "can touch in" do
  loaded_card.touch_in(angel)
  expect(loaded_card).to be_in_use
end
```
- [ ] Use an instance variable to track whether the card is in use
- [ ] Use boolean values to store the state of the card


