#Command Line

Welcome to the first lesson on your path to becoming a web developer.

Learning how to use the command line is an essential skill for any developer. You'll learn many things in upcoming lessons that will be much easier to grasp once you understand how to use the command line. From using git to running your code through the terminal, it's critical that you understand how it works.

We start with learning the command line, also known as the terminal, because it's the essential tool all developers use to interact with the computer. If you think about when you learned math at school, you wouldn't be able to understand algebra if you didn't understand multiplication – this is the same principle.

You're not required to know everything about the command line by the end of this lesson, it's merely meant as a brief introduction to give you a basic understanding and to show you where to look for future reference.


## Command Line - Introduction

### Mac vs PC

Before we dive into using the command line, it's important to discuss the distinction between using a UNIX-based computer (Mac, any Linux including Ubuntu, etc.) or a PC running Windows. In these lessons, we're assuming you're using a Mac as it's the most common platform among web developers. With the technologies we cover in Atlas – a Mac is the tool of choice. If absolutely required, you can use Ubuntu, but you may encounter minor problems along the way that we won't cover in Atlas. This does not imply that Mac is somehow superior to Linux when it comes to web development. It is simply different, so the instructions provided for a Mac may not always work on a different system.

### What is the command line?

So what is the command line exactly? The command line is how we interact directly with the underlying code of our computer. Every computer has some way of accessing the command line. In fact, the command line is the primary interface that your computer uses. The graphical user interface (all the beautiful windows you can open) is just a more accessible way of using your computer that is often but not always available. Servers, for example, often don't have graphical interface at all, so command line is the only way to work with them.

Using the command line on a Mac is done through the "Terminal" application. You can find it using Spotlight (the built-in search functionality in OSX). Press this combination:

`⌘ + Space Bar`

This will open Spotlight in the upper-right corner of the screen. Search for "Terminal" and scroll down until you find it, select it and hit enter.

The terminal application will open and you'll see something like this:

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380900937026_Screen%20Shot%202013-10-04%20at%2016.35.09.png "Bash image")

As you can see, it will show you the name of your computer ("Makers Academy laptop") and what directory you're currently in ("Desktop"), followed by the name of the currently logged in user. At the end of the prompt, you'll see a dollar sign ($). This just represents the end of the prompt so if you ever see it used as an example, it doesn't need to be typed in. 

Directories in the command line are just a different way to access the directories you already have on your computer. So, for example, you can see in the screenshot that I'm currently in the "Desktop" directory. If I were to delete a file that's in that directory from the command line, it will delete it from the user-interface that you're used to using as well.

As we progress through this lesson, please type every command into the terminal for yourself. If you simply read without doing, you're highly unlikely to remember the commands. This is a universal rule when learning how to code: try everything.

Don't forget that if you can access the history of your commands by pressing up and down arrows, so if you want to run the command you type a minute ago, just press the up arrow until you see it.

Now that you have the Terminal open, I recommend right clicking on the icon and selecting Options → Keep in Dock. We'll be using the terminal a lot so you want easy access to it.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901047979_Screen%20Shot%202013-10-04%20at%2016.37.09.png "Keep in dock")

## Command-Line  – Basic commands

### Showing the date

The command line is fairly straight-forward: you type something in and you get something back. First off, type:

`date`

This shows us today's date, time and the time zone set by your computer:

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901095456_Screen%20Shot%202013-10-04%20at%2016.38.05.png "Date")

#### Listing files

Going back to the directory discussion from earlier, we see that we're in the "Desktop" directory. How do we list all of the contents of this directory?

`ls`

This stands for "list." This command will show everything in the "Desktop" directory:
![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901340878_Screen%20Shot%202013-10-04%20at%2016.42.01.png "ls")

#### Printing working directory

We're in the "Desktop" directory, but what if we want to see the exact path of the directory that we're in?

`pwd`

This stands for "print working directory" and will give you the full path of the directory that you're working in. This is really useful for when we need to start working with file and folder locations.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901367914_Screen%20Shot%202013-10-04%20at%2016.42.32.png "pwd")

For those who many be unfamiliar with how paths work, they're identical to the way folders work in Finder. Let's say you have a "Documents" folder and inside that you might have a folder for all of your homework titled "Homework." Inside that folder you might have a separate folder for each subject. Then each subject is likely to have files. A path to a chemistry test might look like this:

` ~/Documents/Homework/Chemistry/term1test`

The tilde (~) at the beginning of the path represents your home directory (default directory for every user on this computer).

#### Changing directories

Okay, the "Desktop" directory is great, but what if I want to access other folders?

` cd ..`

The "cd" stands for "change directory" and the ".." tells us to move up to the parent directory. (Just for future reference, a "." represents "the directory I'm in" and ".." represents the parent directory.) Desktop's parent directory is usually the home directory and, as mentioned before, this is connotated by ~

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901427436_Screen%20Shot%202013-10-04%20at%2016.43.32.png "cd")

Do you remember how to list out the contents of this directory?

If you guessed "ls" you're correct.

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901465155_Screen%20Shot%202013-10-04%20at%2016.44.01.png "ls")

We can return to the "Desktop" directory now by typing:

` cd Desktop`

This is using the same "cd" command from earlier, but instead of telling it to move up to the parent directory by typing ".." we're telling it that we want to "change directory" into the "Desktop" directory. Now we're back in the "Desktop" directory:

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901492431_Screen%20Shot%202013-10-04%20at%2016.44.38.png "cd desktop")

#### Listing hidden files (using switches)

Earlier, we listed the public files in the "Desktop" folder - but what if we want to see the hidden files too:

` ls -lA `

This shows us all of the hidden files as well:

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901529371_Screen%20Shot%202013-10-04%20at%2016.45.19.png "ls -la")

In addition it shows them in the "long" format, that is, with extra information (size, creation date, owner, etc). The "-lA" parameter is actually a combination of two switches. We could have written the same command like this:

` ls -l -A `

However, if you're specifying multiple switches, you can combine them into one:

` ls -lA `

In this case, "-l" stands for "long format", and "-A" stands for all files.

#### Hidden files

Some files are hidden by default because they are used by the operating system and the users don't need to access them in most cases. However, "ls -lA" exists precisely because you'll want to access them on some occasions.

#### Creating files

While changing directories and listing contents is useful, how do we actually create files?

` touch worksheet `

The "touch" command creates an empty file with a given name. In this case it creates a file called "worksheet" in our current directory.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901727499_Screen%20Shot%202013-10-04%20at%2016.47.15.png "touch")

#### More about parameters

So far, I've shown you two examples of parameters for commands. A parameter is essentially an add-on to a command to make your instructions more specific. Earlier we showed you two ways of changing directories:

` cd .. `
` cd Desktop `

The ".." and "Desktop" are the parameters of the "change directory" command. Additionally, we showed you two "list" commands:

` ls`
` ls -lA`

The first one is simply the "list" command where as in the second one, we added the "-lA" parameter to specify that we wanted to see hidden files and we wanted the output to be in a long format. There are many parameters but for now, we'll just cover the most important ones.

The parameters that start with a hyphen (-) are often called switches.

#### Creating and destroying directories

So far all we've done is move around our file system and look at the contents. Let's now look at ways to make, move and remove files and directories. First off, let's start with:

` mkdir Example`

Any guess what this stands for? This is the "make directory" command with the added parameter of "Example" - it makes a new directory in whatever directory you're currently in with the name "Example"

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901839227_Screen%20Shot%202013-10-04%20at%2016.50.21.png "mkdir")

We can remove that directory just as easily as we created it:

` rmdir Example`

Here "rmdir" stands for "remove directory" with the parameter "Example" - telling it to remove the "Example" directory.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901863587_Screen%20Shot%202013-10-04%20at%2016.50.52.png "rmdir")

If, instead of a directory, we wanted to remove a file. We would simply use "rm" and the file name. We created an empty file using the "touch" command a while back, let's remove it now.

` rm worksheet`

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901891615_Screen%20Shot%202013-10-04%20at%2016.51.21.png "rm")

Now let's try something else. Let's create a new directory called "SomeDir," change to that directory, create an empty file  called "someFile" and then change back out to its parent directory:

` mkdir SomeDir`
` cd SomeDir`
` touch someFile`
` cd ..`

What if we wanted to remove "SomeDir"? Let's try running "rmdir" again:

` rmdir SomeDir `

What? You got an error? 

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380901939458_Screen%20Shot%202013-10-04%20at%2016.52.08.png "rmdir error")

That's because "rmdir" only works for empty directories. This is where some of those parameters will come in handy. Try this instead:

` rm -r SomeDir `

This uses the "rm" command with two parameters. The second parameter you know about. The first parameter (switch) is "-r" and tells the remove command to recursively remove all files within the directory as well as the directory itself.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902015447_Screen%20Shot%202013-10-04%20at%2016.53.19.png "rm -r")

Just to introduce you to a couple of other important "rm" parameters that you'll find useful:

` rm -i`

The "-i" parameter here stands for "interactive" and will prompt  you to confirm that you want to delete each file. This is really useful for when you have a lot of files but only want to delete a few of them.

Other times you don't care about protection and want to just force remove files. This is done with:

` rm -f`

This will remove any file even if it's "write protected".

Copying and moving files

Copying directories is quite straight-forward. Let's create a new directory, change into it and create an empty file:

` mkdir SomeDir`
` cd SomeDir`
` touch someFile`

Now, if we wanted to create an exact copy of "someFile" we'd use this command:

` cp someFile newFile`

The copy command is "cp" and takes two parameters. The first is the file to be copied and the second is the new file that will be created from it. If we list the contents of the directory now, we'll see both files:

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902096069_Screen%20Shot%202013-10-04%20at%2016.54.46.png "cp")

Now what if we wanted to move "newFile" somewhere else?

` mv newFile ../newFile`

The "mv" or "move" command takes two parameters. The first is the file to be moved (and its location) and the second is where the file will be moved to. In our situation, we didn't have to specify the path of "newFile" because it was already in our working directory, but we did need to specify the path of where we wanted to move it because it was outside of our working directory. We used ".." again, just like we did with the "cd" command, to specify that we wanted to move the file to our parent directory.

If we now change directories to the parent and list the contents, we'll see the file.

` cd ..`
` ls`

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902147077_Screen%20Shot%202013-10-04%20at%2016.55.28.png "mv")

Did you notice how I had to confirm the name "newFile" when declaring the destination as well? This means that we can actually use the "mv" command to rename files without even moving them.

Let's go back into our "SomeDir" directory to bring newFile back over and I'll show you what I mean:

` cd SomeDir`
` mv ../newFile newFile`
` ls`
![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902198448_Screen%20Shot%202013-10-04%20at%2016.56.28.png "mv 2")

If we now run "mv" without providing a new destination, we can simply rename the file:

` mv newFile newerFile`

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902216118_Screen%20Shot%202013-10-04%20at%2016.56.47.png "mv 3")

#### Viewing files

For this next section, open up a text editor. If you're using a Mac, the TextEdit application will work fine (or use Sublime Text that we'll be using for the rest of the course), but once you open the app, go to Format → Make Plain Text. Type in the following text into the document (followed by an empty new line):

` There are 10 types of people in this world`


Save the file into the "SomeDir" folder that we've been using and call it "someText"

To make sure everything worked according to plan, let's list the files in "SomeDir":

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902530774_Screen%20Shot%202013-10-04%20at%2017.02.01.png "ls")

Everything looks good, but how would we view that text document directly from the command line?

` cat someText`

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902569814_Screen%20Shot%202013-10-04%20at%2017.02.43.png "cat")

The "cat" command literally means "concatenate" (just a fancy word for "combine") as combining files is its primary purpose, but it has many other uses - such as the one I just showed you.

One of those many uses is to create short text documents right in the browser. If we type:

` cat > someMoreText`

You'll see a blinking cursor on the next line for you type some text in. Go ahead and type:

`Those who understand binary and those who don't`
`^C`

The ^C interrupts the command and is done with Ctrl+C.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902655200_Screen%20Shot%202013-10-04%20at%2017.04.03.png "cat > ")

Let's list the files again, just to make sure everything is fine:
![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902676299_Screen%20Shot%202013-10-04%20at%2017.04.19.png "cat > ls")

We can combine (or "concatenate") these two files with:

` cat someText someMoreText > combined`

Now if we view that file with:

` cat combined`

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902743304_Screen%20Shot%202013-10-04%20at%2017.05.31.png "cat combined")

Ta-da. It's magic.

#### Viewing large files

What if we need to work with larger amounts of text? Copy the following text into another text document and save it in "SomeDir" as "longText.txt"

*Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.*

*It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).*
 
*Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.*

*The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.*

*There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.*

As usual, let's double-check to make sure everything worked correctly:

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902785911_Screen%20Shot%202013-10-04%20at%2017.06.16.png "ls")

Now, type this:

` less longText.txt `

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902821716_Screen%20Shot%202013-10-04%20at%2017.06.50.png "less")

Using the "less" command, you're able to scroll up and down with your keyboard to view the entire document. When you're ready to finish viewing, just type "q"

You can also just view the first few lines of the file by using:

` head -3 longText.txt `

The "head -3" command tells the computer that we want to view the first 3 lines of the longText.txt file. You can change 3 to any number you want, depending on how much you want to view. If you leave it out, it will default to the first 10 lines.

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380902854944_Screen%20Shot%202013-10-04%20at%2017.07.25.png "head 3")

#### Tailing files

We can view the last few lines of a file just as easily with:

` tail -3 longText.txt `

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380903155155_Screen%20Shot%202013-10-04%20at%2017.12.27.png "tail")

"Tail" also has a really useful parameter that it's worth mentioning: -f. When we move along to actually running programs, you'll often want to watch the log of what's happening behind the scenes in your programming. To do this, you can use the "-f" parameter with "tail" like this:

` tail -f log.txt `

OSX, the operating system on the Mac, uses a number of log files. You can peek at what your computer is doing by running

` tail -f /private/var/log/system.log `

First you'll see the last 10 messages. If you quit or start some application, your Terminal will be updated with new messages describing what's going on. To stop tailing the log, press Ctrl-C.

#### Getting Help

There will be any number of situations where you'll have a question about what command to use or wonder what a command is truly designed for. Let's see how to handle those situations. 

` man ls `

The "man" or "manual" command takes a parameter of another command to provide you more information about it. In the example here, we want to know more about the "ls" command.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380300031530_Screen%20Shot%202013-09-27%20at%2017.40.15.png "man")

By reading through this, we can find out what all of the parameters are, the description and various other pieces of information for using it correctly.

The square brackets in synopsis mean that the parameter or switch is optional. For example, in case of less, you can omit any switch because all of them are shown in square brackets. The same applies to the file(s) that should be given after the switches: if you specify the directory or file name, it will be listed but if you don't, current directory will be used by default. Finally, three dots at the end of the synopsis mean that you can specify one or more files to list.












