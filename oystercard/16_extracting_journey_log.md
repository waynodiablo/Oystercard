So that was fun - we now have a simple station class that can hold information about a stations zone, and a journey class holding the state of each individual journey. We also saw how to extract 1 class into 2 classes, using our tests as a scaffold. Now let's have another look at our Oystercard class and make some improvements. Currently our Oystercard has two responsibilities: maintaining a balance through touch in/out and recording a journey history. We should be following Single Responsibility Principle, so we still have some refactoring to do.

Let's extract a JourneyLog class. It should be responsible for starting a journey, ending a journey and returning a list of journeys.

## Learning Objectives covered
- [ ] define the Standard Ruby Library
- [ ] explain delegation and why it is useful

## Interview questions you may expect:
- [ ] Why might you choose a Standard Library over an external gem?
- [ ] describe some common uses for delegating functionality from one object to another.

## To complete this challenge:
- [ ] test drive the development of JourneyLog class
- [ ] use dependency injection to inject a journey_klass
- [ ] `#start_journey` should start a new journey with an entry station
- [ ] a private method `#current_journey` should return an incomplete journey or create a new journey
- [ ] `#exit_journey` should add a new exit station to the `current_journey`
- [ ] `#journeys` should return a list of all previous journeys without exposing the internal array to external modification
- [ ] refactor to using Forwardable module from Standard Library to delegate the method `#exit_journey` to the `current_journey`'s `#exit` method.
- [ ] remove redundant code from OysterCard class

## Suggested resources:
- [Leveraging Ruby's Standard Library (extract from 'Ruby Best Practices')](http://archive.oreilly.com/pub/a/ruby/excerpts/ruby-best-practices/ruby-standard-library.html)
- [Forwardable module documentation](http://ruby-doc.org/stdlib-2.0.0/libdoc/forwardable/rdoc/Forwardable.html)
