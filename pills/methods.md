# Methods

A common developer acronym is DRY - don't repeat yourself. Write the code once and then you can use it over and over. Methods help us with this.

````ruby
def hello(name)
  puts "Welcome to learning how to code #{name}"
end
````

That's how we define a method. We've named this method "hello" and it takes an argument called "name." Now, we can call "hello" and it will execute the code before the "end" statement - which tells ruby that the function is finished. Now we can run this:

````ruby
hello("rob")
hello("jane")
hello("pete")
````

Create a new `hello.rb` file in SublimeText. Once saved, you can run it by pressing Cmd-B (or, you can run it from the terminal as usual).

````ruby
def hello(name)
  puts "Welcome to learning how to code #{name}"
end

hello("rob")
hello("jane")
hello("pete")
````

This is a lot cleaner than writing out three long "puts" statements. We can also create functions that take more than one argument. Let's modify our hello.rb to this:

````ruby
def hello(name, age)
  puts "Welcome #{name}, #{age} is definitely not too old to learn how to code."
end
		
hello("rob",30)
hello("steve",72)
hello("jenny",55)
````

You see how "rob" is passed in as the "name" variable and 30 is passed in as the "age" variable in the first example?

## Method chaining

In Ruby everything is an object and every object has methods. This enables us to "chain" several method calls together. You'll see this pattern often:

````ruby
"hello, world".slice(0, 5).capitalize.sub("o", "0") #=> Hell0
````

This line takes the string "hello, world", then takes five characters starting with the first one (index 0). This operation will return "hello". Then we capitalise this string, at which point we get "Hello". Finally, we substitute the letter "o" with number "0" (sub stands for substitution). That's how we get "Hell0" as the result.

This technique of calling the methods directly on the return value of the previous method call is called method chaining. It can allow you to do fairly powerful data transformations in just one line.

All methods used above are part of the class String, so you can read about them in the documentation (do you remember how to find Ruby classes documentation by googling?).