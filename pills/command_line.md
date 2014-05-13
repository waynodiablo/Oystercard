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

