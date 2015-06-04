#Cucumber

[Cucumber](http://cukes.info/) is a tool for writing [acceptance tests](http://en.wikipedia.org/wiki/Acceptance_testing) in Ruby. It's widely used in conjunction with [RSpec](http://rspec.info).

Cucumber functions as a description of the software for both the developer and the client, as well as a testing framework to determine whether the software is meeting the description. Although written in Ruby, Cucumber tests are written in a Domain Specific Language (DSL) called Gherkin, which makes the test readable to both the developer and their client alike.

##Why not just use Rspec

You *could* use Rspec for acceptance testing - no law against it. But Cucumber
and Gherkin extend the tests beyond just testing -- they act as a specification
and design document for the whole project (that everyone can read!)

##Installation

Cucumber is a gem, and so can be easily installed with the command

```ruby
gem install cucumber
```

Take a look at what's on offer by running the help command.

```ruby
cucumber --help
```

##OH HAI CUCUMNER!

Let's make a test! First I'll crack open a directory to put this bit of fun in:

```shell
mkdir oh_hai_cucumner
```

If we drop into this directory and run `cucumber` we'll get an error message:

```shell
No such file or directory - features. Please create a features directory to get started. (Errno::ENOENT)
```

...because Cucumber likes to keep its tests (which it calls *features*) in a directory
called `features`. So let's add one!

```shell
mkdir features
```

Now when we run `cucumber` we'll get the far more appealing message:

```shell
0 scenarios
0 steps
0m0.000sv
```

Cucumber keeps its features in files with `.feature` at the end. Add one into
the `features` directory (maybe something like `oh_hai_world.feature`) and open
it up in your editor.

Let's add the features nao. (Sorry, now)

```cucumber
Feature: cucumber says OH HAI CUCUMNER
	In order to start learn Cucumber
	As a student at Makers academy
	I want to say OH HAI CUCUMNER

	Scenario: cucumber says OH HAI CUCUMNER
		Given a lulz greeter
		When I send it the greet message
		Then I should see "OH HAI CUCUMNER!"
```

This is a Cucumber feature. It starts with a description of the feature (what
it's doing, what it's for) as a reference point for people reading it to
understand why the feature is there in the first place. Often it's written in
the form of *In order... / As a... / I want...*, but this is convention; the text
indented underneath is entirely free. But bear in mind that the *In order...*
pattern is a good place to start when trying to say what your feature is going
to do.

The second part is a **scenario**, which is where the actual tests live. They are
built around keywords that describe what the software is doing - above we
have **Given**, **When** and **Then**. When we read this description of the
program we have a good idea of what it ought to be doing.

**Given** describes the internal state of the program before you do something,
**When** is what you're doing to it, and **Then** is what it's like just after
the action occurs. You're doing similar things in Rspec, but less explicitly.

**Given**, **When** and **Then** are *keywords* for Cucumber, as are **And** and
**But**. They all mean the same things - they tell Cucumber to make a new test
there. You could also use <b>\*</b> -- making a bulleted list.

###Many Languages

You don't even have to use English - here's the same in Spanish...

```cucumber
Escenario: Cucumber dice OH HAI CUCUMNER
	Dado un lulz saludo
	Cuando envío un mensaje de bienvenida
	Entonces debería ver "OH HAI CUCUMNER!"
```

Catalan...

```cucumber
Escenari: Cucumber diu OH HAI CUCUMNER
	Donat una lulz salutació
	Quan envio un missatge de benvinguda
	Aleshores hauria de dir "OH HAI CUCUMNER!"
```

And LOL

```cucumber
MISHUN: MAKES CUCUMNER SAY OH HAI CUCUMNER
	I CAN HAZ A LULZY GREETER
	WEN I TELL IT TO SAY HAI
	DEN I SEE "OH HAI CUCUMNER!"
```

Cucumber can handle most of the world's languages, making it easy to show people
from anywhere what the software specification is (and yes, Klingon works too. No,
I'm not demoing it).

###On with the show

OK, so save off one of those files (the first one, in English, is what we'll be
following below). Now when we run `cucumber` we get this exciting message:

```shell
Feature: cucumber says OH HAI CUCUMNER

  In order to start learn Cucumber
  As a student at Makers academy
  I want to say OH HAI CUCUMNER

  Scenario: cucumber says OH HAI CUCUMNER # features/greeter_says_hello.feature:7
    Given a lulz greeter                  # features/greeter_says_hello.feature:8
    When I send it the greet message      # features/greeter_says_hello.feature:9
    Then I should see "OH HAI CUCUMNER!"  # features/greeter_says_hello.feature:10

1 scenario (1 undefined)
3 steps (3 undefined)
0m0.001s

You can implement step definitions for undefined steps with these snippets:

Given(/^a lulz greeter$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I send it the greet message$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

If you want snippets in a different programming language,
just make sure a file with the appropriate file extension
exists where cucumber looks for step definitions.
```
Cucumber has looked at your feature file and seen that the **steps** (the
Given/When/Then) are *undefined* -- you haven't said what it means when you're
'Given a lulz greeter'.

Handily though, Cucumber has already written a draft version of the steps you
will write in the second half of the output. See - that bit at the bottom is
exactly what you'll need:

```cucumber
Given(/^a lulz greeter$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I send it the greet message$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
```

See how the *Given / When / Then* lines are now `pending` tests? The description
of the tests have been dropped in as a Regex - you could use strings instead but
Regexes are safer and the default.

We're going to be writing what each of these steps means in Ruby in each of
the `pending` gaps. The first step is to put the above in a file called
`oh_hai_cucumner_steps.rb` (copy paste!) and put it in a directory inside
`features` called `step_definitions`.

Now when you run `cucumber` you'll get this (only in pretty colours)

```shell
Feature: cucumber says OH HAI CUCUMNER

  In order to start learn Cucumber
  As a student at Makers academy
  I want to say OH HAI CUCUMNER

  Scenario: cucumber says OH HAI CUCUMNER # features/greeter_says_hello.feature:7
    Given a lulz greeter                  # features/step_definitions/lulz_greeter_steps.rb:1
      TODO (Cucumber::Pending)
      ./features/step_definitions/lulz_greeter_steps.rb:2:in `/^a lulz greeter$/'
      features/greeter_says_hello.feature:8:in `Given a lulz greeter'
    When I send it the greet message      # features/step_definitions/lulz_greeter_steps.rb:5
    Then I should see "OH HAI CUCUMNER!"  # features/step_definitions/lulz_greeter_steps.rb:9

1 scenario (1 pending)
3 steps (2 skipped, 1 pending)
0m0.143
```

So now Cucumber knows what we're up to with these tests. Let's write some step
definitions.

```shell
Given(/^a lulz greeter$/) do
  @greeter = LulzGreeter.new
end

When(/^I send it the greet message$/) do
  @message = @greeter.greet
end

Then(/^I should see "(.*?)"$/) do |lulzy_greeting|
  expect(@message).to eq lulzy_greeting
end
```

See how Cucumber saw the string in quotes in `Then I should see...`and turned
him into an argument in the pipes? And how the `expect` step is just the same as
in Rspec? That's because Cucumber automatically loads up all the Rspec
expectation definitions. So if you know how to `expect` something in Rspec, you
know how to expect it in Cucumber.

Now when we run cucumber we get:

```shell
Feature: cucumber says OH HAI CUCUMNER

  In order to start learn Cucumber
  As a student at Makers academy
  I want to say OH HAI CUCUMNER

  Scenario: cucumber says OH HAI CUCUMNER # features/greeter_says_hello.feature:7
    Given a lulz greeter                  # features/step_definitions/lulz_greeter_steps.rb:1
      uninitialized constant LulzGreeter (NameError)
      ./features/step_definitions/lulz_greeter_steps.rb:2:in `/^a lulz greeter$/'
      features/greeter_says_hello.feature:8:in `Given a lulz greeter'
    When I send it the greet message      # features/step_definitions/lulz_greeter_steps.rb:5
    Then I should see "OH HAI CUCUMNER!"  # features/step_definitions/lulz_greeter_steps.rb:9

Failing Scenarios:
cucumber features/greeter_says_hello.feature:7 # Scenario: cucumber says OH HAI CUCUMNER

1 scenario (1 failed)
3 steps (1 failed, 2 skipped)
0m0.026s
```

`uninitialized constant`? Guess it's time to write some code! We're going to
need a `LulzGreeter` class somewhere. We could write it as a separate file and
have it loaded as a part of Cucumber's environment, but for now let's
just prepend it to the `oh_hai_cucumner_steps.rb` file. At the top, let's put:

```ruby
class LulzGreeter
  def greet
    "OH HAI CUCUMNER!"
  end
end
```

and now when we run Cucumber we get a happy wall of green!

```shell
Feature: cucumber says OH HAI CUCUMNER

  In order to start learn Cucumber
  As a student at Makers academy
  I want to say OH HAI CUCUMNER

  Scenario: cucumber says OH HAI CUCUMNER  # features/greeter_says_hello.feature:7
    Given a lulz greeter                    # features/step_definitions/lulz_greeter_steps.rb:7
    When I send it the greet message        # features/step_definitions/lulz_greeter_steps.rb:11
    Then I expect to see "OH HAI CUCUMNER!" # features/step_definitions/lulz_greeter_steps.rb:15

1 scenario (1 passed)
3 steps (3 passed)
0m0.044s
```

And that ends the intro! There's a lot more to look at (Cucumber loads its
environment up from a file called `env.rb` inside `features/support` would be
a good place to start)

Note that if you like/prefer gherkin style 'given, when, then' syntax you can also use it for Rspec tests: [https://github.com/jimweirich/rspec-given](https://github.com/jimweirich/rspec-given)

###Further Reading

- [Business Readable, Domain Specific Languages](http://martinfowler.com/bliki/BusinessReadableDSL)

- [Uncle Bob on Given/When/Then](https://sites.google.com/site/unclebobconsultingllc/the-truth-about-bdd)

- [Cucumber Home Page](http://cukes.info/)
