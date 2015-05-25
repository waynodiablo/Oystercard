BDD vs TDD
==========

It's conceivable that someone might ask you if you had to choose between BDD and TDD which would you choose?

I think the interesting thing is that BDD is TDD, so you can't do BDD without doing TDD, so I'd say there's not really the option to choose BDD over TDD, since if you choose BDD, you are de facto, also choosing TDD

the other thing that I believe you said was that you might choose TDD over BDD, because TDD (implying unit tests) will cover lots of corner cases that you can't check yourself, while BDD (implying acceptance tests) will check things that you can more realistically check yourself via manual tests


However I think the logic there is slightly flawed in that BDD implies that you have a combination of acceptance tests AND unit tests - so you if you're choosing BDD it's not that you're rejecting unit tests

a more interesting and sensible question might be if you had to throw out your unit tests of your acceptance tests, which would you prefer to get rid of

now that's an interesting question - and the thing is that I'd be loathe to throw out my acceptance tests, since those are the documentation of what the system does that actually provides value to the customer

and in a system of any scale checking the equivalent of the acceptance tests would be extremely time consuming - perhaps not more time consuming than manually checking all the unit tests, but pretty damn arduous, and something that would have to be done to ensure that value is still being delivered to the customer after any change or feature addition

now the argument for keeping the unit tests is that in combination they will cover many cases that the customer might want, but haven't necessarily anticipated, or are just intractable to describe in terms of the higher level unit tests

to that extent one might well want to keep the unit tests if the kind of system being built was safety critical, e.g. an x-ray scanner, power-plant coordination software

however, if the software being built is to demo some system in a startup to get more funding, then the argument for extensive unit tests is less persuasive - in a banking or finance system perhaps more so, but then again it all depends on the failure costs, and the costs of doing manual tests, which are of course different from system to system

bottom line is that we need both acceptance tests and unit tests - and no one should try and develop any system without using both, and of course having a balanced testing pyramid with both few acceptance tests, a medium number of intermediate (or integration tests) and a largish number of fast running unit tests

and ultimately if you have acceptance tests and unit tests then by definition I would say that you are doing BDD 
