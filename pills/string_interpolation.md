# String Interpolation

Strings can be added together by concatenating them - simply combining a variable with a string with:

````ruby
		puts "The people variable is currently: " + people
````

There's another way to access variables called interpolation. We can recreate the same command as above with:

````ruby
		puts "The people variable is currently: #{people}"
````

Using the syntax of `#{something}` inside a double-quoted string where "something" is Ruby code will execute it and substitute it as part of the string .
````ruby
		# Pass the string "Makers" into a variable and print it out
		people = "Makers"
		puts "The people variable is currently: #{people}"
		
		# Change the variable to "Coders" and print it again
		people = "Coders"
		puts "The people variable is currently: #{people}"
````

The result should be exactly the same. In this example, we're simply using a variable name but you can use interpolation for any valid Ruby code. Try this in the console:

````ruby
		"2 + 2 = #{2 + 2}"
````

You should see `2 + 2 = 4`.

There's one more benefit of interpolation: it automatically does string conversion for you. For example, if you try to combine a string with a number,

````ruby
		hour = 10
		"I will leave no later than " + hour
````

Ruby will throw an error:

````ruby
		TypeError: no implicit conversion of Fixnum into String
		        from (irb):2:in `+'
		        from (irb):2
		        from /Users/shadchnev/.rvm/rubies/ruby-2.0.0-p0/bin/irb:16:in `<main>'
````

The reason is that Ruby can only combine strings, not strings and numbers. We could have got around it by converting the number into a string

````ruby
		"I will leave no later than " + hour.to_s
````

Alternatively, we could use interpolation:

````ruby
		"I will leave no later than #{hour}"
````

This way the interpolated code will be converted to a string automatically.
