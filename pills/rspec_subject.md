RSpec "Subject"
===============

RSpec ['subject'](http://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject) is a feature of RSpec that allows you to use the method call 'subject' to refer to a newly instantiated instance of the class under test, e.g. 

```ruby
describe MyObject do

  it 'is of class MyObject' do
    expect(subject).to be_instance_of MyObject
  end

end
```

Some developers will prefer to use let(:myobject) to get more explicit naming of the entity under test although you can also achieve the same effect with alias_method, like so:

```ruby
describe MyObject do
  alias_method :myobject, :subject

  it 'is of class MyObject' do
    expect(myobject).to be_instance_of MyObject
  end

end
```

although at this point you might ask what we are saving over just using `let(:myobject) { MyObject.new }`, however subject is used in other ways by RSpec, and it's good to have a working knowledge of how subject can be used explcitly and implicitly and as part of one liners.  See http://www.relishapp.com/rspec/rspec-core/v/3-2/docs/subject for more details.

Using the subject shows that you know about this feature of RSpec, but it should be used "tastefully" , i.e. your code your be appropriately DRY, but also readable and comprehensible.

Since RSpec goes to the effort of making subject available it's tempted to use it - and there's also https://github.com/nevir/rubocop-rspec which encourages certain practices in RSpec, such as using described_class and other details.

As with most things in programming there are no really hard and fast absolute rules.  Every codebase (like the RSpec one) is evolving and features are being added and the surrounding community is deciding to take them up, or not, as appropriate.  And individual developers will have their pet peeves and pet preferences.  The bottom line is that you need to make your own mind up about what syntax feels DRY and readable and maintainable.

See below for some related RSpec commentaries and style guides although note that many of these are rails specific, and nothing it written in stone - try to get to a point where you can form your own opinion about why it makes sense to do something a particular way, and be able to defend that position coherently :simple_smile:

Bottom line is make sure your code conveys intent clearly to whoever will have to read it later (that includes you)

Related Resources
-----------------

* [Better Specs](http://betterspecs.org/) tries to fill the miss of testing guidelines by collecting most of the best practices developers has been learning the hard way through years of experience.
* [Chelimsky on Subject](http://blog.davidchelimsky.net/blog/2012/05/13/spec-smell-explicit-use-of-subject/)
* https://github.com/reachlocal/rspec-style-guide
* https://robots.thoughtbot.com/lets-not


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/rspec_subject.md)
