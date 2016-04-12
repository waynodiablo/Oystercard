# How to debug any problem stress-free

So you're stuck on a problem. Something in your code doesn't work, and you can't for the life of you work out what it is or how to fix it. Don't worry, we've been there thousands of times before - after all, debugging is a core part of being a Web Developer. Fortunately we've discovered a systematic process which when followed step-by-step can pretty much guarantee you'll track down a bug in no time at all - it can even be enjoyable!

## The steps

The steps are:

1. Take a break
1. Describe what you think the problem is to your pair
1. Identify your assumptions
1. Run some tests using the scientific method
1. Repeat until it's fixed

## 1 - Take a Break

Normally we only consider that we're even debugging, as opposed to regular programming, when we've been stuck on something for a while and we can't fix it. As soon as you've become aware that you have a difficult bug and you're stuck the most important thing you can do is take a break at that point. There's been many times when we've been stuck for a long time on something and reluctantly taken a break, only to come back five minutes later and instantly see the solution to the problem.

## 2 - Describe what you think the problem is to your pair

Unless you're doing a weekend challenge or tech test, you'll be aware that we advise you always pair, and debugging is one of those times when having another set of eyes on a problem is a godsend. Just by one of you talking through the problem to the other you will often find the problem you're struggling on becomes so much clearer.

If you don't have a pair (or you can't pair as it is a tech test) doing some [rubber duck pairing](http://blog.codinghorror.com/rubber-duck-problem-solving/) as ridiculous as it sounds, our plastic ducks have solved more than their fair share of bugs in our codebase!

![Rubber Duck](https://hattonsimages.blob.core.windows.net/products/RubberDuck_3170853_Qty1_1.jpg)

So let's say at this point you turn to your pair and describe the problem as "whenever I try and save my user to the database in Rails, no error is thrown but the user does not get saved into the database"

## 3 - Identify your assumptions

Now you need to look at what assumptions are behind the problem you've mentioned
to your pair. In this case we could list our assumptions as:

* The data is being passed correctly through to the user model
* The method used to save the user model to the DB is working
* The data is not reaching the DB
* An error should be thrown when the user is saved.

## 4 - Test using the scientific method

Once you've identified your assumptions, you need to test them. Although sometimes it's tempting to do
this in an ad hoc fashion, your best chance of success is to use the scientific
method, a time-honoured way of quickly testing our assumptions:

* **Hypothesis** - from you assumptions, take the one that is most likely to be
  incorrect (or just choose any), then make a hypothesis, such as _the data is
being passed incorrectly into the user model_
* **Analysis** - you'll need to break your task down into something smaller, the
  key here being to hone down and isolate only the part of our application that
we need to test our assumption against e.g. isolating a specific
line indicated in our stack trace, or testing our user model in the Rails console
* **Experimentation** - now run a series of experiments on the isolated part of
  our application. This is often as simple as saying "what would happen if I
perform a certain action?". Go slowly here and only change one thing at a time,
and observe the result
* **Conclusion** - once you've finished experimenting, reflect on whether it has
  fixed the problem. At first it's likely that it may no, but ideally it will
have provided you with more information and allowed you to at least be more
certain about your assumptions

Note when experimenting and analysing, in the same way that scientists use
tools such as microscopes to help them run their experiments, as programmers we
need to rely on tools to gather data to test our hypothesis. These can be
everything from using sophisticated debuggers such as [byebug](https://github.com/deivid-rodriguez/byebug) in Ruby or the [debugger statement](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/debugger) in JavaScript,
to the simply using `puts` or `console.log` to check what your data is
outputting in various stages of your code.

> Generally the simpler the tool the better, start with `p`/`puts` and `console.log`
and move to more advanced tools if/when you need to. And don't forget sometimes fixing a bug is as simple as putting a series of of `p` statements throughout your system, following the data as it flows through the system

## 5 - Repeat until it's fixed

Once you've reached some conclusions based on your tests, if you still haven't
fixed the problem then you'll need to run the steps again.

That means taking another break (frequent breaks are really
important when debugging even if it's just for a minute), restating the problem
to your pair based on what you've learnt from the previous experiment,
re-checking your assumptions and then picking a new assumption to test.
Eventually if you continually do this systematically you'll be guaranteed to
eventually get to the cause of your bug!

## Further tips

* It doesn't matter what debugging tools you are using, but you should *always* be using
some sort of tool - if you're using nothing you're going to have a really hard
time conducting your experiments and fixing the bug.
* When experimenting run lots of little tests (often this is simply putting a
  load of `puts` statements in your code), generally the sign of an
  experienced debugger is someone who uses a large number of tests like this to
analyse/experiment on the problem
* Keep things simple, changing too much at once is likely to introduce further
  bugs
* Make sure you're checking the against the actual data your system is receiving
  when running tests

## Some further reading:

   * [The StackOverflow founder on Rubber Duck Debugging](http://blog.codinghorror.com/rubber-duck-problem-solving/)
   * [Zen of debugging](http://webadvent.org/2012/debugging-zen-by-ben-ramsey)
   * [The psychology of debugging](https://docs.google.com/file/d/13hFUiT8lD1FiaRkwrM5AOdbT2xSVZF8eg0JXdcqU4mZSAzXkwonp1M-TFqR8/edit)
