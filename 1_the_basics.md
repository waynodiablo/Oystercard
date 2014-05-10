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

First, open the terminal and navigate to your project directory. Then create a new directory called "student-directory" (:pill: [The command line](https://github.com/makersacademy/course/blob/master/unix/command_line.md)), change into it and initialise it as an empty git repository (:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/unix/git.md)).

![terminal](https://github.com/makersacademy/course/raw/master/images/term.png)

It makes sense to keep all projects you'll be working on in a designated project directory (and not on desktop, for example).

We always begin a new project (unless it's a throwaway code that will not live until tomorrow) by initialising a new repository. 

**Now let's create a repository on Github!**

![new repo](https://github.com/makersacademy/course/raw/master/images/new_github_repo.png)

Make it public, name it "student-directory" (it's usually a good idea to use the same name for Github repos and local folders) but don't initialise it with a README – we'll do it manually. This is what your repo will look like right after it's created.

![new repo created](https://github.com/makersacademy/course/raw/master/images/new_github_repo_created.png)

Let's now initialise the repo with a README file and create a local remote(:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/unix/git.md)). Github gives you steps required to do it:

````
touch README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin git@github.com:makersacademy/student-directory.git
git push -u origin master
````

Don't copy-paste them, though. Type everything in, it's really important to remember everything. If you copy-paste code, you may as well skip the exercise altogether. Typing everything in also forces you to think about what exactly is going on. For example, what about the `git init` command? Is it really necessary here, given that we've already initialised the repo? Maybe not.

![git push](https://github.com/makersacademy/course/raw/master/images/git_push.png)

## This lessons knowledge pills
:pill: [The command line](https://github.com/makersacademy/course/blob/master/unix/command_line.md)

:pill: [Version Control with Git](https://github.com/makersacademy/course/blob/master/unix/git.md)

:pill: [Ruby: variables](https://github.com/makersacademy/course/blob/master/ruby/variables.md)

:pill: [Ruby: introducing irb](https://github.com/makersacademy/course/blob/master/ruby/irb.md)

:pill: [Ruby: creating ruby files](https://github.com/makersacademy/course/blob/master/ruby/files.md)

:pill: [Ruby: Strings](https://github.com/makersacademy/course/blob/master/ruby/strings.md)

:pill: [Ruby: Interacting with the users](https://github.com/makersacademy/course/blob/master/ruby/command_line.md)

:pill: [Ruby: True, False and nothing](https://github.com/makersacademy/course/blob/master/ruby/boolean.md)

:pill: [Ruby: Methods](https://github.com/makersacademy/course/blob/master/ruby/methods.md)

:pill: [Ruby: Arrays](https://github.com/makersacademy/course/blob/master/ruby/array.md)

:pill: [Ruby: Hashes](https://github.com/makersacademy/course/blob/master/ruby/hash.md)

:pill: [Ruby: Symbols](https://github.com/makersacademy/course/blob/master/ruby/symbols.md)

:pill: [Ruby: Control Flow](https://github.com/makersacademy/course/blob/master/ruby/control_flow.md)

:pill: [Behaviour Driven Development with RSpec](https://github.com/makersacademy/course/blob/master/ruby/rspec.md)
