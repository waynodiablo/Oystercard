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