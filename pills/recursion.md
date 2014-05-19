# Recursion

Recursion is a coding technique that solves complex problems by reducing them to smaller instances of the same problem.

## Why is recursion important?

Recursion allows to solve a certain class of problems in an elegant way, enabling you to write concise, easy to read code.

In theory, any problem that would otherwise be solved using a looping construct (a `for` or `while` loop) could be solved using recursion. There are some functional programming languages – [Clojure](http://clojure.org), [Scala](http://www.scala-lang.org), [Erlang](http://www.erlang.org), [Haskell](http://www.haskell.org/haskellwiki/Haskell), etc. – that don't have looping constructs at all. For example, in [Clojure](http://clojure.org) you'd need to use recursion every time you would use an iterator in [Ruby](https://www.ruby-lang.org).

Finally, since recursion is an abstract concept that less experienced developers may find hard to understand, recursion is often used in programming job interviews.

## So, what is recursion?

Recursion is a method of solving a problem by breaking it down into smaller instances of the same problem. For example, let's say the task is to compute the factorial of 5 ( _a factorial of n, denoted n!, is the product of all numbers from 1 to n, e.g. 5! = 1*2*3*4*5_).

This problem can be solved using an iterative construct:

````ruby
def factorial(n)
  result = 1
  n.times do |i|
    result *= i + 1
  end
  result
end
````

However, the same problem  can be solved using recursion. If you pay attention it might become obvious that 

````ruby
factorial(n) == n * factorial(n-1) #=> true
````

This reduced the problem of calculating n! to a smaller instance of the same problem (calculating **(n-1)!**) and multiplying it by **n**. We can use this approach to rewrite our method:

````ruby
def factorial(n)
  return 1 if n < 2
  factorial(n-1) * n
end
````

Or, even shorter:

````ruby
def factorial(n)
  n < 2 ? 1 : factorial(n-1) * n
end
````

Such a method than calls itself to compute the result is called a recursive method. Since the method calls itself, it must always have at least one base case when this doesn't happen in order to avoid an infinite loop. Therefore, on every invocation of a recursive function it should check whether the input parameters constitute a base case and then decide whether to call itself.

For example, in the factorial example above the base case is `n < 1`. If this condition holds, then the method returns 1 without calling itself. Otherwise, it calls itself with a different argument (n-1).

It's crucial to simplify the problem (in this case simplifying it from `factorial(n)` to `factorial(n-1)`) on every iteration. Otherwise the recursive method will enter an infinite loop. If this happens, you'll see this error:

````ruby
SystemStackError: stack level too deep
````

It means that Ruby ran out of memory to store all invocations of your method because there were too many of them. It almost always means that your code has a bug that allows an infinite loop to happen.

## Use cases

You may argue that a web developer doesn't have to calculate factorials very often. It's true but recursion can be useful in many more cases:

- If you're building a graphical editor, like Photoshop, you'll probably use recursion to implement the "fill" function
- If you're manipulating a tree-like data structure, e.g. traversing all elements on a web page without using jQuery (we'll get to jQuery in a couple weeks time), you'll use recursion to do it. The jQuery source code itself contains plenty example of recursion
- If you need to [sort some data](http://www.sparknotes.com/cs/recursion/examples/section3.rhtml), you may want to use a recursive algorithm.

## Is it more efficient?

Recursion isn't faster or more memory-efficient than an iterative implementation. In fact, it may actually consume more memory than a non-recursive method. However, recursion often brings clarity to the code, making your code easier to write, to understand and to maintain.

## How to debug it?

Let's say you'd like to see the sequence of calls for the recursive factorial method. Try doing this:

````ruby
def factorial(n)
  puts "Computing factorial(#{n})"
  if n < 1
    puts "factorial(#{n}) == 1 since #{n} < 1"
    return 1
  else
    puts "let's compute factorial(#{n}) == #{n} * factorial(#{n-1})"
  end
  result = factorial(n-1) * n
  puts "So, factorial(#{n}) == factorial(#{n-1}) * #{n} == #{result}"
  result 
end
````

The output will be:

````
Computing factorial(6)
let's compute factorial(6) == 6 * factorial(5) 
Computing factorial(5) 
let's compute factorial(5) == 5 * factorial(4) 
Computing factorial(4) 
let's compute factorial(4) == 4 * factorial(3) 
Computing factorial(3) 
let's compute factorial(3) == 3 * factorial(2) 
Computing factorial(2) 
let's compute factorial(2) == 2 * factorial(1) 
Computing factorial(1) 
let's compute factorial(1) == 1 * factorial(0) 
Computing factorial(0) 
factorial(0) == 1 since 0 < 1 
So, factorial(1) == factorial(0) * 1 == 1 
So, factorial(2) == factorial(1) * 2 == 2 
So, factorial(3) == factorial(2) * 3 == 6 
So, factorial(4) == factorial(3) * 4 == 24 
So, factorial(5) == factorial(4) * 5 == 120 
So, factorial(6) == factorial(5) * 6 == 720  
=> 720
````

This way you'll see the execution trace, showing how the code works. As you can see from the output, first the code is **folding** until it reaches the base case and then it's **unfolding**. So first, the problem is broken down into smaller pieces and then, once the base case is reached, it's used to compute all other values.