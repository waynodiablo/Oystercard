# Passing your first Unit Test

Your spec file should now look like this:

```ruby
# In spec/docking_station_spec.rb
describe DockingStation do

end
```
When you ran RSpec, you should have gotten an error like this:

```
/Users/username/source/makers_academy/boris-bikes/spec/docking_station_spec.rb:1:in `<top (required)>': uninitialized constant DockingStation (NameError)
  from /Users/username/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1226:in `load'
  from /Users/username/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1226:in `block in load_spec_files'
  ...
```

This is an error from the testing framework RSpec. It says that it doesn't know what `DockingStation` is.

In this challenge, you will create a `DockingStation` class and include it in the spec file you created.

### Learning Objectives covered
- Pass a unit test
- Use `require`

### Self-assessment

To complete this challenge, you will need to:

- [ ] Create a new file for a Docking Station class, inside the `/lib` directory
- [ ] Define a `DockingStation` class
- [ ] Use `require` to include this file inside your spec file
- [ ] Run RSpec from the Command Line
- [ ] Explain to your pair partner the difference between what you see, and the error you saw before.

### Resources
- [Ruby in 20 minutes](https://www.ruby-lang.org/en/documentation/quickstart/)
- [Including files in Ruby](http://rubylearning.com/satishtalim/including_other_files_in_ruby.html)

### [Solution](solutions/6.md)