#Github Workflow

# Our process for adding a new feature/fixing a bug on one of our engineering repos

1. Create a Github issue in the relevant repository relating to the feature/bug.

2. When you are ready to work on the story (normally as part of a sprint - it will be moved in the to-do column during the sprint kick-off meeting), create a branch that begins with the issue number and then explains the task at hand, e.g. `295-dates-on-apply-page`.

3. When you are done, create a pull request from your branch to `master`.

4. Get another member of the team to review your PR.

5. When you get a :shipit: or other similarly appropriate emoji, merge your PR.

6. When you're happy, merge your changes on GitHub. You should then deploy immediately - if you have CI setup you can get it to do this for you automatically.

7. Do some QA on your live site if you have it setup.

8. Highfive someone/something.

## Example

An example command line workflow using [hub](https://github.com/github/hub) to create pull requests on the command line.

### In Progress
```
git checkout -b 295-dates-on-apply-page
git push -u origin 295-dates-on-apply-page
```

### QA
```
git checkout 295-dates-on-apply-page
git commit -am "Adds dates on apply page. Closes #295"
git push
git pull-request
```

Once you've got the thumbs up, merge on GitHub.

### Done
```
git checkout master
git pull
```

##External resources

* [Git Flow - a successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)
* [A more advanced workflow with rebasing](http://www.integralist.co.uk/posts/github-workflow.html)
* [what are this?](https://www.youtube.com/watch?v=t4sXjJJjcWQ)
