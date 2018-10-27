# Exceptions

[Exceptions](http://www.ruby-doc.org/core-2.1.1/Exception.html) are situations when something goes wrong in your Ruby code. You saw them several times by now. For example, if you try to call a method that doesn't exist, you'll get an [exception](http://www.ruby-doc.org/core-2.1.1/Exception.html):

````ruby
[1,2,3].nonexistent #=> NoMethodError: undefined method `nonexistent'
````

Or, if you try to divide by zero, you'll get an error:

````ruby
15 / 0 #=> ZeroDivisionError: divided by 0
````

Whenever an [exception](http://www.ruby-doc.org/core-2.1.1/Exception.html) is encountered (or, thrown, or raised) your program terminates. `irb` just terminates the current command but if an [exception](http://www.ruby-doc.org/core-2.1.1/Exception.html) is thrown while your ruby file is running, the execution will terminate on the spot. If an [exception](http://www.ruby-doc.org/core-2.1.1/Exception.html) is thrown when a web page is served, you'll get an [error page](https://www.google.co.uk/search?q=error+page&um=1&ie=UTF-8&hl=en&tbm=isch&source=og&sa=N&tab=wi&ei=HpcsUrmbJKid7Qb8-4CABA&biw=1920&bih=1083&sei=H5csUqL5L7Gf7Abax4HIDw#hl=en&q=500+error+page&tbm=isch&um=1).

Every time an exception happens, Ruby creates an [exception object](http://www.ruby-doc.org/core-2.1.1/Exception.html). Like any other object, it is an instance of some class, for example [RuntimeError](http://www.ruby-doc.org/core-2.1.2/RuntimeError.html) or [ZeroDivisionError](http://www.ruby-doc.org/core-2.1.2/ZeroDivisionError.html).

[Exceptions](http://www.ruby-doc.org/core-2.1.1/Exception.html) are very useful for controlling the flow of the program. Let's say you decided to save some data to a file:

````ruby
file = File.open('data.txt', 'w')
file.puts(my_data)
file.close
# now let's email the user saying that the data was saved
send_email('user@mail.com', "You data was saved to the file")
````

What happens if your disk happens to be full and the file cannot be written? The `file.puts()` method will throw an [exception](http://www.ruby-doc.org/core-2.1.1/Exception.html) and the program will terminate. This is good because this will prevent the email from being sent to the user, notifying her about the success of the operation whereas it, in fact, failed.

But this is bad because your program will crash and you won't have a chance to fix the error (maybe if there's no space on the disk, the data should be sent by email). To fix this, you need to be ready for this [exception](http://www.ruby-doc.org/core-2.1.1/Exception.html). If you tell Ruby to expect it, it won't let your program crash. At the same time your code will know that something went wrong.

````ruby
begin
  file = File.open('data.txt', 'w')
  file.puts(my_data)  
rescue # this section is executed if there WAS an exception
  send_email('user@mail.com', "Couldn't save the file, sorry")
ensure # this section is ALWAYS executed
  file.close
end
````

So, this code will handle the problematic code much better. If everything goes well, the data will be written and then the execution will jump to `ensure` block and close the file. If something goes wrong, then the execution will go to the `rescue` block and the `ensure` block will never be executed. 

How do you know what [exception](http://www.ruby-doc.org/core-2.1.1/Exception.html) was raised, though? What if many things can go wrong in our code? We can write several rescue sections for different [exception](http://www.ruby-doc.org/core-2.1.1/Exception.html).

````ruby
begin
  value = 100 / user_input # potential division by zero
  file.puts(value) # potential failure to write to file
rescue ZeroDivisionError => e # the exception that you expect
  puts e.message # this contains the description of the error
rescue # all other exceptions
  puts 'something else went wrong'
end
````

How do you raise an exception? It's simple enough:

````ruby
raise # raise a RuntimeError exception without a message
raise "sorry, something went wrong" # a RuntimeError with a message
raise SecurityError # a specific exception type: SecurityError
````

How to use them? Let's say you're writing a class to manage a car park. When you initialize it, it expects the number of parking places as a parameter.

````ruby
car_park = CarPark.new(200)
````

A naive implementation may look like this:

````ruby
class CarPark
  def initialize(spaces)
    @spaces = spaces
  end
end
````

What happens if you pass a negative value as the number of spaces? A good solution would be to raise an [ArgumentError](http://ruby-doc.org/core-2.1.2/ArgumentError.html) exception.

````ruby
class CarPark
  def initialize(spaces)
    if spaces <= 0
      raise ArgumentError, "Negative number of parking spaces"
    end
    @spaces = spaces
  end
end
````

This way, you won't be able to initialise an instance of CarPark with negative number of spaces.

````ruby
car_park = CarPark.new(-200) #=> ArgumentError: Negative number of parking spaces
````

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/exceptions.md)
