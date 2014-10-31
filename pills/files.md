# Interacting with files in Ruby

Interacting with files in Ruby can come in handy. For instance, if you are writing a program to manage Boris Bikes, you might want to keep a log of all rented bikes. So each time someone rents a bike, the rental information will be added to a bike log, then if an admin wants to check the log he can call a method that will display the contents of the bike log.

## Creating files

So as a first step, we want to create our bike log file in Ruby. To do that, we are going to call the new method on the File class. The File class already exists in Ruby, and just like you can write a Bike class and create an instance of it using `Bike.new`, you can create a new instance of a file by calling `File.new`.

The one difference here is that when you use the .new method on the File class, you need to pass it two arguments: the name of the file and the mode in which it should be opened.

Here are the different modes that are available:
* r  : read only access
* r+ : read and write access
* w  : write only access
* w+ : read and write access
* a  : append mode; like w it is write only access, but pointer is positioned at the end of file instead of the beginning
* a+ : append mode; like w + it is read and write access, but pointer is positioned at the end of file instead of the beginning

So what should we use for our bike log? Well we want to be able to write the info of each new rental in our log, and we want the pointer to be positioned at the beginning of the file, so let's create our bikelog class:


```
class Bikelog

	def create_bike
	bike_log = File.new("bike_log.txt", "w+")
	end
end
```
We have also assigned the new file the instance variable bike_log by adding `bike_log=` in front of it, so we can refer to it easily afterwards if needed. 

## Opening files

Opening a file is exactly the same as creating a file, except we use the .open method instead of the .new one. So to write the method that allows ruby to open and access the file for writing, we would use: `bike_log.open("bike_log.txt", “w”)`.

This allows Ruby to access the information in the file and do stuff with it. And that stuff can be a lot of things, which you will write as a block of code to follow the open method. For instance, you could…

## Append data to a file
…append to a file by adding the information about each rental to the bike_log document. How do we go about that?

```	
	def add_rental (name,date)
	File.open("bike_log.txt", "a") { |file| file.puts "Name: #{name}, Date: #{date}"}
	end
```

So our `add_rental` method takes the name of the renter as an argument, as well as the date of rental. We append these bits of information to our empty file “bike_log.txt” by using a block that will print the information through string interpolation to the file. That information will be added to the end of the file because we are using “a” when we open the file, which places the cursor at the end of the file. 

Once you have added that method to your Bike class, open pry or irb and use the add_rental method to add a few lines to your bike_log.txt (see the bottom of the page for guidance if needed).

Fyi, you could also use the shovel operator to append text:
```
File.open("bike_log.txt", "a") { |file| file << "Name: #{name}, Date: #{date}"}
```
And the shovel operator with \n to write multiple lines:
```
File.open("bike_log.txt", "a") { |file|
				file << "Name: #{name}\n”
				file << “Date: #{date}\n”
				}
```
## Reading from a file

So you know how to open a file, but that won’t literally open the bike_log file for you to read, it just opens it for Ruby to look at, but Ruby doesn’t do anything with it.

So if you, the human, want to look at the file, you have to ask Ruby to show it to you. Let’s create a check_log method. 

```
def check_log
File.open("bike_log.txt", "r") { |f| File.readlines("bike_log.txt")}
end
```

Here we open our file in read mode, then pass a block asking Ruby to read each line of the file bike_log.txt. Try calling it in pry and you will see Ruby printing all the lines of your bike log.

## Writing to files
You can also overwrite the whole of the content of the existing bike_log. Say you want to hack into the bike log programme and replace the contents of the bike_log with silly puns, you could rewrite over your bike_log to change the data.

```
def hack
File.open("bike_log.txt", 'w') { |file| file.write("Name: Tex Ass, Date: Fursday") }
end
```
If you then run `.check_log` on your bike log, you will see the data has been replaced

## NB. How to check the program out in pry or irb

To try this out in pry or irb, run in the command line:
```
pry (or irb
‘require ./bike_log.rb’
b = Bikelog.new
b.add_rental(“Enrique”,”February”)
b.add_rental(“Tatiana”,”August”)
b.check_log
b.hack
b.check_log
exit
```
 
