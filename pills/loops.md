# Loops

So far we've looked if/else, unless and switch statements for controlling flow. These can get you a long way towards writing clean code, but at some point you're going to want to make your code loop.

## While

A "while" loop will continue to run while some condition is true. Let's say we wanted to print the phrase "Coding is Awesome!" ten times. We could write out ten "puts" statements, but loops can help us make it a bit cleaner and follow the DRY (Don't Repeat Yourself) principle.

````ruby
count = 1
while count <= 10
  puts "Coding is Awesome!"
  count = count + 1
end
````

Let's review this one line-by-line. 

On the first line we create a counter. We use counters when we want to count the number of repetitions a loop has made. The name of the variable doesn't matter much but it helps if it's descriptive. We assign it the value of 1 since that's where we want to start counting.

The while loop will continuously run while a certain condition is true. In this case, we want it to continuously run as long as our counter is less than or equal to 10 since we want to print something 10 times.

Inside of the while loop is the code that runs each time the loop's condition is still true. We print out our statement and increase our counter by 1. It's very important that we do this because if we didn't, we'd find ourselves in an infinite loop and our program will never terminate.

If we were to follow the beginning of this program, the flow would go something like this:

1. Assign a value of 1 to our counter
2. Is 1 less than or equal to 10? YES
3. Print the statement and add 1 to the counter, so it becomes 2
4. Is 2 less than or equal to 10? YES
5. Print the statement and add 1 to the counter, so it becomes 3
6. ...

You get the picture.

> **Sidebar**
>
> Notice in the program above how we incremented our counter 
> with the code `count = i + 1`, This is such a common piece of 
> code so ruby has made things a bit easier for us by giving 
> allowing us to just use `count += 1`. if we want to increment 
> the counter by 1. Here are a few other shorthand
> _"incrementers"_ and _"decrementers"_ that ruby has (I've 
> added in-line comments to show the long-form way of writing
> it):
> 
> `count += 1 # count = count + 1`
> `count -= 1 # count = count - 1`
> `count *= 5 # count = count * 5`

## Until

Until loops are similar to while loops, except that they will continue running until a certain condition is true. We can rewrite our program above using an until loop like this:

````ruby
count = 1

until count > 10
  puts "Coding is Awesome!"
  count += 1
end
````

Here, the loop runs because our counter is less than 10 and will continue iterating until the counter is greater than 10 - then it will stop. (I've also used the short-hand for the _"incrementer"_ as this is the standard most developers use so you need to get used to seeing it.)

## A simple loop

There's another kind of loop that is useful when there are no conditions to check, that is, you just want your code to be repeated indefinitely. It looks like this:

````ruby
loop do
  # code here will be executed an infinite number of times
end
````

## Breaking out of a loop

In fact, it's possible to break out of the loop (a simple loop, a while loop, an until loop or other type of loop) if you want to end it early. If a keyword `break` is encountered inside a loop, the loop will terminate. For example:

````ruby
i = 0
loop do
  i = i + 1
  break if i == 10
end
puts "i is now #{i}" # i is now 10
````