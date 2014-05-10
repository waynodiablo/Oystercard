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

Let's start SublimeText now. You should be able to do this by running `subl .` in the project directory (note there's a space between `subl` and the dot). The dot stands for the current directory (:pill: [The command line](https://github.com/makersacademy/course/blob/master/pills/command_line.md)) and `subl` is the shortcut that the developers often create for SublimeText. If you don't have it ( _that is, if you get an error message when trying to run the command_), you probably don't have this shortcut set up (:pill: [Sublime Text](https://github.com/makersacademy/course/blob/master/pills/sublime.md)).

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

`puts` itself is a method provided by Ruby. The string after every `puts` is an argument. In Ruby we can use parentheses around arguments but it's not mandatory (:pill: [Ruby: Methods](https://github.com/makersacademy/course/blob/master/pills/methods.md)). So, another way of writing the same code would be

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
````

If you want to put the line break character manually, you can do it like this:

````
print "line1\nline2\nline3" # has to be in double quotes!
````

The "\n" is an escape sequence ( _[There are many more of them](http://en.wikibooks.org/wiki/Ruby_Programming/Strings#Escape_sequences)_).

So, now that we added the student count, let's commit it again.

## This lessons knowledge pills
:pill: [The command line](https://github.com/makersacademy/course/blob/master/pills/command_line.md)

:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/pills/git.md)

:pill: [Sublime Text](https://github.com/makersacademy/course/blob/master/pills/sublime.md)

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
