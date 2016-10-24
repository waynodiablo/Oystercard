# How to debug any problem stress-free

So you're stuck on a problem. Something in your code doesn't work, and you can't for the life of you work out what it is or how to fix it. Don't worry, we've been there thousands of times before - after all, debugging is a core part of being a Web Developer. Fortunately we've discovered a systematic process which when followed step-by-step can pretty much guarantee you'll track down a bug in no time at all - it can even be enjoyable!

## The steps

The steps are:

1. Take a break
2. Rubber duck
3. Check your assumptions
4. Follow the flow and get visibility
5. Repeat

## 1 - Take a Break

Normally we only consider that we're even debugging, as opposed to regular programming, when we've been stuck on something for a while and we can't fix it. As soon as you've become aware that you have a difficult bug and you're stuck the most important thing you can do is take a break at that point. There's been many times when we've been stuck for a long time on something and reluctantly taken a break, only to come back five minutes later and instantly see the solution to the problem.

## 2 - Rubber Duck

Unless you're doing a weekend challenge or tech test, you'll be aware that we advise you always pair, and debugging is one of those times when having another set of eyes on a problem is a godsend. Just by one of you talking through the problem to the other you will often find the problem you're struggling on becomes so much clearer.

If you don't have a pair (or you can't pair as it is a tech test) doing some [rubber duck pairing](http://blog.codinghorror.com/rubber-duck-problem-solving/) as ridiculous as it sounds, our plastic ducks have solved more than their fair share of bugs in our codebase!

![Rubber Duck](https://hattonsimages.blob.core.windows.net/products/RubberDuck_3170853_Qty1_1.jpg)

So let's say at this point you turn to your pair and describe the problem as "whenever I try and save my user to the database in Rails, no error is thrown but the user does not get saved into the database"

## 3 - Check your assumptions

List the things that you assume about what happens when your code is running.  Actually write them down! Prove to yourself that each assumption is correct by following the flow and getting visibility.  Start with the assumptions that are most likely to be incorrect.

Some example assumptions:

* The data is being passed correctly through to the user model.
* The method used to save the user model to the DB is working.
* The data is not reaching the DB.
* An error should be thrown when the user is saved.

## 4 - Follow the flow and get visibility

As you try to understand your program, there are two basic things you'll want to find out.

**Which parts of your program are running, and what order are they running in?**

**What are the values of variables, and are they what you expected?**

Here are some techniques for finding out these things:

* Print out a variable or a "hello we reached this point in the code!"
  * Ruby: `p`
  * JavaScript: `console.log`

* The Network tab of the Chrome developer tools to see request and response data.

* The Elements tab of the Chrome developer tools to see the content and styling of web pages.

* Pause and step through your code, line by line
  * Ruby: `binding.pry`
  * JavaScript: `debugger` (JavaScript)

* Try out and understand code snippets:
  * Ruby: `irb`.
  * JavaScript: the Chrome developer tools console, or `node`.

For further tips, see our blog post by Sam Morgan [How I solve hard problems](http://blog.makersacademy.com/how-i-solve-problems/)

## 5 - Repeat

Once you've reached some conclusions based on your tests, if you still haven't
fixed the problem then you'll need to run the steps again - at least you have ruled out one train of investigation.

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
* Don't forget to take out all of your debugging statements when you're done fixing the problem!

## Some further reading:

   * [The StackOverflow founder on Rubber Duck Debugging](http://blog.codinghorror.com/rubber-duck-problem-solving/)
   * [Zen of debugging](http://webadvent.org/2012/debugging-zen-by-ben-ramsey)
   * [The psychology of debugging](https://docs.google.com/file/d/13hFUiT8lD1FiaRkwrM5AOdbT2xSVZF8eg0JXdcqU4mZSAzXkwonp1M-TFqR8/edit)
   * [JavaScript debugging](https://developer.chrome.com/devtools/docs/javascript-debugging)
