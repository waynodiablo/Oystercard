This challenge is aimed at helping us practice testing exceptions in RSpec.

- [ ] Write a failing test for the `deduct` method that expects an exception to be raised

Let's start by thinking about the method we want to test. We already have tests for the #deduct method, we just want to add some functionality to it. The current issue is asking us to raise an exception for the event that a deduction takes the card balance below zero. As that is our desired outcome, that should form the `expect` part of our test:

``` ruby
it "can't deduct if the balance goes below zero" do
  expect{ subject.deduct(1) }.to raise_error "You don't have enough"
end
```

- [ ] Update the method to make the test pass

Run RSpec to watch the test fail, and then amend the #deduct method so that it raises the required error.

``` ruby
def deduct(amount)
  fail 'You cannot go into debt' if balance - amount < 0
  @balance -= amount
end
```
Once you have watched the tests go green, have a think about ways to refactor.
