# Asking for user input

What if you want to get some information from the user? Ruby makes it easy for you by providing a method that does just this. Try to run this program from the terminal (don't run it from SublimeText because its console is not interactive):

````ruby
puts "Hello! What's your name?"
name = gets
puts "Nice to meet you #{name.chomp}. What day of the week is it today?"
day = gets
puts "It's great that you're coding on #{day.chomp}"
````

````
ruby gets.rb
Hello! What's your name?
Evgeny
Nice to meet you Evgeny. What day of the week is it today?
Tuesday
It's great that you're coding on Tuesday
````

So, what's happening here? The gets() method is the opposite of puts(). Instead of printing things on the screen, it waits for the user input and returns it to your Ruby program. So on line two we're asking the user to enter the name and save it to the `name` variable.

What's going on on line 3 with `name.chomp`? Well, when you enter your name, you hit the return key at the end to let the computer know that you're done. Technically, this return key is also part of the input, so if I entered "Evgeny" in the terminal and hit return, the `name` variable will be "Evgeny\n", where \n is the escape sequence corresponding to the return key.

However, we don't want to print this return key on line 3. Otherwise the text will wrap to the next line right before the dot. The [chomp() method](http://ruby-doc.org/core-2.0.0/String.html#method-i-chomp) removes the trailing \n and or \r characters, returning only what you typed before hitting the return key. We do the same on line 5 as well.

