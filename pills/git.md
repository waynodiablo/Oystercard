# Version Control 1

Congratulations and welcome to lesson 2. By finishing lesson 1, you're 1/60th of the way through. (That sounded more inspirational in my head)

The good news is that we're already building on what you learned in lesson 1 with version control.

Version control is the process and technology used to "control" various "versions" of the code that you write. If, for example, you were building a house, you'd likely start with the foundation and make sure it's solid before you started building the walls. You'd want to stop after the walls were built to make sure everything lined up properly before adding the roof. You wouldn't want to build the entire thing and *realize* after the roof is built that there is a crack in the foundation.

Software version control helps us avoid these problems by allowing us to keep various versions of what we're building. If we *realize* we've made a mistake, we can revert back to a previous version that we know is solid.

Additionally, version control allows multiple versions to be built simultaneously and then brought together. It doesn't matter whether you're working in a team or writing code alone, version control is something you absolutely need to understand.

## What would version control in real world look like

If our lives were version controller, we'd be able to travel back in time. Imagine going back to any given day being able to live through the life from that point onwards again?

If you ever make a mistake that you later regret, you can "rollback" the time to before mistake and avoid making it this time.

If you want to see what life was like when you were 10 years old, you can go back in time and then return into present when you're done.

You could even live several lives in parallel! Imagine you decide to rob a bank (not that you should!). Maybe you'll get rich and retire in Monte Carlo. Maybe you'll get caught and spend the next 10 years in jail. In real life you have to make a choice and live through the consequences. With version control you can try both options at the same time and see which one works out best. You can then decide what version you like best (robbing the bank or not) and live it for the rest of your life!

Version control doesn't stop here. What if you decide to do a renovation to your flat? You need to change the floors, paint the ceiling, install a jacuzzi and remove a wall between a living room and the kitchen. Normally, you'd need to do all of that in order: first you remove the wall, then paint the ceiling, then change the floors, then install the jacuzzi, etc. You can't change the floor and paint the ceiling on the same day while removing the wall at the same time. However, with version control you can split the reality into several "parallel" realities and do the work in parallel. In one reality you'll be painting the ceiling, in another – removing the wall, and so on. When all the work is done, you'd "merge" all those realities into one, getting a beautiful renovated flat in a fraction of the time.

It may sound like a science-fiction film but that's actually how version control works. Not using version control is like having time-travel skills and not using them! It's important to know and use version control because it's an awesome developer superpower.


## Git

The most common version control system used by web developers is git. With git you get all of the benefits of controlling various versions of your code and the ability to handle distributed work among a team. [This isn't the only version control software](http://www.infoq.com/articles/dvcs-guide) out there, but it's what a large portion of software developers use and it's what we're going to cover here.

The rest of the tutorial assumed that you have installed git before the start of the course. It comes as part of [Heroku Toolbelt](https://toolbelt.heroku.com/). You can check that it's installed by asking for its version:

````
$ git --version
git version 1.7.12.4 (Apple Git-37)
````

### Setting up git

First thing's first, we need to get git setup on your computer. Open up the Terminal and type the following two commands with your personal information (replace "your name" and "your email" with your information):

```
git config --global user.name "your name"
git config --global user.email "your email"
```

These two commands configure your system for using git. In addition, we'll make a couple of small settings changes with:

```
git config --global core.autocrlf input
git config --global core.safecrlf true
```

Don't worry about what these do exactly as they're just formatting some settings to make things easier later on.


### Your first git repository 

Let's create a git *repository* to illustrate how it works. Create a new directory with a small text file named gitText. The text should read "Git is Awesome!" like this:

```
mkdir gitDir
cd gitDir
echo "Git is Awesome" > gitText
```

Now that we have our gitDir directory with a single text file, let's make this directory a git repository.

```
git init
git add gitText
git commit -m "First commit"
```

![First commit](https://dchtm6r471mui.cloudfront.net/hackpad.com_mKMM4CQ89LW_p.52567_1381242923515_Screen%20Shot%202013-10-08%20at%2015.35.05.png)


Let's break down these commands line by line.


### Initialising the repository


The first command initialises this directory as a git repo - it only has to be done once for every repository. 

```
git init
```

A repository is a directory with files that are "under version control". When you run `git init`, git created a hidden directory called .git (with a dot in front) that it uses to track all changes to the files in the directory.

Take special care to not to initialise a top-level directory (e.g. Desktop, your home directory or a directory where you keep several projects) as a git repository. This wouldn't make sense to git and could lead to problems later. You should run `git init` inside the directory where the files for the project you're placing under version control are.

In general, you want to have a directory (and a repo) for every project you're working on: a website, a library, a set of exercises or even a single large exercise. For example, if you're doing a FizzBuzz challenge, it should be in a separate directory (e.g. ~/projects/FizzBuzz) under version control.

If you accidentally initialise a git repo in a folder that shouldn't be under version control, e.g. by running `git init` in ~/Desktop, you can revert the change by removing the hidden .git folder:

```
rm -rf .git
```

So, the first thing we do when we start a new project is to create a directory, change into it and place it under version control by running `git init`.



















