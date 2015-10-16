If you set up your `Oystercard` test file correctly, it should look something like this:

```ruby
# in spec/oystercard_spec.rb
describe Oystercard do
end
```
Try running `rspec` from the command line to load and run the contents of this file. You should get an error.

Errors are good. They tell us what the problem is and point us towards where we can go to fix it. Much of a developer's time is spent reading, researching, and understanding the result of error messages.

In this challenge, you will dissect a Command Line error message.

## Learning Objectives covered
- Use a stack trace to debug an error.

## Interview questions you may expect:
- Explain what a stack trace is.

## To complete this challenge:
- [ ] Write down the type of error in the issue comments
- [ ] Write down the file path where the error happened
- [ ] Write down the line number of the error
- [ ] Use the Ruby Documentation to find out what the error means
- [ ] Suggest one way of solving the error

## Suggested resources:
- [Using the stack trace (video)](https://www.youtube.com/watch?v=TF_-tfOc9Pw)
- [Ruby Docs - Exception (Ruby's name for 'error')](http://ruby-doc.org/core-2.2.0/Exception.html)

## [Solution](solutions/03_debugging.md)
