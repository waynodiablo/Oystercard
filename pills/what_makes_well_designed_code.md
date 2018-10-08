# What makes well-designed code?
Why is software better than hardware? Why not just have a specific machine for word processing, playing music, getting stock quotes etc.

Hardware is faster, more robust, less complex, less power-hungry.

Software is more flexible. This is its sole advantage. With software, one machine can do any number of things and those things can change over time. I can buy a phone today whose capabilities will change and evolve as society changes around it.

The most important quality in software is ease of change.

## What's going to change?
Some designs make certain changes easy and others harder. For example:

```ruby
class Greeter
  def initialize(greeting)
    @greeting = greeting
  end

  def greet(name)
    "#{@greeting}, #{name}"
  end
end

greeter = Greeter.new("Hello")
greeter.greet("Kay")
# => "Hello, Kay"
```

This code makes it easy to change "Hello, Kay" to "Goodbye, Kay" or whatever else — but not especially easy to change it to "Why, Kay, it's lovely to meet you!".

Suppose I changed it to:

```ruby
class Greeter
  def greet_hello(name)
    "Hello, #{name}"
  end

  def greet_friendly(name)
    "Why, #{name}, it's lovely to meet you!"
  end
end

greeter = Greeter.new
greeter.greet_hello("Kay")
# => "Hello, Kay"
greeter.greet_friendly("Kay")
# => "Why, Kay, it's lovely to meet you!"
```

I've managed to add my desired change, but now I have to amend the class to add any greeting. If I only had to change that 1-2 times over the life of my program that would be fine. But if my customer wanted users to be able to add custom greetings this would be hard to add.

This 'easy to change' thing doesn't look so easy. It seems like we need to be able to predict the future — to look ahead and see what kinds of changes the user will want. Sometimes customers give us that insight and we can anticipate the ways things might involve, but just as often changes come in that surprise us.

Much of the history of software is about squaring this circle. You will see it come up again and again in areas as disparate as agile, tech stack choices, dependencies, and functional programming.

## Predicting the future
OK — we can't predict the future, but there are general principles and ways of organising our code that make change easier.

Consider an extreme example: a program with no classes, methods or functions. Just one long flat program with input, algorithms, and outputs. This is hard to change because there's no encapsulation — any bit of the program might refer to any other bit. We have to know the entire program — maybe tens of thousands of lines — to reliably predict anything!

On the other hand, imagine a program organised into classes and methods. We know what goes into these classes and methods, so as long as that's small enough we can reason about the behaviour of that unit. If we need to think about the whole program, the classes have small well-defined interfaces so we don't have to think about their contents.

The latter is clearly easier to change than the former in nearly every case.

Another example: a program where the variables and methods are all just letters of the alphabet — very hard to understand and therefore change. On the other hand, a program where the variables and methods are named descriptively to indicate their purpose — much easier to understand and change.

These general design principles — modularisation and naming amongst others — are how we write software that is easy to change in general. Whatever the future holds, whatever changes we're asked to make, following these principles *should* make them easier vastly more often than it makes them harder.

Imagine making a car with screws or with glue. Screws make the car inherently easy to repair and modify, and glue makes it more difficult. The principle here is the same.

## And practically?
There are many, often conflicting, software design principles. Some favour object oriented design, some functional design, some a mixture of both. How do you tell which is better to use?

Trace the logic back to which techniques and designs make your software easier to change in future. With this as your 'moral compass', you will be able to fit each idea into its right place, and gradually learn to tell the gold from the hype.
