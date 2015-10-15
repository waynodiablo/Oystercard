This challenge adds some simple interaction between internal instance methods.
- [ ] Write a test that uses `expect {}.to change{}.by()` syntax to check that a charge is made on touch out.

```ruby
subject.touch_in
expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
```
- [ ] Update the `touch_out` method to make the test pass

Let's make use of our deduct method to charge the card with the minimum charge.

```ruby
def touch_in
  deduct(MINIMUM_CHARGE)
  @in_journey = true
end
```

Now we are back in the green phase (don't forget to high five!), let's see about refactoring our code.

- [ ] Make '#deduct' a private method

Now we are using out touch_out method to deduct from the balance, we are actually testing our deduct method implicitly whilst testing touch_in. Our deduct method is not needed by any other object, so let's move it into private. This helps to keep functionality encapsulated and prevents excessive dependencies from being created in the future.

- [ ] Keep the code DRY

Have a check through your code for any further repetition you can refactor away.
