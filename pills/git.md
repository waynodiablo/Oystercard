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

![Step one](https://dchtm6r471mui.cloudfront.net/hackpad.com_mKMM4CQ89LW_p.52567_1381242923515_Screen%20Shot%202013-10-08%20at%2015.35.05.png)


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


### Adding files to the staging area


The second line tells the computer to add the gitText file to the staging area (or staging, for short). What is staging area? Isn't git supposed to track all changes automatically?

```
git add gitText
```

Git is mean to act like a time machine, allowing you to go back in time. However, allowing you to travel to an arbitrary moment in time wouldn't make sense. Think about time travel. You may want to go back to yesterday, or yesterday morning, or that specific moment right before you try to rob the bank. However, you wouldn't want to go to any specific second of any of the past years, unless that second was somehow important for some reason.

Tracking every single change would be unnecessary and slow (imagine how much disk space would it take to record every single keystroke of every developer on a large project!). So instead of tracking every change, we must tell git when to create a "checkpoint" (or "commit", in git terminology) that we'll be able to go back in time to.

However, before creating a commit, we need to specify what is being "committed". What if we have a temporary file that we don't want to be saved anywhere long-term? Imagine you're using git to track changes to a novel you're writing. You've finished chapter one and you want to commit it to git, so that you could always go back in time to the moment the first chapter is finished, if you need. However, you also have some random notes for chapter two that you don't want to save just yet (you'll commit them when chapter two starts taking some shape).

So, you'd tell git to only add chapter one to the staging area. The staging area is a special place that git uses to keep track of all files that will be committed on the next step. So even if you have several files that have changed since the last commit (or since the repo was created), you can choose which of them will get committed. So, we're telling git that we're happy with the file as it is now and we'd like to create a "checkpoint" (or commit) that we could go to in case we ever want to.

Even though there's no output from git after you tell it to add a file, unless you see an error message you can assume it went well.

### Committing files

The final line tells us to commit everything in the *staging area*.

```
git commit -m 'First commit'
```

At this point git actually creates a commit, remembering all files that you added to the staging area right now and naming it "First commit" (it's called a commit message). We give it a name so that we could go back to it if we want to.

Remember our science-fiction bank-robbing example? If you could use git for real, you'd want to make a commit right before starting preparing for the heist (in case you make a mistake preparing for it and want to travel back in time to this moment later).

```
git commit -m "About to start preparing for heist"
```

Then you'd commit right before the bank robbery, in case it goes wrong and you want to replay it from that moment in time again and avoid preparing for it again.

```
git commit -m "Ready for the heist"
```

Then, if anything goes wrong at the preparation stage (you forget to buy a balaclava), you can go back in time to the moment when you were "about to start preparing for the heist" and fix the problem before trying the robbery again. If anything goes wrong during the robbery (you accidentally introduce yourself by your real name to the cashier), you can go back in time to the moment when you were "ready for the heist" and avoid the same mistake.

When you commit the file, git tells you what it does:

```
$ git commit -m "First commit"
[master (root-commit) a1833e4] First commit
 1 file changed, 1 insertion(+)
 create mode 100644 gitText
```

This is what a successful commit message looks like. Git is telling you that it created a commit called "First commit" with a number (or hash, or SHA) a1833e4. One file was changed (gitText), there was one insertion (we put a line of text in it).

So, we're creating a commit called "First commit" indicating that we just initialised a repo in this directory. If we ever need to go to the very beginning, we'll be able to checkout "first commit".


### Checking the status


If you want to see what's going on in your repository, use this:

```
git status
```

This will give you an overview of what files have changed since the last commit. This is what mine shows:

![Step two](https://dchtm6r471mui.cloudfront.net/hackpad.com_mKMM4CQ89LW_p.52567_1381245384685_Screen%20Shot%202013-10-08%20at%2016.16.13.png)

So, git tells us that there's nothing to commit (working directory clean). The first part (nothing to commit) means that we haven't added anything to the staging area. The second part (working directory clean) means that there is nothing that could be added to the working directory. We haven't made any changes since the last commit, so we can't make another one. A commit is a record of some changes and we haven't made any.

(There's also a mention of something called a "master branch". This refers to one name of the current "reality". Remember we can switch between different realities, or branches? The main one is called "master". We'll get to branches in due time, just ignore it for now).

If we were to make a change such as changing the text of gitText, git would tell us that there's been a change. So, let's make a change a see what the status is again.

![Step three](https://dchtm6r471mui.cloudfront.net/hackpad.com_mKMM4CQ89LW_p.52567_1381245987544_Screen%20Shot%202013-10-08%20at%2016.25.50.png)

The "git status" command now shows us that we've made a change that isn't staged (that is, added to the staging area).

So, what does this message mean? Let's break it down.

First, it tells us that one file was modified:

```
modified:   gitText
```

That's because we changed some text in it using echo right before running `git status`. Git also tells us that this file isn't staged for commit yet, so if we try to commit right now, nothing will happen.

Git also helps us by telling how to add this file to staging:

```
(use "git add <file>..." to update what will be committed)
```

If you don't want these changes and just want to go back to the version of this file at the time of the last commit, we can do it as well. Git helps us by showing how:

```
(use "git checkout -- <file>..." to discard changes in working directory)
```

Finally, git tells us that there's nothing in the staging area at all:

```
no changes added to commit (use "git add" and/or "git commit -a")
```

Since we've made a change, we should now stage it. After adding it to staging, check git status again:

```
git add gitText
git status
```

It will now show us that we've staged this new file, but it hasn't been *commited* yet.

![Step four](https://dchtm6r471mui.cloudfront.net/hackpad.com_mKMM4CQ89LW_p.52567_1381246723428_Screen%20Shot%202013-10-08%20at%2016.38.35.png)

If we move on to commit it permanently, we run:

```
git commit -m "Updated gitText"
git status
```

The "git commit" command again commits everything in staging with a short comment about what we've changed. As you can see, everything then is saved and up-to-date.

![Step five](https://dchtm6r471mui.cloudfront.net/hackpad.com_mKMM4CQ89LW_p.52567_1381247257500_Screen%20Shot%202013-10-08%20at%2016.47.19.png)

It's a good idea to check the status often, especially if you suspect something is going wrong. Run `git status` every now and then, if only to confirm that the repo is in the state you expect it to be.


### Viewing the log (history) of the changes

Finally, if we want to view all of the commits we've made, we run:

```
git log
```

This will list out information about all of the previous commits.

![Step six](https://dchtm6r471mui.cloudfront.net/hackpad.com_mKMM4CQ89LW_p.52567_1381247504285_Screen%20Shot%202013-10-08%20at%2016.49.02.png)

This gives you the history of all changes, including who made them and when they were made. The long incomprehensible number (56d9881253...) is the unique number of every commit. We need it because the commit messages are not guaranteed to be unique.

### Removing files






























