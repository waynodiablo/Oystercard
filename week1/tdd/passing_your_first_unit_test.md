# Passing your first Unit Test

[Back to the Challenge Map](./_challenge_map.md)

Your test file should now look like this:

```ruby
# In tests/docking_station_test.rb
puts 'A DockingStation'

docking_station = DockingStation.new

p docking_station
```

When you ran the file, you should have gotten an error like this:
```
A DockingStation
Traceback (most recent call last):
tests/docking_station_test.rb:3:in `<main>': uninitialized constant DockingStation (NameError)
```
You can see that the first line of our test file outputted 'A DockingStation and then an error was raised on line 3'. It says that it doesn't know what `DockingStation` is. Now we can implement it according to our **rule of thumb:**

**Rule of thumb:** Don't write new application code until you have a failing feature test and one of its failing unit tests. And then only write the smallest easiest thing to get only that test to pass.

In this challenge, you will implement a `DockingStation` class and make it available in the test you created.

### Learning Objectives covered
- Pass a unit test
- Use `require`

### To complete this challenge, you will need to:

- [ ] Create a new file for a Docking Station class, inside a `/lib` directory (Why 'lib'?)
- [ ] Define a `DockingStation` class
- [ ] Use `require` to include this file inside your test file
- [ ] Run the test file
- [ ] Explain to your pair partner the difference between what you see, and the error you saw before.
- [ ] Discuss with your partner what exactly you are seeing.

### Resources
- [Ruby in 20 minutes](https://www.ruby-lang.org/en/documentation/quickstart/)
- [Including files in Ruby](http://rubylearning.com/satishtalim/including_other_files_in_ruby.html)
- [Object#to_s](https://ruby-doc.org/core-2.5.0/Object.html#method-i-to_s)

## [back](./from_feature_tests_to_unit_tests.md) | [next](./back_to_the_feature.md)
