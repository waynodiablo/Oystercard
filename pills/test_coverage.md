Test Coverage
============

Test coverage is an automated metric that indicates the degree to which your code is being exercised by your tests.  For example, say that we have a short class like so:

```ruby
class Foo
  def bar
    'bar'
  end
  def foo
    'foo'
  end
end
```
and we had a test like so

```ruby
describe Foo do
  it 'should bar' do
    expect(Foo.bar).to eq 'bar'
  end
end
```

A simple test coverage metric could be the number of lines in the application code that are exercised by the test code.  There are 8 lines of code in the Foo class, and we run all but 3 of them from the test so we have 5/8 or 62.5% test coverage.

Exercise
-------
* how could we change the test to increase test coverage to 100%?

Almost Meaningless Test Coverage
-----

The main problem with test coverage as an indicator of code quality is that we could get 100% coverage without any expectations, e.g.

```ruby
describe Foo do
  it 'should bar' do
    Foo.bar
  end
  it 'should foo' do
    Foo.foo
  end
end
```

This gets a 100% simple coverage because every line in the class Foo will be executed at least once when the test suite runs.  This is not totally meaningless in that it does at least check that the methods foo and bar exist, but nothing about what they do or what they return.  From a test coverage point of view the above test gives just as much coverage as the following higher quality test:

```ruby
describe Foo do
  it 'should bar' do
    expect(Foo.bar).to eq 'bar'
  end
  it 'should foo' do
    expect(Foo.foo).to eq 'foo'
  end
end
```


So, as with other kinds of "automated" code quality metrics it is important not to rely on test coverage too heavily.  Getting a 100% (or 80% or 90%) test coverage indicator does not tell you anything about the quality of the tests that are doing the coverage.  

At best, test coverage metrics are good indicators of places in your code that are poorly covered by tests, and as such it's probably a good idea to consider why that area is untested.  It would be a serious mistake to obsess about achieving a particular coverage level.  See [Martin Fowler's blog on Test Coverage](http://martinfowler.com/bliki/TestCoverage.html) for a very sensible discussion on how to make use of test coverage to improve your code.

There are actually lots of different kinds of test coverage methods, but it's as yet unclear if there is a strong reason to use the more rigorous kind that check whether every boolean subexpression in an if statement have been evaluated to every possible outcome.  In mission critical systems that control aircraft and power stations, yes; in your MVP to get feedback from potential customers, almost certainly not.

Testing MVC (Model View Controller)
--------

As well as test coverage in terms of lines of code executed, there are also different kinds of tests.  You should know about the testing pyramid consisting of many unit tests, fewer integration tests and a small number of GUI level acceptance tests. In addition there are different kinds of tests that get associated with MVC systems.  The Obvious three are

* Model specs
* View specs
* Controller specs

Where we use the term 'specs' synonymously with 'tests'.  One can have separate tests or specs for each of the three components of an MVC system.  All of these can be considered forms of unit tests if they are properly isolated from each other, however all of them can become integration tests depending on the level of mocking and stubbing.  Many professional developers avoid view specs based on the idea that high level GUI acceptance tests will check the views and make view specs an unnecessary replication of tests.  That said, they can be very useful for isolating certain corner cases; but again if you have a complex corner case in your view, that's probably an indication that that code complexity needs to be pulled out into a model or a helper or anywhere that's not the view.  The same can be said for controllers.  Many developers prefer to have very 'skinny' views and controllers, i.e. controllers and views that have the absolute minimum code complexity; handing off all but essential work to models, services, helpers and so on.

In complex MVC systems like Rails there are various other type of specs such as

* Helper specs
* Service specs
* Migration specs
* Routing specs
* Request specs
* Frontend JavaScript specs

Without going into too much detail here, there are a lot of different types of tests that can be employed in complex MVC systems.  The critical balance to achieve is that of the testing pyramid, relatively many simple isolated unit tests, fewer integration tests and a small number of high level feature (GUI/Acceptance) tests.  Assuming that balance there is another balance over the different types of component tests.  In the first instance just make sure that your controllers and views are as simple as they possibly can be, and let the acceptance tests do the work of checking them, while your unit and integration tests deal with any code complexity in your models.

Testing is a powerful weapon, but it is also very easy to have an explosion of complexity in your tests, which will sink your project just as fast as jumps in complexity in your application code.  Use testing carefully and never hesitate to step back and ask if you are using the right kinds of tests for the job.

Resources
-------

* [SimpleCov Test Coverage Tool for Ruby](https://github.com/colszowka/simplecov)
* [Coveralls (Continuous Integration Testing Support)](https://coveralls.io)
* [Martin Fowler on Test Coverage](http://martinfowler.com/bliki/TestCoverage.html)
* [Wikipedia on Code Coverage](http://en.wikipedia.org/wiki/Code_coverage)
