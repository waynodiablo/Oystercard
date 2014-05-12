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