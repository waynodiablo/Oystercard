Doubles, Mocks, Stubs and Spies
=======

What makes a good test?

Well, if we want to get scientific about it (and we do), then it's ensuring that a test has _only one variable_.

You can write beautifully worded tests (and you should), with exquisitely succinct code (and you should), but how can you be absolutely sure that your beautifully succinct tests are not passing by mistake?  Or failing by accident?

Enter doubles, mocks stubs and spies.

The first piece of good news is that these are not four new concepts, but four flavours of essentially the same idea.

The second piece of good news is that testing with doubles, mocks, stubs and spies doesn't just improve your tests, it can improve your design also.

But let's get back to our objective: ensuring a test has _only one_ variable.  What does that mean?

In OOD, we have lots of objects interacting with one another.  One object sends a message to another object and maybe that object responds with an answer.  Or maybe it changes some internal state.  Or maybe it interacts with a third object, or calls some expensive external service, or generates a random result, or...

Sometimes these interactions are predictable.  Sometimes they are not.  But either way, if I am testing `ObjectA`, then I don't want my test to be arbitrarily dependent on the behaviour of `ObjectB`.  Particularly if `ObjectB` is expensive or complex to instantiate.

So how do I remove the arbitrary dependencies on `ObjectB`?  Here are some examples:

### Doubles
Instead of testing `ObjectA` against an instance of `ObjectB`, I use a stand in (a stuntman if you like) for `ObjectB` instead.  `ObjectA` doesn't know the difference, it simply treats the double as if were an instance of `ObjectB`, but it's not - it's a dummy that I've set up with static (and therefore _not variable_) values.

### Stubs
I want to test some behaviour of `ObjectA`, but during the execution of that behaviour, `ObjectA` calls a method on `ObjectB`.  I don't need to test that the method on `ObjectB` gets called, but I do want to make sure that when it does, the method on `ObjectB` always returns a specific value.

### Mocks
I want to test some behaviour of `ObjectA` and, critically, during the execution of that behaviour, `ObjectA` must call a method on `ObjectB` with specific arguments.  In my test, I don't particularly care what happens afterwards, but I want to test that in the code that _is about to be executed_ the specific method _is_ called with the correct arguments.

### Spies
I want to test some behaviour of `ObjectA` and, critially, during the execution of that behaviour, `ObjectA` must call a method on `ObjectB` with specific arguments  (sound familiar?).  In my test, I don't particularly care what else happened during the test, just that in the code that _was just executed_ the specific method _was_ called with the correct arguments.

### Summary
Actually, I may have misled you a bit there.  Many of these terms are interchangable depending on the testing framework and mocks and doubles are pretty much the same thing; it's the concepts that are important.

So, can these techniques really improve your design also?

Absolutely.  And here's why:

* Good code is always easy to test.
* Bad code is sometimes easy to test.
* Hard-to-test code is never any good.

So, by making your code easy to test using doubles, mocks, stubs and spies; the better it's likely to be.

Resources
---------

* https://relishapp.com/rspec/rspec-mocks/docs
