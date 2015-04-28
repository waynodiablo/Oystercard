# TDD and pair programming: Fizzbuzz

The goal of Fizzbuzz is to introduce you to Test Driven Development (TDD) and Pair Programming.

***Please work through this walkthrough with a pair partner. Please take turns on the keyboard as the driver as described in the [pairing pill :pill:](../pills/pairing.md). Please swap driver/navigator roles following one of the protocols described in the pill ('change the message' is probably best), ensuring that the maximum time one person is driving is 15 minutes.***

***Finally, please note, as with all Makers Academy materials, there may be subtle errors in the following materials.  Please try to approach those as challenges on which to polish your debugging skills - pull requests always welcome.***

## What is Fizzbuzz?
Fizzbuzz is a simple coding challenge, often described as a [code kata](http://codekata.com/).  The objective of Fizzbuzz is to create a program with the following specification:

* The program can be passed a number.
* When passed a number that is a multiple of 3, the program returns the message 'Fizz'.
* When passed a number that is a multiple of 5, the program returns the message 'Buzz'.
* When passed a number that is a multiple of *both* 3 and 5, the program ignores the previous 2 rules and returns the message 'Fizzbuzz'.
* In all other cases, the program simply returns the given number.

When complete we should be able to play in irb like so:

```sh
irb
2.2.1 :001 > require './lib/fizzbuzz'
 => true
2.2.1 :002 > (1..20).each {|number| puts "#{number} --> #{fizzbuzz(number)}"}
1 --> 1
2 --> 2
3 --> fizz
4 --> 4
5 --> buzz
6 --> 6
7 --> 7
8 --> 8
9 --> 9
10 --> 10
11 --> 11
12 --> 12
13 --> 13
14 --> 14
15 --> fizzbuzz
16 --> 16
17 --> 17
18 --> 18
19 --> 19
20 --> 20
```

This exercise is ideal for discovering both TDD and pair programming.

## Introducing TDD
Test driven development is a software programming practice that can radically increase code quality and program design.  It is used throughout top software development companies and we are hardcore advocates of it here at Makers Academy.

It can be a bit strange at first, but once you get used to it, it will help your designs to *emerge* and accelerate your coding skills remarkably.

### TDD in a nutshell
#### Step 1:  Write a failing test  (RED)
We begin by describing a single expectation of our program.  We do this using a testing framework.  There are a number of frameworks to choose from, but we prefer RSpec.  In a moment, you should read the [RSpec pill :pill:](../pills/rspec.md).

We make no immediate assumptions about what the program is, or how it should work; we simply **write the code we wish we had** to satisfy the expectation we are describing.

What makes this step particularly unusual for people starting TDD for the first time, is that we already know this test is going to fail for multiple reasons.  Nevertheless, we do not write a single line of production code until there is a **failing test** in place to justify it.

#### Step 2:  Write *the simplest code possible* to pass the test  (GREEN)
This is the second reason why TDD is so peculiar at first.  It is likely that the simplest code possible is also, initially, **the wrong code**.  Yet we write it anyway.  The reason is, at this point, our only motivation is to pass the test.  We make no assumptions about future requirements of the code.  **Future requirements will only be satisfied when they are proven by the introduction of another test.**

#### Step 3:  Clean up  (REFACTOR)
The final step is to double check that *all* current tests are still passing and to tidy up and improve the structure of the code (*without adding any additional functionality*) where appropriate.  We can improve the code with considerable confidence, because running our tests will always prove that the current expectations of the code are being met.

#### Step 4:  Repeat until all expectations have been specified.
Choose the next expectation and return to Step 1.  This process is also known as:

RED - GREEN - REFACTOR

and is referred to in the [pairing pill :pill:](../pills/pairing.md)

Now spend at least five or ten minutes discussing TDD with your pair partner.  Find some resources online and make sure you fully understand the TDD philosophy before progressing any further.  You will experience TDD and pair programming throughout this course and it's vital that you get off to a good start.

## Starting Fizzbuzz
Open up the terminal, and use Unix commands to move to and/or create a folder somewhere in which to place projects.
Now type the following:
```sh
$ mkdir fizzbuzz
$ cd fizzbuzz
$ git init
```
Discuss with your pair partner what you just did, then switch roles :twisted_rightwards_arrows:

You will need the [RSpec gem](https://github.com/rspec/rspec) installed:
```sh
$ gem install rspec
```
Next, have a look at the options RSpec provides:
```sh
$ rspec --h
```
RSpec provides a convenient command-line option to initialize your project.  Type the following:
```sh
$ rspec --init
```
Have a look at the structure that's been created and read the `./spec/spec_helper.rb` file.  How much of it can you understand?  Discuss with your pair partner what the different configuration sections might mean.

We have reached a suitable commit point, so let's check our repository status:
```sh
$ git status
```
Did you notice anything strange?  Is there a `.rspec` file that you hadn't noticed before?  Why doesn't it show when you do `ls`?  Try `ls -a` instead.

Commit your changes with a suitable message:
```sh
$ git add .
$ git commit -m 'initializes rspec'
```
We are going to need somewhere to write our tests.  So let's create a `spec` file:
```sh
$ touch spec/fizzbuzz_spec.rb
$ git commit -am 'adds fizzbuzz_spec.rb'
```

Notice the file is in the `./spec` folder and has the suffix `_spec.rb`.  Discuss the reasons for this with your pair partner.

Finally, run RSpec and ensure 'everything is green'.

## Writing the first test
Switch roles again :twisted_rightwards_arrows:.  In your favourite editor, type the following code in `./spec/fizzbuzz_spec.rb`:

***You must type all code in these walkthroughs by hand.  DO NOT copy and paste.  Speed is not the objective and you will learn more effectively by manually typing code.***
```ruby
describe 'fizzbuzz' do
  it 'returns "fizz" when passed 3' do
    expect(fizzbuzz(3)).to eq 'fizz'
  end
end
```
Discuss this code with your pair partner.  What does each line mean?  Read the [RSpec pill :pill:](../pills/rspec.md) and ensure you understand exactly what is going on.

## Running the first test
```sh
$ rspec
```
RSpec should now report that you have one failing test.  If not, carefully check you have correctly followed the steps.  If you need further help, please ask an [Alumni Helper](https://github.com/makersacademy/course/blob/master/toc.md#resources).

Discuss the RSpec output with your partner.  What does it mean?  How would you use this output to drive the next step in the process?

## Passing the first test :twisted_rightwards_arrows:
Now we have a failing test, we can actually write some production code.  To keep our production files and test files separate, we will put our production code in a folder called `lib`.
```sh
$ mkdir lib
$ touch lib/fizzbuzz.rb
```
Now, in your text editor, edit `lib/fizzbuzz.rb`:
```ruby
def fizzbuzz

end
```
What are we doing here?  Our RSpec output told us `undefined method 'fizzbuzz'`, so we are simply attempting to change that message - nothing more.  Run `$ rspec` again.  Have we changed the message?

Although we have now defined the method `fizzbuzz`, RSpec is still unable to see it.  This is because RSpec knows nothing about the file `fizzbuzz.rb`.  We have to tell it.  In `fizzbuzz_spec.rb`, add the following line to the top of the file:
```ruby
require 'fizzbuzz'
```
Notice we did not specify the `lib` folder or the `.rb` extension.  Should we have done?  Discuss this with your pair partner.  Note also that the following two alternatives are also valid:
```ruby
require './lib/fizzbuzz'
require_relative '../lib/fizzbuzz'
```
Discuss these three alternatives with your pair partner.  Which one do you prefer?  Why?

Now run RSpec again.  Have we changed the message?  Do all three of the above alternatives result in the same message?  Discuss the output with your pair partner.  You may or may not wish to switch roles at this stage :twisted_rightwards_arrows:.

It's important to question scenarios like the one above and not simply accept that they work 'by magic'.  Do some research online - try to understand what's happening behind the scenes.  In this case, RSpec actually adds `lib` to its `LOAD_PATH` by default.  This means that it will look for required files in `lib` automatically, which is why we can simply `require 'fizzbuzz'`.  Ruby will infer the `.rb` extension if it is omitted, so this is optional too.

You should be seeing the message `wrong number of arguments (1 for 0)`.  We have not specified the arguments in our method definition.  When doing TDD for real, you would probably not stoop to this level unless you were practicing 'One-undermanship'.  Nevertheless, let's fix the message:
```ruby
def fizzbuzz(number)

end
```
Run RSpec again.  Still failing?  Good.  Now let's pass the test :twisted_rightwards_arrows:
```ruby
def fizzbuzz(number)
  'fizz'
end
```
Seriously?  Yes.  The critical point to understand here is that our production code *now fully meets the expectations defined in our tests*.  But we clearly haven't satisfied the specification of the program.

We can see this by running the program in irb:

```sh
$ irb
2.2.1 :001 > require './lib/fizzbuzz'
 => true
2.2.1 :002 > fizzbuzz 3
 => "fizz"
2.2.1 :003 > fizzbuzz 4
 => "fizz"
```

We strongly recommend that you regularly check the functionality of your code in IRB as you go along.  We can see clearly here that we 'fizz' for 3, but we also do so for every number.  We need more tests!

## Writing the next test :twisted_rightwards_arrows:
It should be clear now that we have two objectives in TDD:

1. Write production code that fully meets the expectation of our tests.
2. **Write tests that fully meet the specification of the progam**.

Once we have achieved both of those objectives, we know with absolute confidence that we are 'code complete' and that our program works exactly as it should.  And what's more, as an added and incredibly valuable bonus, anyone new to our codebase does not need to trawl through our production code trying to understand what it does.  They can simply read our tests and (assuming the tests all pass) know exactly what the code *should* do and also that *it does*.

Commit your code to git then discuss with your partner what the next test should be.

## Finishing Fizzbuzz
Continue with the RED - GREEN - REFACTOR (commit) process until you have completely specified and coded Fizzbuzz.

Use `irb` to run further manual tests.  Are there any edge cases that you have missed?  If so, write a test to cover each edge case.  Why is this so important?

Try running Fizzbuzz for all numbers from 1 to 100 in `irb`.  Discuss with your pair partner different ways to do this.  Can you use Ruby to do this in one line of code (N.B. it must be elegant and readable)?

When you are finished, please find a coach or [Alumni Helper](https://github.com/makersacademy/course/blob/master/toc.md#resources) to verify what you have done.

## Further exercises :running_shirt_with_sash:
Once you have completed Fizzbuzz, please delete your `fizzbuzz` directory and start over from scratch with opposite roles.  (You read that correctly - please delete the entire directory and start again.)  Do as much of it as you can from memory.  Practicing repeatedly this way will accelerate your learning.

To make it more interesting, try to solve the Fizzbuzz problem in different ways.  For example, here's an alternate version of the first test:
```ruby
it 'returns "fizz" for the number 3' do
  expect(3.fizzbuzz).to eq 'fizz'
end
```
Can you do the whole of Fizzbuzz this way?

## Supporting materials
* [Pairing pill :pill:](../pills/pairing.md)
* [Code kata](http://codekata.com/)
* [RSpec pill :pill:](../pills/rspec.md)
* [RSpec gem](https://github.com/rspec/rspec)
