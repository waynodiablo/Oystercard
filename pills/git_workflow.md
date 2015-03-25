#Git Workflow

Using Git branches can make your life much easier when developing a project as a group. Ensuring separation from the master branch creates opportunity to review and reflect upon code before you are commited to it. It allows for a team to divide into pairs and work asynchronously on different features, each pair working on their own feature branch. Using pull requests creates a space in your team's workflow for code reviews and reflection.

There are many different best practices, these are by no means "the right way". However, we find this is a relatively simple workflow that uses Git to facilitate the development of your project.

![gitflow](https://github.com/makersacademy/course/blob/master/images/gitflow.png)

##What are this?!

1. At the beginning of your project, Develop should mirror master. 
2. Create a new branch 'newFeature': ``` git checkout -b newFeature ```
3. Once your feature is complete ``` git pull origin develop ``` then ``` git push origin newFeature ```. In Github, you can now create a pull request from your branch to develop.
4. Other team members review your code and together you reflect upon it.
5. Assuming all happy and tests pass, merge the pull request on Github and run tests again. At this stage it is a good idea to push to staging to ensure nothing unexpected occurs.
6. Assuming all tests pass and staging looks fine, push to master and then push master to production. Congratulations your code is now live.

##Further resources

* [Git Flow - a successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)

