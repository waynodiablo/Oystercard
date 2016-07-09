Github Pong
============

Github Pong involves pushing code back and forth over related Github branches to make for quick driver/navigator swaps during pairing (remote or face-to-face).  This pill will guide you through your first GitHub Pong set up, setting up with a new pair, and merging branches once a challenge is 'complete'.

###First Steps###

Before writing any code, you and your pair will both need to complete the following steps:

Set up a new directory for the project on your machine, change into the new directory, initiate git and create a new README file (leave this empty)
```s
mkdir new-project
cd new-project
git init
touch README.md
```
Create a corresponding repositry on GitHub, and set this up as a remote origin to your local boris-bikes repo
```s
git remote add origin <github-repo-URL>
```
Stage and commit your README file, and push the changes to origin
```s
git status
git add README.md
git push origin master
``` 
Checkout a new branch for this day's work and push this new branch to your Github repo.
```s
git checkout -b day-one
git push origin day-one
```

So now you both have local and remote repos for the project, which include your master branch, and the branch you will be working on today.

###Pairing using Git Pong###

Firstly, you will need to add eachother's GitHub repo's as remotes:
```s
git remote add <pair-name> <URL-to-pair-partners-repo>
```







```sh
git remote add <pair-partner> <URL-to-pair-partners-repo>
```
use git remote -v to check that's set up correctly.  Then to get your partners code use the following:

```sh
git fetch <pair-partner>
git checkout <pair-partner>/<branch-name>
git checkout -b <branch-name>
```

Note that the above assumes a new branch name that you don't currently have on your local system.  If you are planning to ping pong on master then you can just pull your partners changes in directly like so

```sh
git pull <pair-partner> master
```

To sync after your partner makes additional changes:

```sh
git pull <pair-partner> <branch-name>
```

It's also great to have tab completion for branch names:

http://code-worrier.com/blog/autocomplete-git/

and it's absolutely essential to have branch names displayed in your command prompt:

http://stackoverflow.com/questions/17333531/how-can-i-display-the-current-branch-and-folder-path-in-terminal

See examples in the following repos:

* https://github.com/PairProgramming/StackExercise
* https://github.com/PairProgramming/AddUserExercise
