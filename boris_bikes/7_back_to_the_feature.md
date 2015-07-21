# Back to the feature

[Back to the Challenge Map](0_challenge_map.md)

Now we have passed a unit test, we go back to our feature tests. You have now implemented a `DockingStation` class, so you should be able to get further than last time.

In this challenge, you will get further in your feature test, and dissect an error.

### Challenge setup

Here are the User Stories you converted into a Domain Model:

```
As a person,
So that I can use a bike,
I'd like to get a bike from a docking station.

As a person,
So that I can use a good bike,
I'd like to see if a bike works
```

Here is a functional representation of those stories:

Objects  | Messages
------------- | -------------
Person  | 
Bike  | works?
DockingStation | release_bike

Here is the `DockingStation` class you should have written:

```ruby
# in lib/docking_station.rb
class DockingStation

end
```

### Learning Objectives covered

- Move between Feature and Unit Tests

### To complete this challenge, you will need to:

- [ ] Start `irb` (or any other REPL) from the Command Line
- [ ] Use `require` to include the file that contains the `DockingStation` class definition
- [ ] Set a variable `docking_station` equal to a new `DockingStation` object
- [ ] Explain to your pair partner why you do not see an error now, when you did before
- [ ] Ask the `docking_station` instance to `release_bike`
- [ ] Explain to your pair partner what the resulting error means.

### Resources
- [Including files in Ruby](http://rubylearning.com/satishtalim/including_other_files_in_ruby.html)
- [Feature Testing in IRB (video)](https://www.youtube.com/watch?v=rShBRLyEccY)
- [Ruby Docs - Exception](http://ruby-doc.org/core-2.2.0/Exception.html)


### [Solution](solutions/7.md)