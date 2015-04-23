# TDD and pair programming: Fizzbuzz

The goal of Fizzbuzz is to introduce you to Test Driven Development (TDD) and Pair Programming.

***Please work through this walkthrough with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill  :pill:](../pills/pairing.md). Please swap driver/navigator roles following one of the protocols described in the pill ('change the message' is probably best), ensuring that the maximum time one person is driving is 15 minutes.***

***Finally, please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

## What is Fizzbuzz?
Fizzbuzz is a simple coding challenge, often described as a [code kata](http://codekata.com/).  The objective of Fizzbuzz is to create a program with the following specification:

* The program can be passed a number.
* When passed a number that is a multiple of 3, the program returns the message 'Fizz'.
* When passed a number that is a multiple of 5, the program returns the message 'Buzz'.
* When passed a number that is a multiple of *both* 3 and 5, the program ignores the previous 2 rules and returns the message 'Fizzbuzz'.
* In all other cases, the program simply returns the given number.

This exercise is ideal for discovering both TDD and pair programming.

## Introducing TDD
Test driven development is a software programming practice that can radically increase code quality and program design.  It is used throughout top software development companies and we are hardcore advocates of it here at Makers Academy.

It can be a bit strange at first, but once you get used to it, it will help your designs to *emerge* and accelerate your coding skills remarkably.

### TDD in a nutshell
#### Step 1:  Write a failing test  (RED)
We begin by describing a single expectation of our program.  We do this using a particular testing framework.  There are a number of frameworks to choose from, but we prefer RSpec.  In a moment, you should read the [RSpec pill :pill:](../pills/rspec.md)).

We make no assumptions about what the program is, or how it should work, we simply **write the code we wish we had** to satisfy the expectation we are describing.

What makes this step particularly unusual for people starting TDD for the first time, is that we already know this test is going to fail for multiple reasons.  Nevertheless, we do not write a single line of production code until there is a **failing test** in place to justify it.

#### Step 2:  Write *the simplest code possible* to pass the test  (GREEN)
This is the second reason why TDD is so peculiar at first.  It is likely that the simplest code possible is also, initially, **the wrong code**.  Yet we write it anyway.  The reason is, at this point, our only motivation is to pass the test.  We make no assumptions about future requirements of the code.  **Future requirements will only be satisfied when they are proven by the introduction of another test.**

#### Step 3:  Clean up  (REFACTOR)
The final step is to double check that *all* current tests are still passing and to tidy up and improve the structure of the code (*without adding any additional functionality*) where appropriate.  We can improve the code with considerable confidence, because running our tests will always prove that the current expectations of the code have been met.

#### Step 4:  Repeat until all expectations have been specified.
Choose the next expectation and return to Step 1.  This process is also known as:

RED - GREEN - REFACTOR

and is referred to in the [pairing pill  :pill:](../pills/pairing.md)

Now spend at least five or ten minutes discussing TDD with your pair partner.  Find some resources online and make sure you fully understand the TDD philosophy before progressing any further.  You will experience TDD and pair programming throughout this course and it's vital that you get off to a good start.

## Starting Fizzbuzz
Open up the terminal, and use Unix commands to move to and/or crate a folder somewhere in which to place projects.
Now type the following:
```
$ mkdir fizzbuzz
$ cd fizzbuzz
$ git init
```
Discuss with your pair partner what you just did, then switch roles :twisted_rightwards_arrows:

You will need the [RSpec gem](https://github.com/rspec/rspec) installed:
```
$ gem install rspec
```
Next, have a look at the options RSpec provides:
```
$ rspec --h
```
RSpec provides a convenient command-line option to initialize your project.  Type the following:
```
$ rspec --init
```
Have a look at the structure that's been created and read the `./spec/spec_helper.rb` file.  How much of it can you understand?  Discuss with your pair partner what the different configuration sections might mean.

We have reached a suibtable commit point, so let's check our repository status:
```
$ git status
```
Did you notice anything strange?  Is there a `.rspec` file that you hadn't noticed before?  Why doesn't it show when you do `ls`?  Try `ls -a` instead.

Commit your changes with a suitable message:
```
$ git add .
$ git commit -m 'initializes rspec'
```
