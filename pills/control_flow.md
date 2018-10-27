# Control flow

Our programs would be fairly boring if they were executed top to bottom, producing the same result every time. Ruby provides us a set of statements intended to control the flow of execution. Let's take a quick look at some of them.

## If / else statements

If/else statements are exactly what they sound like. We want some code to run if something is true, else we'll run something else. Try the following code:

````ruby
hungry = true
		
if hungry
  puts "I'm hungry and would like some food."
else
  puts "Thanks, but I'm not hungry."
end
````

We declare `hungry` as a variable and assign it the boolean value true. Then, our if statement says: if `hungry` is true, run the first puts statement. If it's not, run the second puts statement.

````
I'm hungry and would like some food.
````

Try changing hungry to false and running it again - it will run the second puts statement. We could write the same program with the following code:

````ruby
hungry = true
		
if hungry == true
  puts "I'm hungry and would like some food."
else
  puts "Thanks, but I'm not hungry."
end
````

All we've done here is to explicitly say that hungry needs to be equal to true in order for it to run the first puts statement. We could expand our if/else statements a bit further to show how to string them together:

````ruby
if hungry == true
  puts "I'm hungry and would like some food."
elsif hungry == false
  puts "Thanks, but I'm not hungry."
else
  puts "Either you're hungry or not - pick one."
end
````

Ruby will start with the top of an if/else statement and continue to evaluate the conditions until it finds one that works. If none of them work, it will evaluate whatever is after the final else statement. If we changed the value of hungry to `:maybe` and ran the code, it will run the final puts statement because neither of the first two were evaluated correctly.

````ruby
hungry = :maybe

if hungry == true
  puts "I'm hungry and would like some food."
elsif hungry == false
  puts "Thanks, but I'm not hungry."
else
  puts "Either you're hungry or not - pick one."
end
````

````
Either you're hungry or not - pick one.
````

## Evaluating expressions in control flow

Every time you write use an expression in a control flow statement (if, elsif, unless, while, etc.), Ruby tries to decide whether the expression is true or false: there's no middle ground here. So, when you write `if hungry`.

Ruby tries to figure out whether hungry is true or not. It's easy if hungry is a boolean variable:

````ruby
hungry = true
if hungry
  puts "Let's go to a restaurant"
end
````

It's also easy if we're doing a comparison that evaluates to an boolean value

````ruby
correct_answer = 4
user_answer = 4
if correct_answer == user_answer
  puts "well done!"
end
````

But what if we are evaluating something that is not a boolean?

````ruby
if :france
  puts "will this be printed?"
end
		 
if 7
  puts "and this?"
end
		 
if nil
  puts "and this too?"
end
		 
if false
  puts "but surely not this?"
end
		 
if {:pi => 3.14.15.926}
  puts "what about a hash?"
end
		 
if ""
  puts "or an empty string"?
end
		 
if 0
  puts "and even zero!"
end
````

The rule is simple. There are only two values that are evaluated as false: false itself and nil. Everything else that is not false or nil is evaluated to true. This includes 0, an empty string, any array, any hash, any symbol, in fact – any object except nil. So in the example above only two strings will not be printed: the ones that follow `if nil` and `if false`.

## Inline if

A very common Ruby trick is to write if-statements on one line if they are short enough. These blocks of code are equivalent

````ruby
if hungry
  puts "let's go out"
end
		 
puts "let's go out" if hungry
````

Obviously this only works with one-liners and only if the line is short enough: you don't want your one-liner to be longer than a few dozen characters at most (probably shorter).

## Comparison operators

In the examples above, "==" is a comparison operator. Comparison operators always compare the operands and evaluate to either true or false. Here are a few examples:

````ruby
hungry == true # true if hungry is true
age > 30 # true if age is strictly greater than 30
15 >= 30 # false
2 < 10 # true
size <= 22 # true if size is less or equal to 22
30 != 15 # true
````

Let's go through each of these line by line. The first one you know, it's evaluating equality. If hungry is assigned a value of true, the entire comparison will evaluate to true. 

Why does equality use two "=" instead of one? Because one "=" is what we use for assignment operators such as when we change the value of a variable.

The next four comparisons should be familiar from the school math. They are greater than, greater than or equal to, less than, and less than or equal to, respectively.

The final comparison may look strange, but it simply means "not equal to" and is the opposite of "==" The example we've provided of "30 != 15" would evaluate to true because they're not equal.

## Unless

Unless statements are the opposite of if/else statements - they will always run the code within them unless the condition is true. Here's an example:

````ruby
hungry = false
		
unless hungry
  puts "Don't eat food"
end
````

This will run the puts statement because unless statements will always run unless the condition is true. You can read this much like you'd read a sentence, "Unless you're hungry - don't eat food."

Some Ruby developers find "unless" confusing, especially if it's used with complex conditions. If you find your code is easier to read, don't be afraid of using "if" instead:

````ruby
hungry = false
		
if !hungry
  puts "Don't eat food"
end
````

This code does exactly the same thing as the example above it. Here, the bang (exclamation mark) means the negation:

````ruby
!true # false
!false # true
````

## Switch Statements

After a certain point, if/else statements will get a bit too large for comfort. For example, if we wanted to create a bit of code that prints out the name of a fruit and its color, we might do it with if/else statements like this:

````ruby
if fruit == "apple"
  puts "The apple is red"
elsif fruit == "banana"
  puts "The banana is yellow"
elsif fruit == "orange"
  puts "The orange is orange"
elsif fruit == "kiwi"
  puts "The kiwi is green"
else
  puts "We don't recognise that fruit"
end
````

This can get a bit cumbersome so ruby also has switch statements. We can rewrite the code above as:

````ruby
case fruit
when "apple"
  puts "The apple is red"
when "banana"
  puts "The banana is yellow"
when "orange"
  puts "The orange is orange"
when "kiwi"
  puts "The kiwi is green"
else
  puts "We don't recognise that fruit"
end
````

The "case" is the value that we want to evaluate - in our case, the fruit variable. Then, we list out the various cases and tell it what to do based on each case.

Quite often, case statements are a [code smell](http://en.wikipedia.org/wiki/Code_smell) that indicates that the code can be refactored to make it simpler. However, they can be genuinely useful in some cases.

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/control_flow.md)
