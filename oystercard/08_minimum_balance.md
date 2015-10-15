You can now use the card to pay for a journey by deducting money from it. However, the the card is essentially bottomless: there's no check to see if the card has enough funds to pay. If you try to pay with it, it will gladly go into negative balance.

Update the `deduct` method to only allow it to deduct the money if enough funds are available. Like always, test-drive it by writing a failing test first and then implementing the functionality to make it pass.

## Learning Objectives covered
- Use an inline `if` statement
- Raise errors
- Check that a statement raises an error with RSpec

## Interview questions you may expect:
- What are exceptions in Ruby? Why do they have messages associated with them?
- How can you check an expression raises an error with RSpec? Why do you have to pass the code as a block to do this?

## To complete this challenge:
- [ ] Write up a plan for how you will interact with your code and manually test in IRB.
- [ ] Write a failing test for the `deduct` method that expects an exception to be raised
- [ ] Update the method to make the test pass

## Suggested resources:
- [Handling and Raising exceptions](https://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/41-exceptions/lessons/92-handling)
- [raise_error matcher](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/raise-error-matcher)
- [expect vs expect with a block on SO](http://stackoverflow.com/questions/19960831/rspec-expect-vs-expect-with-block-whats-the-difference)
