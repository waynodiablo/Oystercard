BDD vs TDD
==========

It's conceivable that someone might ask you if you had to choose between BDD and TDD which would you choose?

You might want to ask that someone to reframe that question since the thing is that BDD is TDD, so you can't do BDD without doing TDD, so arguably there's not really the option to choose BDD over TDD, since if you choose BDD, you are de facto, also choosing TDD.

You might think there is a direct mapping from TDD to unit tests and BDD to acceptance tests, so you might answer that you would choose TDD over BDD, because TDD (implying unit tests) will cover lots of corner cases that you can't check yourself, while BDD (implying acceptance tests) will check things that you can more realistically check yourself via manual tests

However arguably the logic here is slightly flawed in that BDD implies that you have a combination of acceptance tests AND unit tests - so you if you're choosing BDD it's not that you're rejecting unit tests; so the choice is less clear.

A more interesting and sensible question might be if you had to throw out either your unit tests of your acceptance tests on a project, which would you prefer to get rid of?

Now that's an interesting question - and some people might say they would be loathe to throw out their acceptance tests, since those are the documentation of what the system does that actually provides value to the customer.  Also in a system of any scale checking the equivalent of the acceptance tests would be extremely time consuming - perhaps not more time consuming than manually checking all the unit tests, but pretty damn arduous, and something that would have to be done to ensure that value is still being delivered to the customer after any change or feature addition.

Now the argument for keeping the unit tests is that in combination they will cover many cases that the customer might want, but haven't necessarily anticipated, or are just intractable to describe in terms of the higher level unit tests. To that extent one might well want to keep the unit tests if the kind of system being built was safety critical, e.g. an x-ray scanner, power-plant coordination software or similar.

However, if the software being built is to demo some system in a startup to get more funding, then the argument for extensive unit tests is less persuasive - in a banking or finance system perhaps it would be more persuasive; but then again it all depends on the costs associated with failure, and the costs of doing manual tests, which are of course different from system to system.

The bottom line is that we need both acceptance tests and unit tests - and no one should try and develop any system of any importance of scale without using both, and of course ideally one will have a balanced testing pyramid with both few acceptance tests, a medium number of intermediate (or integration tests) and a largish number of fast running unit tests.

And ultimately if you have acceptance tests and unit tests then by definition you are doing BDD!
