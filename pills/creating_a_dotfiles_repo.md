Creating a Dotfiles repo:
=========================

What?
-----
Dotfiles are the hidden configuration files which save system settings for us, you're probably familiar with .DS_Store, and .gitignore already. Especially using the latter to hide the former.

Right now we're especially concerned with the dotfiles that live in our home directory, these are the ones which let us customise the behaviour of bash, git, irb, and many others.

In this pill we're going to modify some of our dotfiles, group them together in a folder and push them to github.

Why?
------
By modifying dotfiles we can mould our system around ourselves, automating common tasks and carving out our own workflow. Recreating these settings on every new system is repetitive and tedious, exactly what we're trying to avoid, but with a well maintained dotfiles repo and an install script we can quickly set up any new system and start using our old settings right away.

Creating bash aliases:
----------------------

First navigate to ~ and open up your .bash_profile in your favourite editor:

```bash
cd ~
subl .bash_profile
```

There may already be stuff here, there will probably be a line about opening the default profile, but ignore all of that for now.

This basic syntax for defining aliases is:

```bash
alias shortcut="full command"
```
e.g:
```bash
alias r="rspec'
```

If you add that to your bash_profile, save the file, and run: 
```bash
source ~/.bash_profile
```
You should now be able to run rspec just by pressing `r`.

Think about some other commands that you type a lot and try making aliases for them, perhaps you're tired of typing `git commit -m` so often?

Creating bash functions:
------------------------

Another way to save effort and keystrokes is with bash functions, these can preform more complex tasks than aliases, and can take arguments.

You can define a bash function like this:

```bash
function name-of-function ()
{
echo "This is one way to define a bash function"
}
```
Or like this:
```bash
name-of-function ()
{
echo "This also works"
}
```

One popular bash function is:

```bash
mcd ()
{
mkdir -p $1
cd $1
}
```

This function take the first command line argument you pass it `$1`, creates a directory of that name, and moves you into that directory. The `-p` flag stands for pipe, it lets you pass in an argument such as `/new/test/directory` and have it create the entire structure, moving you to `directory/` at the end.

Now close bash_profile and run `source ~/.bash_profile` again, and type in:

```bash
mcd new_directory
```

And you should find that it makes it and moves you automatically.

As with aliases, try to think of some other useful functions. Do you really need to add, commit, and push to git with three separate commands?

You can find a quick overview of bash syntax [here](http://learnxinyminutes.com/docs/bash/)

Creating the Repo
------------------

Now for the fun part!

First create a folder in your home directory, I think you should call it dotfiles but I'm not the boss of you. 

Secondly move .bash_profile and .bashrc into this new folder:

```bash
mkdir dotfiles
mv ~/.bash_profile ~/dotfiles/bash_profile
mv ~/.bashrc ~/dotfiles/bashrc
```

(Note that I'm dropping the dot when I move them, there's not much point keeping them hidden when they're in the new folder).

Thirdly double check that they're both in your dotfiles repo and do all the usual git stuff to push these to a github repository.

Congratulation! You now have a dotfiles repository!
But... you'll notice that if you restart terminal you no longer have your aliases, since they're no longer in ~. You could make copies of them, or even better symbolically link them, but then you'd have to do it again on every computer you want your aliases on. And since the point of this exercise is to automate things and make your life easier, that just wont do.

Instead we're going to create an installation script that will set up all of your dotfiles on this machine and any others you use in the future.

Installation Script
-------------------

First create an installation file in your dotfiles folder, call it something like `install.sh`. This file is going to look though ~ for any existing versions of your dotfiles, and move them to a folder called old_dotfiles if it finds any. Then it will create a [symbolic link](http://en.wikipedia.org/wiki/Symbolic_link) to each of our dotfiles in ~.

So to start we want to define our dotfiles folder and our old_dotfiles folder:

```bash
#!/bin/bash                                                                                                                                                                          
dir=~/dotfiles
olddir=~/dotfiles_old
```

(The top line isn't strictly necessary, it's just good form).

If you called your folder something other than dotfiles make sure that's what you assign to `dir`.

Next give it a list of all the files you want it to put in ~:

```shell
files="bash_profile bashrc"
```
Right now you only have two, but any time you add a new file to the repo add it to this list. As with passing command-line arguments, bash views a space as a break between arguments.

Next you want it to create the old_dotfiles folder and move into your dotfiles folder to carry out the rest of the code:

```shell
mkdir $olddir
cd $dir
```

The final loop does all of the heavy lifting, it iterates though the file name we passed to it, moves any existing versions of the file to old_dotfiles and creates a symbolic links in ~:

```shell
for file in $files; do
    mv ~/.$file $olddir/$file
    ln -s $dir/$file ~/.$file
done
```

The final script should look like this:

```shell
#!/bin/bash                                                                                                                                                                          
dir=~/dotfiles
olddir=~/dotfiles_old
files="bash_profile bashrc"

mkdir $olddir
cd $dir

for file in $files; do
    mv ~/.$file $olddir/$file
    ln -s $dir/$file ~/.$file
done
```

Now if you run this script:
```shell
sh ./install.sh
```
You should have copies of these files in your home directory again, and now they reflect any changes made in the dotfile versions, letting you sync settings across multiple machines.

Finishing Up
------------

Hopefully you this has helped automate some work for you and saved you some future effort, but there's a lot more you can do. Look at some of the other dotfiles in you home directory and see what you could use them for. Is there something you want to ignore every time that you could put in .gitignore_global? How about something you want irb to do every time you start it up?

Computers are really good at repetitive tasks and 'if this then that' relationships, if you find yourself constantly doing the same few tasks in sequence you can probably automate it with a function or shell script. By keeping an eye out for tasks that can be automated you'll be able to spend more of your time actually coding.


Some links
-----------
- Look though other peoples dotfiles repos for ideas, here's [mine](https://github.com/JKiely/dotfiles), [Spike's](https://github.com/spike01/dotfiles), and [Sam's](https://github.com/tansaku/dot_files) to get you started.
- A link to a shell scripting guide
- Another valuable perspective on [automation](http://xkcd.com/1319/)

Additional tasks
---------------
- If you use Sublime then your config files don't live in ~, how would back them up? How would you automate installing them?
- Remember the set up for Makers Academy? How much of that could you automate with a shell script?
- Putting all of your code in one file violates SRP pretty hard, try creating separate files for aliases and functions and just using bash_profile as a runner to load those files.



![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/creating_a_dotfiles_repo.md)
