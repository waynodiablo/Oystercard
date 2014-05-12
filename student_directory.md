# The Basics: Student Directory

In this week we are aiming to get you ready with a lot of basic concepts and practices that will be the base for your further development as a web developer. Although they might look simple, it is really important that you grasp these concepts.

Each week we will be working on a project that will solidify your understanding of the techniques and practices you'll be learning day by day; this week we are going to build a simple terminal based student directory.

Make sure that you go through the **[knowledge pills](https://github.com/makersacademy/course/blob/master/pills.md) (:pill:)** when you struggle.

## Overview

The goal of this tutorial is not only to show you the Ruby code that you'll need to write (that's the easy bit) but to show you the process of creating a project from scratch. Most importantly we'll explain what to do, in what order and why do it at all.

**It will have the following features:**

- Show the list of all students
	- ordered by name
	- grouped by cohort (as an exercise)
- Add new students by asking the user to input the names
- Show information about a given student
- Add information related to a particular student (e.g. hobbies)
- Interactive menu to ask the user what he or she would like to do
- Displaying aggregate info (statistics)
- Saving this data to a file
- Loading it from the file

The script will be invoked from the command-line and it will only use pure Ruby, that is, there will be no external libraries to use. It will have text-based interface that will not look particularly exciting but it's really important to understand how to build basic things before trying to create sophisticated websites.

## Version 0: Setting up your environment

First, open the terminal and navigate to your project directory. Then create a new directory called "student-directory" (:pill: [The command line](https://github.com/makersacademy/course/blob/master/pills/command_line.md)), change into it and initialise it as an empty git repository (:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)).

![terminal](https://github.com/makersacademy/course/raw/master/student_directory/images/term.png)

It makes sense to keep all projects you'll be working on in a designated project directory (and not on desktop, for example).

We always begin a new project (unless it's a throwaway code that will not live until tomorrow) by initialising a new repository. 

**Now let's create a repository on Github!**

![new repo](https://github.com/makersacademy/course/raw/master/student_directory/images/new_github_repo.png)

Make it public, name it "student-directory" (it's usually a good idea to use the same name for Github repos and local folders) but don't initialise it with a README – we'll do it manually. This is what your repo will look like right after it's created.

![new repo created](https://github.com/makersacademy/course/raw/master/student_directory/images/new_github_repo_created.png)

Let's now initialise the repo with a README file and create a local remote ( :pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)). Github gives you steps required to do it:

````
touch README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin git@github.com:makersacademy/student-directory.git
git push -u origin master
````

**Don't copy-paste them, though. Type everything in, it's really important to remember everything. If you copy-paste code, you may as well skip the exercise altogether.**

Typing everything in also forces you to think about what exactly is going on. For example, what about the `git init` command? Is it really necessary here, given that we've already initialised the repo? Maybe not.

![git push](https://github.com/makersacademy/course/raw/master/student_directory/images/git_push.png)

Once you do it, refresh the Github page. It should show an empty repo (with the README.md file only).

![new repo readme](https://github.com/makersacademy/course/raw/master/student_directory/images/new_github_repo_readme.png)

Good, now we have an empty repo with a remote called "master" pointing to Github. This is the basic groundwork you need to do before creating any new project.

Note how Github displays the contents of the `README.md` file on your project page (it's empty now but you can still see it below the file list). This is because the file is named README, it's the default name for the file that has information about the project. The "md" extension means that the format of this file is [markdown](http://daringfireball.net/projects/markdown/basics). We'll write some [markdown](http://daringfireball.net/projects/markdown/basics) soon.

Let's start SublimeText now. You should be able to do this by running `subl .` in the project directory (note there's a space between `subl` and the dot). The dot stands for the current directory (:pill: [The command line](https://github.com/makersacademy/course/blob/master/pills/command_line.md)) and `subl` is the shortcut that the developers often create for SublimeText. If you don't have it ( _that is, if you get an error message when trying to run the command_), you probably don't have this shortcut set up (:pill: [Sublime Text](https://github.com/makersacademy/course/blob/master/pills/sublime_text.md)).

After you launch SublimeText, it should look like this.

![sublime](https://github.com/makersacademy/course/raw/master/student_directory/images/sublime.png)

If you don't see the list of files and folders on the left, select View → Sidebar → Show Open Files.

Let's now write a description for the project. This is a good idea because it will let other developers to quickly see what the codebase does. Every good project on Github has a good `README` file.

![readme](https://github.com/makersacademy/course/raw/master/student_directory/images/readme.png)

This README file is written using [Github-flavoured markdown](https://help.github.com/articles/github-flavored-markdown). Take a look the both the [markdown reference](http://daringfireball.net/projects/markdown/basics) and the [Github-flavoured markdown](https://help.github.com/articles/github-flavored-markdown) reference so that you know what's possible.

Then, write your README file (you don't have to use the same we used), commit the changes and push to Github to see what it looks like there.

![gitconfig](https://github.com/makersacademy/course/raw/master/student_directory/images/git_config.png)

If you get the **"push.default is unset"** warning, like in the screenshot above, just choose the `simple` mode as the default.

````
git config --global push.default simple
````

There's an [explanation on StackOverflow](http://stackoverflow.com/questions/11872984/what-is-the-difference-between-git-push-default-current-and-push-default-upstrea) of what this warning means. Don't worry if it sounds a bit cryptic right now.

After we push the README file, we'll see it on Github.

![studentreadme](https://github.com/makersacademy/course/raw/master/student_directory/images/student_directory_readme.png)

Now we have a local and and a remote repo with a README file that describes the project we're about to create.

Throughout this and future tutorials we will be giving links to specific commits on Github that correspond to the relevant section of the tutorial. So, if you would like to see what the code looks like at this stage of the tutorial, [follow this link](https://github.com/makersacademy/student-directory/tree/f68074835a0eb6587bbd0064df05a52f0f0c3cb9).

## Version 1: Printing the list of students

Let's now write some Ruby code. First, create a file called directory.rb in the project directory by using the "touch" command (:pill: [The command line](https://github.com/makersacademy/course/blob/master/pills/command_line.md)). Don't forget the extension (".rb") and don't put any spaces in the filename.

![touch](https://github.com/makersacademy/course/raw/master/student_directory/images/touch.png)

Now you should see the empty file in SublimeText.

![directoryrb](https://github.com/makersacademy/course/raw/master/student_directory/images/directoryrb.png)

Find out the names of the students in your cohort (great excuse to say hello to everyone again and have a little chat!) and print them all. I'll just use fictional names here. 

**Reminder: do not copy-paste the code! Always type everything yourself.**

````ruby
puts "The students of my cohort at Makers Academy"
puts "-------------"
puts "Dr. Hannibal Lecter"
puts "Darth Vader"
puts "Nurse Ratched"
puts "Michael Corleone"
puts "Alex De Large"
puts "The Alien"
puts "Terminator"
puts "Freddy Kruger"
puts "The Joker"
````

Now save the file and run it by passing the filename as an argument to ruby.

![directoryexec](https://github.com/makersacademy/course/raw/master/student_directory/images/directoryexec.png)

You should see all names printed on the screen. If you get an error, it may look like this.

````ruby
directory.rb:7: syntax error, unexpected tCONSTANT, expecting end-of-input
puts "Alex De Large"
          ^
````

Here, Ruby gives you the name of the file ("directory.rb"), the line where the error occurred (7), specifics of the problem ("syntax error, unexpected tCONSTANT, expecting end-of-input") and the line that causes the error (`puts "Alex De Large"`). Finally, it uses the caret (^) symbol to show where exactly the problem lies. In this case I caused this problem to happen by "accidentally" using an single quote instead of a double quote on the previous line. So Ruby assumed the string from the previous line continued until the first double quote on this line. After that Ruby decided that "Alex" is not part of the string (because it had just been closed), so it must be part of the program. However, we don't have a variable called Alex, so Ruby got confused and threw an error, letting us know that it has no idea what "Alex" is. All because I _accidentally_ used a single quote instead of a double quote.

Let's do two things now. Firstly, we need to commit the change. Secondly, we'll discuss what exactly this code does.

We need to commit the change because we've just done a small but meaningful piece of work. Every time you do finish a small task, you need to commit your code. What is a small task? There's no fast and easy rule but there are a few rules of thumb you can use.

It's a good idea to commit code once a specific change was introduced to the codebase and this change is finished. For example, we've just put a list of students in the codebase. We are happy with the codebase as it is right now because it works. A bad time to commit the code would be when the code is broken (it throws an error) or half-finished (you haven't double-checked the spelling yet, for example).

![git push2](https://github.com/makersacademy/course/raw/master/student_directory/images/git_push_2.png)

Now, what does the code do? Every puts statement prints a line of text in the terminal. More precisely, it prints it to the standard output (:pill: [The command line](https://github.com/makersacademy/course/blob/master/pills/command_line.md)).

`puts` itself is a method provided by Ruby. The string after every `puts` is an argument. In Ruby we can use parentheses around arguments but it's not mandatory (:pill: [Methods](https://github.com/makersacademy/course/blob/master/pills/methods.md)). So, another way of writing the same code would be

````ruby
puts("The students of my cohort at Makers Academy")
puts("-------------")
puts("Dr. Hannibal Lecter")
puts("Darth Vader")
puts("Nurse Ratched")
puts("Michael Corleone")
puts("Alex De Large")
puts("The Alien")
puts("Terminator")
puts("Freddy Kruger")
puts("The Joker")
````

The method "puts" adds a line return after printing each argument. It's invisible but it causes the "cursor" to wrap onto the next line. That's why every name is printed on a new line. What if we didn't want the line to be wrapped automatically? Ruby provides a method "print" that's just like "puts" except it doesn't wrap the line. Add this code to the end of your Ruby file:

````ruby
print "Overall, we have "
print 9
puts " great students"
````

Note how the lines don't wrap if we use "print".

````
ruby directory.rb
The students of my cohort at Makers Academy
-------------
Dr. Hannibal Lecter
Darth Vader
Nurse Ratched
Michael Corleone
Alex De Large
The Alien
Terminator
Freddy Kruger
The Joker
Overall, we have 9 great students
````

If you want to put the line break character manually, you can do it like this:

````
print "line1\nline2\nline3" # has to be in double quotes!
````

The "\n" is an escape sequence ( _[There are many more of them](http://en.wikibooks.org/wiki/Ruby_Programming/Strings#Escape_sequences)_).

So, now that we added the student count, let's commit it again.

![git push3](https://github.com/makersacademy/course/raw/master/student_directory/images/git_push_3.png)

If you would like to see what the code looks like at this stage of the tutorial, [follow this link](https://github.com/makersacademy/student-directory/tree/eff34bdc6aa33810178b6dac18bbe7e917523fef).

Let's now add some comments to our Ruby code as well.

````ruby
#first we print the list of students
puts "The students of my cohort at Makers Academy"
puts "-------------"
puts "Dr. Hannibal Lecter"
puts "Darth Vader"
puts "Nurse Ratched"
puts "Michael Corleone"
puts "Alex De Large"
puts "The Alien"
puts "Terminator"
puts "Freddy Kruger"
puts "The Joker"
#finally, we print the total
print "Overall, we have "
#it’s important that print() doesn’t add new line characters
print 9
puts " great students"
````

And let's commit the code again, just for practice (don't forget to add a meaningful commit message).

If you would like to see what the code looks like at this stage of the tutorial, [follow this link](https://github.com/makersacademy/student-directory/tree/44f6e11c888d45931e802bc5da082e97eeed2046).

## Version 2: Refactoring (cleaning the code)

Refactoring is the process of improving the code without changing what it does. Let's make our code slightly better by introducing a variable instead of a number on line 16. Why? It's more descriptive. It may not matter much in such a simple example but in a more complex programs numbers numbers used on their own may be a source of confusion. There's a good discussion of these numbers (called magic numbers) and a few code examples in [Wikipedia](http://en.wikipedia.org/wiki/Magic_number_(programming)).

So, let's extract the number 9 into a variable. Define it at the beginning of the file

````ruby
student_count = 9
````

and print it instead of the raw number

````ruby
print student_count
````

Now your code looks like this.

````ruby
		student_count = 9
		# first, we print the list of students
		puts "The students of my cohort at Makers Academy"
		puts "-------------"
		puts "Dr. Hannibal Lecter"
		puts "Darth Vader"
		puts "Nurse Ratched"
		puts "Michael Corleone"
		puts "Alex De Large"
		puts "The Alien"
		puts "Terminator"
		puts "Freddy Kruger"
		puts "The Joker"
		# finally, we print the total
		print "Overall, we have "
		# it's important that print() doesn't add new line characters
		print student_count
		puts " great students"
````

Now line 17 clearly communicates what it does. Let's reduce the line count by two by using interpolation (:pill: [String interpolation](https://github.com/makersacademy/course/blob/master/pills/string_interpolation.md) ). Replace the last three lines with this.

````ruby
 # finally, we print the total
puts "Overall, we have #{student_count} great students"
````

Now our code is both shorter and more expressive than it was before. Good time to commit it.

If you would like to see what the code looks like at this stage of the tutorial, [follow this link](https://github.com/makersacademy/student-directory/tree/d47b0fa16e4e0c62c7194a3cbb49274dd509c6fd).

## Version 3: Arrays

Our code works but it's not perfect. There are two problems here. Firstly, it's repetitive. The same operation – printing the student name – is repeated several times. Every time you see any kind of repetition in code, try to eliminate it because it will result in a hard to maintain code at best or be a source of nasty bugs at worst. For example, if we want to add one more student to our program, do we really have to type "puts" again? What if we had a thousand students? Oh, and we'll need to manually update `student_count`. That's a big red flag.

Secondly, the data (student names) is tightly coupled with what we do with this data (printing it). What if we wanted to change the way the students are printed, for example putting a number in front of the name? That'd mean updating every single line that prints a student name. What if we wanted to print the list twice: first in alphabetical order, then in reverse order? You can see how quickly it can all go wrong.

Arrays (:pill: [Arrays](https://github.com/makersacademy/course/blob/master/pills/arrays.md) ) will help us avoid both of these problems. Let's start by putting the students into an array. Remember, don't copy-paste, type everything in yourself, it's important. Make sure you understand every line here: _if you don't, talk to other students or the coaches_.

````ruby
		student_count = 9
		# let's put all students into an array
		students = [
		  "Dr. Hannibal Lecter",
		  "Darth Vader",
		  "Nurse Ratched",
		  "Michael Corleone",
		  "Alex De Large",
		  "The Alien",
		  "Terminator",
		  "Freddy Kruger",
		  "The Joker"
		]
		# and then print them
		puts "The students of my cohort at Makers Academy"
		puts "-------------"
		puts students[0]
		puts students[1]
		puts students[2]
		puts students[3]
		puts students[4]
		puts students[5]
		puts students[6]
		puts students[7]
		puts students[8]
		# finally, we print the total
		puts "Overall, we have #{student_count} great students"
````

It still does exactly the same thing as before. However, if still suffers from the same problems that we discussed above. Why did we put the students into an array then? Because now we can actually improve our code.

Let's start with a student count. Now that our students are in an array, we can use the array's length() method to count them instead of doing it manually. Get rid of the `student_count` variable and update the last line:

````ruby
		puts "Overall, we have #{students.length} great students"
````

Now if we put one more student in the array, we won't have to update the `student_count` variable. That's really good news.

What about the repetition? There's a way to print every value in the array without referring to each value individually. We will discuss how it actually works early next week in Ruby 3 but for now you can learn how to do it even if you don't understand everything that's going on behind the scenes.

Doing some operation on every value of an array is called iterating. One such operation is called an iteration. So if we need to print every value of an array, we need to iterate over this array and print the current value on every iteration. Makes sense? Let's see what the code would look like. Instead of `puts students[0]` ... `puts students[8]` you can do this:

````ruby
		students.each do |student|
		  puts student
		end
````

We'll discuss exactly how this works in Ruby 3, as promised, but for now just understand what it does. This code takes every name from the array `students` and for each name it executes the block of code between `do` and `end`. Every execution of this block of code is called an iteration. On every iteration, the current name will be assigned to the value `student` that we specified between two vertical bars.

So, on the very first iteration, it will take the first value from the array ("Dr. Hannibal Lecter") and assign it to the variable `student`. Then, it will execute the block of code (`puts student`) that will print it to the screen. Since "Dr. Hannibal Lecter" is not the last person in our array of charming students, Ruby will perform the second iteration, assigning the value of "Darth Vader" to the variable `student` and printing it again.

Now our program is much shorter.

````ruby
		# let's put all students into an array
		students = [
		  "Dr. Hannibal Lecter",
		  "Darth Vader",
		  "Nurse Ratched",
		  "Michael Corleone",
		  "Alex De Large",
		  "The Alien",
		  "Terminator",
		  "Freddy Kruger",
		  "The Joker"
		]
		# and then print them
		puts "The students of my cohort at Makers Academy"
		puts "-------------"
		students.each do |student|
		  puts student
		end
		# finally, we print the total
		puts "Overall, we have #{students.length} great students"
````

By doing this we have solved two problems. Firstly, we separated the data (the array) from the operation on this array (line 17). This means that if we want to print this array again, it's very easy to do. It also means that if we want to add one more student, we won't have to do anything other than adding one more name to the array. On top of that, we could get rid of the `student_count` variable.

Secondly, we got rid of the repetition. This means that if we want to change the way this array is printed, there's only one line to update, line 17.

It's certainly a good time to commit the code.

If you would like to see what the code looks like at this stage of the tutorial, [follow this link](https://github.com/makersacademy/student-directory/tree/a08bb43b1ba0f4304ff6602daf8cdf92cec70020).

## Version 4: Methods

Remember we discussed methods (:pill: [methods](https://github.com/makersacademy/course/blob/master/pills/methods.md) )? Let's create a few methods to make our program easier to read.

````ruby
		# let's put all students into an array
		students = [
		  "Dr. Hannibal Lecter",
		  "Darth Vader",
		  "Nurse Ratched",
		  "Michael Corleone",
		  "Alex De Large",
		  "The Alien",
		  "Terminator",
		  "Freddy Kruger",
		  "The Joker"
		]
		
		def print_header
		  puts "The students of my cohort at Makers Academy"
		  puts "-------------"
		end
		
		def print(names)
		  names.each do |name|
		    puts name
		  end
		end
		
		def print_footer(names)
		  puts "Overall, we have #{names.length} great students"
		end
		
		# nothing happens until we call the methods
		print_header
		print(students)
		print_footer(students)
````

Let's start by discussing why we've done it in the first place and then talk about how it works.

Now that we have extracted the code into the methods, the body of our program reads almost like English. First, we print the header. Then we print the list of students. Finally, we print the footer. It's easy to see what's going on without looking at the implementation.

Note that we are now passing the students variable to the methods as an argument (called "names" in both cases). This is because the methods don't have access to local variables defined outside them, so we couldn't have references `students`. In any case, in most cases it's a good idea to pass the data the a method needs as an argument to make the code easier to understand.

Let's check the code in. Are you using good commit messages?

If you would like to see what the code looks like at this stage of the tutorial, [follow this link](https://github.com/makersacademy/student-directory/tree/d8a01783d4c57379cb95160456fc830d45a42b55).




## This lessons knowledge pills
:pill: [The command line](https://github.com/makersacademy/course/blob/master/pills/command_line.md)

:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)

:pill: [Sublime Text](https://github.com/makersacademy/course/blob/master/pills/sublime_text.md)

:pill: [Ruby: variables](https://github.com/makersacademy/course/blob/master/pills/variables.md)

:pill: [Ruby: introducing irb](https://github.com/makersacademy/course/blob/master/pills/irb.md)

:pill: [Ruby: creating ruby files](https://github.com/makersacademy/course/blob/master/pills/files.md)

:pill: [Ruby: Strings](https://github.com/makersacademy/course/blob/master/pills/strings.md)

:pill: [Ruby: Interacting with the users](https://github.com/makersacademy/course/blob/master/pills/command_line.md)

:pill: [Ruby: True, False and nothing](https://github.com/makersacademy/course/blob/master/pills/boolean.md)

:pill: [Ruby: Methods](https://github.com/makersacademy/course/blob/master/pills/methods.md)

:pill: [Ruby: Arrays](https://github.com/makersacademy/course/blob/master/pills/array.md)

:pill: [Ruby: Hashes](https://github.com/makersacademy/course/blob/master/pills/hash.md)

:pill: [Ruby: Symbols](https://github.com/makersacademy/course/blob/master/pills/symbols.md)

:pill: [Ruby: Control Flow](https://github.com/makersacademy/course/blob/master/pills/control_flow.md)

:pill: [Behaviour Driven Development with RSpec](https://github.com/makersacademy/course/blob/master/pills/rspec.md)
