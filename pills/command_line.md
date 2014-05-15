#Command Line

Welcome to the first lesson on your path to becoming a web developer.

Learning how to use the command line is an essential skill for any developer. You'll learn many things in upcoming lessons that will be much easier to grasp once you understand how to use the command line. From using git to running your code through the terminal, it's critical that you understand how it works.

We start with learning the command line, also known as the terminal, because it's the essential tool all developers use to interact with the computer. If you think about when you learned math at school, you wouldn't be able to understand algebra if you didn't understand multiplication – this is the same principle.

You're not required to know everything about the command line by the end of this lesson, it's merely meant as a brief introduction to give you a basic understanding and to show you where to look for future reference.


## Command Line - Introduction

### Mac vs PC

Before we dive into using the command line, it's important to discuss the distinction between using a UNIX-based computer (Mac, any Linux including Ubuntu, etc.) or a PC running Windows. In these lessons, we're assuming you're using a Mac as it's the most common platform among web developers. With the technologies we cover at Makers – a Mac is the tool of choice. If absolutely required, you can use Ubuntu, but you may encounter minor problems along the way that we won't usually cover at Makers. This does not imply that Mac is somehow superior to Linux when it comes to web development. It is simply different, so the instructions provided for a Mac may not always work on a different system.

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

`tail -f /private/var/log/system.log `

First you'll see the last 10 messages. If you quit or start some application, your Terminal will be updated with new messages describing what's going on. To stop tailing the log, press Ctrl-C.

#### Getting Help

There will be any number of situations where you'll have a question about what command to use or wonder what a command is truly designed for. Let's see how to handle those situations. 

`man ls `

The "man" or "manual" command takes a parameter of another command to provide you more information about it. In the example here, we want to know more about the "ls" command.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380300031530_Screen%20Shot%202013-09-27%20at%2017.40.15.png "man")

By reading through this, we can find out what all of the parameters are, the description and various other pieces of information for using it correctly.

The square brackets in synopsis mean that the parameter or switch is optional. For example, in case of less, you can omit any switch because all of them are shown in square brackets. The same applies to the file(s) that should be given after the switches: if you specify the directory or file name, it will be listed but if you don't, current directory will be used by default. Finally, three dots at the end of the synopsis mean that you can specify one or more files to list.


### Command-Line 1 – More advanced commands

#### Streams

Every program on your computer has at least three "standard streams" associated with it. Streams are just channels used to connect the input and the output of the program to the environment (usually the terminal). The keyboard is referred to as an input stream. By reading from the input stream your program can read what you have typed on the keyboard. The screen is referred to as an output stream. By sending data to the output stream, a program can print something on the screen. There is also an error stream that is usually sent to the display as well but is used only to print error messages.

The input stream is usually called stdin and has number 0. The output stream is stdout (#1) and the error stream is called stderr (#2).

![alt text](http://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Stdstreams-notitle.svg/535px-Stdstreams-notitle.svg.png "stout")

(source: [Wikipedia](http://en.wikipedia.org/wiki/File:Stdstreams-notitle.svg)).

Why do we need to know all of this? Because we can redirect the streams, connecting different streams from different programs. This will allow us to perform some sophisticated tasks. 

#### Pipes and Redirection

Pipes allow you to redirect streams. For example:

`cat combined.txt | less`

The "|" symbol, also known as a "pipe," passes the output stream (what would normally be printed on the screen) of the command to the left of the pipe to the input stream of the command on the right. So in this example it's passing the output of the file "combined.txt" into the "less" command that we learned about earlier.

This will make "less" take the input from the input stream as opposed to opening the file given as an argument. The output of `cat combined.txt` will not be shown on the screen at all since we redirected the output stream to the input stream of `less`.

Let's consider another example. Suppose you have lots of files in the current directory and you would like to view them using the `less` command instead of just printing thousands of lines on the screen. You can redirect the output of `ls` to `less`.

`ls -lA | less`

Then you'll be able to move up and down the text as if the output were a normal file. Later in this lesson we'll see many more examples of redirection.

In addition to redirecting the output stream of one program to the input stream of another one, we can redirect the output to a file. Consider this example.

`cat combined.txt > newCombined.txt`

The greater-than symbol writes the output stream of the command on the left to the file on the right. Wait, we didn't have a "newCombined.txt" file before, did we? Let's check the folder's contents now.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380904304651_Screen%20Shot%202013-10-04%20at%2017.31.33.png "terminal")

What happened is that we wrote the output of "combined" into a new file that we named "newCombined".

#### Displaying What You Want (Wildcards)

As our programs get larger and we have to start wading through large numbers of files, the time will come when we want to have more control over how we look at the system. Let's look at a helpful way to do this.

If we look again at the contents of our SomeDir folder, you should see this:

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380904351261_Screen%20Shot%202013-10-04%20at%2017.32.22.png "ls")

We have 1 text file and 6 other files. With only 7 files, finding what we want is pretty easy. But what if we had 7,000 files? Wildcards is the answer. 

This is how you'd list just the text files:

`ls *.txt`

The asterisk acts as a wildcard, telling the computer to only show you the files that end in .txt. You can use the wildcard in various scenarios. Take a guess at what each of these do before running them:

`ls new*.txt`
`ls *`
`ls *n*`

And obviously you can use asterisks with any command, not just "ls" because that's the built-in feature of the command-line (or the bash shell, strictly speaking), not of any particular command.

Another way to list specific files is by using the "find" command. It looks like this:

`find . -name *.txt -print`

This command works a lot just like normal English. It's saying: "find all files, starting with the current directory, with any name that ends in .txt and print it to the screen." Another cool feature of the "find" command is that, if you have additional directories inside the directory you search in, it will go into those directories as well and continue the search. Therefore, this is how we'd print out every text file in our home directory:

`cd ~`
`find . -name *.txt -print`

The first command you already know - to change directories into your home directory. The second command is just using the find command again to tell it to go through and print all text files in the Home directory, plus any other directories inside your home directory.

So, knowing everything that we know now, how could you create a text document that lists out every mp3 file in your Music directory? (Not everyone uses and stores their music the same way, so you may not be able to find any mp3 files on your computer, but you should understand how it works.)

`cd ~/Music`
`find . -name *.mp3 -print > myMusic.txt`

Both wildcards and "find" are useful for displaying specific files, but what if we want to look inside those files? If you remember from earlier, we've created a few text files in SomeDir. What if I wanted to look at only those files with the word "binary" inside the file? That's where grep comes in.

`grep binary *.txt`

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380904552368_Screen%20Shot%202013-10-04%20at%2017.35.17.png "wildcard")

The "grep" command takes two parameters: the first is what you want to search for (in this case, the word "binary") and the second is what files you want to search through (in this case, the file "combined").

It's also possible to use a pipe to redirect output to grep, so that it worked with the text from the input stream instead of the file we gave it as an argument. Let's print all text files in the home directory that have "readme" in their name.

`find ~ -name "*.txt" -print | grep README`

This command will find all files but instead of printing them, all filenames will be redirected to grep. Grep, in turn, will only print those filenames that include "readme". Try it to see how it works (don't forget the quotes around *.txt, they are important).

#### Very brief mention of regular expressions

Strictly speaking, grep is taking not a string, but a regular expression as an input.

A regular expression describes the pattern that you are looking for. It's similar to wildcards but it's orders of magnitude more powerful. For example, this command would look for all files that have numbers in the filename. You can't do this with wildcards but you can with regular expressions.

`find ~ -name "*" -print | grep "\d+"`

(You may need to use `"\d\+"` expression if this command doesn't work on your machine.)

We will cover regular expressions later in the course.

#### Counting words

Okay. We can find the files we want and get a fair amount of information, but there are still a few more tricks to make things easier.

For example, let's say that our longText.txt file needs to be fewer than 500 words. There's an easy way to check that:

`wc longText.txt`

The "wc" command gives us the "word count" - among some other things.

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_ymW6Sl1t69J_p.52567_1380907084407_Screen%20Shot%202013-10-04%20at%2018.17.56.png "counting workds")

You can see that this command gaves us back 3 numbers: 9 - 492 - 3005. These are the line, word and character counts for the longText.txt file.

And again, you can use pipes to count the output of other programs. How many readme files do we have in the home directory?

`find ~ -name "*.txt" -print | grep README | wc -l`

First, find will find all text files, then grep will select those that have "readme" in their name and "wc -l" will count how many lines were given to it by grep. On my computer I have 24 readme files in my home directory.

#### Permissions

You can control the access to every file on your computer: some files can be read-only, some files can be not available to read to some users, etc. Everyone (a person or a program) using a computer has to identify themselves as some user. You can find out what your name is by using this command:

`whoami`

Every file on a unix-based system has three classes of permissions: "user", "group" and "others". Every class has three permissions: read, write and execute. This allows us to give, for example, read and write access to the owner of the file, only read access to the group it belongs to and no access at all to all other users. Let's discuss classes and permissions in more details.

"User" class determines the permissions that the owner of the file has. Every file on a Unix-like system has some user as an owner. A file can have at most one owner and not more.

"Group" class determines the permissions that apply to a group of user. Any user can belong one or more groups of users (but doesn't have to). For example, if there are several users who access the computer only remotely, they may be organised into a special group that has limited privileges.

"Others" class applies to all users that don't fall into the other two classes. 

The "read" permission allows a file to be read. When applied to a directory, it allows to list directory's contents, that is, to see the list of files.

The "write" permission allows to write to a file, or, in case of a directory, it allows creating, deleting and renaming files.

The "execute" permission allows to execute a file. For example, in order to run a program, it must have the "execute" permission to be set. If you create a ruby script, you won't be able to run it directly unless it's executable (has the "execute" permission). We'll see an example later when we'll be discussing something called a "shebang".

If a directory has the "execute" permission, then you can change into it and access files provided that the files' permissions allow this and you know their names. If you don't know their names, you'll need the "read" permissions to find out directory contents first.

In Unix, the permissions are not inherited, so if a directory has a "read" permission, it doesn't imply that the files in it are readable as well.

#### Viewing permissions

You can view the permissions by listing the directory in a "long" format.

`ls -l`

This will produce a list of files and some extended information about them.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381137966416_Screen%20Shot%202013-10-07%20at%2010.25.53.png "ls -s")

The permissions are shown in the first column, the mix of hyphens and letters, e.g. "drwxr-x-r-x". This may look cryptic at first sight but is actually very easy to read.

The first letter shows the type of the file. In case of "subDirectory" we know it's a directory and not a file because of the letter "d" in its permissions.  All other files have a hyphen instead of a letter "d", meaning that they are just regular files. There are other types of files as well but these two are most common.

Then come three groups of three characters: "r", "w", "x" or "-". The first group determines the permissions of the "user" class. For example, in case of "subDirectory" in the screenshot above, its permissions ("drwxr-xr-x") mean that the owner of the file (in this case "shadchnev") has read, write and execute permissions ("drwxr-xr-x").

The second group are the permissions for the "group" class, that is, a group of users (in this case "staff"). For "subDirectory" the group only has the read and execute permissions ("drwxr-xr-x"). The hyphen where "w" could be indicated the lack of "write" permission.

Finally, the last three characters are permissions for the "other" class of users.

In the screenshot above, the longText.txt only had read permission for all users, while someFile has write permission for the group of users, unlike all other files.

#### Changing permissions

So you know how to view and how to read the permissions of a file but how do you change it? The command responsible for it is called "chmod". For example, to give the user a write permission on a file "readme.txt", you'd do

`chmod u+w readme.txt`

Here, "u" stands for user ("g" for group, "o" for others and "a" for all), "+" means that we're adding the permission ("-" means we're removing it) and "w" stands for "write". You can combine several permissions. For example, to remove read and execute permissions from all users:

`chmod a-rx readme.txt`

#### Shebang

We briefly mentioned shebang before but never went into what it actually is. Let's create a file hello.rb with a very simple Ruby program.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381140246212_Screen%20Shot%202013-10-07%20at%2011.03.52.png "cat")

This Ruby file will print "Hello, world" on the screen if executed. Let's run it using ruby.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381140342688_Screen%20Shot%202013-10-07%20at%2011.05.35.png "Hello worlds")

Here we have actually executed ruby and passed "hello.rb" as the argument. The ruby program read the file hello.rb and executed it. However, we normally run various files without having to pass them as arguments to other programs.

For example, you may be already familiar with irb (pronounced eye-are-bee), the Ruby's interactive shell. To invoke it, we can just type irb in the console

`irb`

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381140613000_Screen%20Shot%202013-10-07%20at%2011.10.05.png "irb")

How can we run our little program just like irb by typing its name in the terminal without explicitely invoking ruby? We'll need to do two things: fix the permissions and add a shebang. Let's try running the file first.

Make sure you quit irb if you launched it. 

`$ ./hello.rb`
`-bash: ./hello.rb: Permission denied`

(Don't worry about ./ right now, we'll explain why it's necessary soon. It's simply a hint for the terminal that we want to run hello.rb from the current directory. Remember that "." stands for current directory?)

The reason we get permission denied error is that the file doesn't have the "executable" permission by default (list the directory in long format to verify). Let's add the permission.

`chmod u+x hello.rb`

Try running the file right now. The permission denied error is now gone but we get another problem.

`$ ./hello.rb`
`./hello.rb: line 1: puts: command not found`

So the terminal (or the shell, to be more precise) complains that it doesn't know what "puts" on line 1 means: command not found. Why is that?

Try to see the situation from the computer's point of view. We asked it to run a program in the file hello.rb but we didn't tell the computer what programming language it was. Was it Ruby? Python? PHP? Something else? The file does have an "rb" extention hinting that it might be Ruby but the computer wouldn't make this assumption. And, even if it's Ruby, we probably have several versions of Ruby installed on the machine: 1.8.6, 1.9.3, 2.0.0, etc. Which one should be used to run our file? The computer needs a specific instruction.

Without a specific instruction it will assume that the file is a "shell script", that is, a set of instructions in the same language that the command line uses. That's why you'll get exactly the same error if try to type `puts 'Hello, world'` in the terminal.

Shebang is the instruction for your computer that tells what program to use to execute your script. It is a combination of a hash and an exclamation mark followed by the path to the interpreter, placed on the very first line of the file.

We want our file to be executed by Ruby, so let's find out where ruby interpreter is first.

`$ which ruby`
`/Users/shadchnev/.rvm/rubies/ruby-2.0.0-p0/bin/ruby`

On my machine, the current version of ruby is located at "/Users/shadchnev/.rvm/rubies/ruby-2.0.0-p0/bin/ruby". Find out where your ruby is and add a shebang to your hello.rb using SublimeText.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381141953228_Screen%20Shot%202013-10-07%20at%2011.32.20.png "hello world")

This tells the command line to use this ruby interpreter to execute the file. Now you can type "./hello.rb" and it will print "Hello, world".

`./hello.rb`
`Hello, world!`

What's happening behind the scenes is that the shell (command-line) passes the contents of the file to the interpreter that we specified in the shebang.

However, we've just hardcoded the path to Ruby right in the file. It will work on this computer but not on any other because the path to Ruby will be different. There is a better solution to this problem. Change your shebang to look like this.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381142356445_Screen%20Shot%202013-10-07%20at%2011.38.46.png "shebang")

The "/usr/bin/env ruby" command loads the "environment" (we'll discuss it in a minute) and executes whatever ruby you have on your machine. It may be 1.9.3 on mine and 2.0.0 on yours. This is a much more portable solution than the one we used before.

Remember we mentioned irb as an example of a program that we can run without typing "ruby"? It also has shebang on the first line.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381142632649_Screen%20Shot%202013-10-07%20at%2011.43.41.png "which irb")

Note that the "which irb" command that returns us the path to irb (try it!) is enclosed in backticks (different from apostrophes; located on the left of the "Z" key). This makes the command line "expand" the command, so the real command executed by the computer is

`head /Users/shadchnev/.rvm/rubies/ruby-2.0.0-p247/bin/irb`

The head command that was mentioned above, shows the first few lines of a file. In the screenshot above you can see the shebang on the first line and some Ruby code starting from line two.

#### Superuser mode

Some actions on the computer require administrative (or superuser) privileges. The name of the superuser is "root". If you list the /etc directory where many of the system configuration files are stored, you'll see that all of them are owned by root.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381143662792_Screen%20Shot%202013-10-07%20at%2011.53.45.png "ls -l")

A superuser has all right and permissions to all programs. In other words, the superuser can do any action on the computer. Working as a root is dangerous since entering a wrong command or making a one-character typo can cause significant damage to the system. For example, there's a world of difference (or just one dot) between deleting all files in the current directory

`rm -rf ./*`

and deleting all files on your hard-drive, ignoring read-only flags and avoiding warnings

`rm -rf /*`

Therefore, it's considered bad practice to work as a root on a permanent basis. Instead, you use a normal account with limited privileges (e.g. you can't do "rm -rf /*" and other dangerous things) but switch into a superuser mode only as necessary.

You can execute a command as a superuser by prefixing it with "sudo". For example, if you want to delete a file you haven't got permissions to delete and you know the superuser password, you can

`sudo rm inaccessibleFile`

It will ask you for the password and then the command will be executed with superuser privileges. [It can also be used to make sandwiches](http://xkcd.com/149/).

#### Environment

If you were asked to describe the physical environment you are in, you could tell a few things about where you are (country, city, street, etc.), what temperature and humidity are, what time of the day and what season it is, what language people around you speak etc.

If you are working with the command line, you also operate in an environment. For example, the command-line knows where your home folder is, where to find ruby, what's your username, and many other things. All this information is stored in environmental variables.

Environmental variables (or env vars, for short) describe the current terminal session. You can see them by typing "env". 

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381145273378_Screen%20Shot%202013-10-07%20at%2012.27.37.png "env")

Every line on this screen is a key/value pair, e.g.

`HOME=/Users/shadchnev`

The HOME env variable defines where the home directory is for the current user. You can easily find variables responsible for setting the username, language, temporary directory, etc.

Every program you launch on your computer has access to the environment variables. They help the programs to understand what environment they are working in. For example, if you needed to create a temporary file in your Ruby code, you'd read the value of the TMPDIR env variable to find out where the temporary directory is.

You can view any single environment variable by typing "echo $ENV_VAR", e.g.

`$ echo $HOME`
`/Users/shadchnev`

#### A note on echo

One seemingly useless but actually quite useful command available in the terminal is "echo". It just prints whatever text you give it on the screen.

`$ echo "Hello"`
`Hello`

It can be used to view environment variables as we've just seen.

It also can be used to save short strings to a file. Let's say you want to create a file with text "Hello, world".

`echo "Hello, world" > hello.txt`

This command will turn out to be useful on more than one occasion later.

#### PATH

One of the most important environment variables is PATH, so let's discuss it in detail. PATH is a colon-separated list of directories where the shell will be looking for the programs you ask it to run. On my computer it looks like this.

`$ echo $PATH
/Users/shadchnev/.rvm/gems/ruby-2.0.0-p247/bin:/Users/shadchnev/.rvm/gems/ruby-2.0.0-p247@global/bin:/Users/shadchnev/.rvm/rubies/ruby-2.0.0-p247/bin:/Users/shadchnev/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin`

This is a list of paths, separated by colons. When you type a command without specifying its path, e.g. "ruby", the shell looks through all these directories until it finds this file and executes it. So, when you type "ls", the shell will be examining the following paths in order until it finds a file that exists.

`/Users/shadchnev/.rvm/gems/ruby-2.0.0-p247/bin/ls`
`/Users/shadchnev/.rvm/gems/ruby-2.0.0-p247@global/bin/ls`
`/Users/shadchnev/.rvm/rubies/ruby-2.0.0-p247/bin/ls`
`/Users/shadchnev/.rvm/bin/ls`
`/usr/bin/ls`
`/bin/ls`
`/usr/sbin/ls`
`/sbin/ls`
`/usr/local/bin/ls`

On my system, "ls" will be found in "/bin/ls".

Remember when we had to type "./hello.rb" to execute the file, instead of just "hello.rb"? This is because if we hadn't explicitely specified that the program was in the current directory, the shell would look in all PATH directories and wouldn't find it there. Every program that you can run from your command line without specifying where they are (ls, chmod, date, pwd, etc) are somewhere on the PATH.

You must have tried switching ruby versions on your machine by now. How does it work? When you type

`rvm use 1.9.3`

rvm updates the PATH variable to include the folders relevant to the ruby version that you need. Then, when you type "ruby", the shell already knows where to look.

If you have installed some software but you can't run it (command not found error), double check that the PATH variable is set correctly.

Setting environment variables

So far we've seen how to read environment variables. We can also set them. Try

`export SEASON=winter`

You've just created a new environment variable called SEASON. You can read its value back.

`echo $SEASON`

What it we wanted to modify PATH? Let's add one more directory at the end of PATH:

`export PATH=$PATH:/Users/shadchnev`

This adds my home directory to the end of the list of paths in PATH.

Why would we want to modify environmental variables? One of the common use cases is storing sensitive data, e.g. passwords. 

Let's say you're writing an open source project that uses photos from Facebook. Your code will need to use a secret key that will give you access to Facebook. This key is secret and you shouldn't share it with anyone. However, you want to share your open source code on Github. How should you do it?

Put your secret key in an environment variable and then read it from your code when you need it. For example:

`export SECRET_KEY=12345abcde`

Then, in your Ruby code, read the value:

`secret_key = ENV['SECRET_KEY']`

This way you'll be able to share your code with anyone without compromising your keys.

#### Profile files

The environment variables don't last for long. After you set them, they only stay in the environment until the end of the current shell session. However, you normally want them being available in all new shell sessions as well. Profile files are often used to achieve this.

Let's create (or re-create if it already exists) the env variable SEASON.

`export SEASON=winter`

Verify that it exists.

`$ echo $SEASON`
`winter`

Now open another terminal window and try to see if the variable exist. It shouldn't: it only exists in the shell where it was originally created. Every variable should be recreated every time a new terminal session starts.

Every time a new shell session starts, several files are executed automatically on load. They are used, among other things, to configure the environment. One of these files is called .bash_profile (note the dot at the beginning). It is located in the home directory.

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381154289375_Screen%20Shot%202013-10-07%20at%2014.57.59.png ".bash_profile")

If you have RVM installed (as you should), there will be some code related to loading RVM into the shell. This code makes RVM available for you to use in every shell.

We can also use the same file to create "permanent" env vars. Let's put our SEASON variable into the file.

`echo "export SEASON=winter" >> ~/.bash_profile`

(Double angle bracket means append, while single angle bracket means overwrite)

Now our .bash_profile file looks like this:

`[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export SEASON=winter`

Now open a new shell window and verify that the variable exists. If you've done everything correctly, it will.

#### Processes

Every program running on the system is composed of at least one "process". A process is simply some code that is being executed (that hasn't finished yet). Simple programs usually launch just one process but sometimes a program can launch several processes in parallel.

You can see what processes you launched by using the "ps" command.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381159022741_Screen%20Shot%202013-10-07%20at%2016.15.05.png "ps")

I have quite a few terminal windows open in parallel, so I have a "bash" process for every one of them. If you use the "x" flag, you'll see all processes running on your computer.

`ps x`

By redirecting the output to grep you can filter out the processes you need, e.g. if you want to only see bash processes running on the system:

`ps x | grep bash`

How could you use "wc" command that we discussed earlier to count their number?

#### vim

We've resorted to using SublimeText earlier today but we won't always have the luxury of using graphical user interface. When connecting to a remote system, a shell (text-only command-line) will be the only interface you'll often have. Even worse, you may not have user-friendly text-based editors (e.g. nano) installed when you need to make a quick change. However, you'll need to look hard to find a system that doesn't have vi or vim (vi iMproved) installed.

This editor may seem very unfriendly at first but if it were really unusable, it wouldn't be so popular among developers and system administrators (why do they use vi). From practical perspective, it's worth knowing the basics because that's the editor you can always rely one on any unix-based system.

To create a new file or open an existing file, just pass it as an argument.

`vi myFile`

You'll see the empty file first. 

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381161102740_Screen%20Shot%202013-10-07%20at%2016.51.35.png "vim")

You can't type anything yet, though, because the editor is not waiting for your text input. By default it will be in a "command" mode when vi waits for a command and not an "insert" mode when it's expecting you to enter text. Right now you could give it one of many commands:

* i – insert text before cursor
* o – open a new line after the current one
* dd – delete current line
and dozens of others

Let's suppose we want to save a file with the text "Hello, world" inside. Press "i" once. The editor will switch into the insert mode:

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381161468370_Screen%20Shot%202013-10-07%20at%2016.57.41.png "insert")

Now whatever you type will be actually entered as text. Type "Hello, world". How do you save it now? Whatever you press now will be taken not as a command (save, exit, etc) but as text. To get back to the command mode press ESC. Now you're back in the command-mode.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381161644651_Screen%20Shot%202013-10-07%20at%2017.00.35.png "vim writing")

Now we can tell vi to save the file. Press colon (:) and then w ("w" stands for "write").
 ![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381161741131_Screen%20Shot%202013-10-07%20at%2017.01.57.png "vim writing")

 After you press Enter, the file will be written and you'll see the corresponding message.

![alt text]( https://dchtm6r471mui.cloudfront.net/hackpad.com_o6W2ogQY8Xc_p.52567_1381161787432_Screen%20Shot%202013-10-07%20at%2017.02.59.png "Vim written")

Now we need to quit the editor. Type :q followed by Enter. (If you needed to quit without saving changes, you'd need to do :q!).

This is the absolute minimum you need to know to make a basic edit using vi. Print a [cheat sheet](http://www.lagmonster.org/docs/vi.html) and practice using vi on a few files.

#### Exiting the shell

Finally, to exit the shell, just type "exit" :)


## Challenges

Before moving on to the next lesson, make sure that you're able to do each of the these [tasks](https://github.com/makersacademy/course/blob/master/challenges/command_line_challenges.md).







