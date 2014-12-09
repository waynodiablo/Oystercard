Github Pong
============

Github Pong involves pushing code back and forth over related Github branches to make for quick driver/navigator swaps when one is pairing using screen share.  First you need to ensure that all parties have a fork of whatever repo is being worked on.  Then make sure that everyone has each other added as a remote, e.g. 

```sh
git remote add <pair-partner> <URL-to-pair-partners-repo>
```
use git remote -v to check that's set up correctly.  Then to get your partners code use the following:

```sh
git fetch <pair-partner>
git checkout <pair-partner>/<branch-name>
git checkout -b <branch-name>
```

then to sync after your partner makes additional changes:

```sh
git pull <pair-partner> <branch-name>
```

It's also great to have tab completion for branch names:

http://code-worrier.com/blog/autocomplete-git/

and branch names displayed in your command prompt:

http://stackoverflow.com/questions/2231214/git-tips-and-tricks-display-branch-on-command-prompt-not-working-and-created-s

See examples in the following repos:

* https://github.com/PairProgramming/StackExercise
* https://github.com/PairProgramming/AddUserExercise
