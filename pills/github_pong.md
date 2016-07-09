Github Pong
============

Github Pong involves pushing code back and forth over related Github branches to make for quick driver/navigator swaps during pairing (remote or face-to-face).  This pill will guide you through your first GitHub Pong set up, setting up with a new pair, and merging branches once a challenge is 'complete'.

###First Steps###

Before writing any code, you and your pair will both need to complete the following steps:

Set up a new directory for the project on your machine, change into the new directory, initiate git and create a new README file (leave this empty)
```sh
mkdir <new-project-name>
cd <new-project-name>
git init
touch README.md
```
Create a corresponding repositry on GitHub, and set this up as a remote origin to your local <new-project> repo
```sh
git remote add origin <github-repo-URL>
```
Stage and commit your README file, and push the changes to origin
```sh
git status
git add README.md
git push origin master
``` 
Checkout a new branch for this day's work and push this new branch to your Github repo.
```sh
git checkout -b day-one
git push origin day-one
```

So now you both have local and remote repos for the project, which include your master branch, and the branch you will be working on today.

###Pairing using Github Pong###

Firstly, you will need to add eachother's GitHub repo's as remotes:
```sh
git remote add <pair-name> <URL-to-pair-partners-repo>
```
The driver will then write code as normal, commiting changes and pushing to their day-one branch:
```sh
git push origin day-one
```
when you are ready to swap and after the final push from the current driver, the new driver will need to pull down the most recent code from their pair partner's branch:
```sh
git pull <pair-name> day-one
```
Throughout the day the driver pushes working code up to their own branch, ready for their pair to pull down when they are back in the driving seat.
```sh
git push origin day-one
git pull <pair-name> day-one
```
This cycle continues until the end of the day, at which point both parties make sure they have pulled the latest code before finishing for the day.

###Using Github Pong with a new pair###

So, it's day two and you're now with a new pair who you've added as a remote. Once you have decided whose code to use, the pair-partner pulling down this code will need to do the following to prevent merge conflicts (first making sure you are on the branch you used yesterday):
```sh
git checkout <day-one-branch>
git checkout --orphan <day-two-branch-name>
git reset --hard
```
The pair with the code being used will need to checkout a new branch for today, from yesterday's branch, and push the new branch to Github:
```sh
git checkout <day-one-branch>
git checkout -b <day-two-branch-name>
git push origin <day-two-branch>
```
Then continue sharing code using the commands from day-one, pushing to your own repo and pulling from your pair's:
```sh
git pull <pair-name> <branch-name>
git push origin <branch-name>
```

###Merging back to master###

Once you've completed the project, probably going through a series of branches, use the following commands to merge the last branch to your master branch:
```sh
git checkout <latest branch name>
git merge -s ours master
git checkout master
git merge <latest branch name>
```

###Additional resources###
A great video about Github Pong: https://www.youtube.com/watch?v=sFAxF6QSPas&feature=youtu.be
