# READMEs

Congratulations! You've written some awesome code. Your tests are green. You've pushed to GitHub. All is well! Except...

You don't have a README. If anyone else goes to your repo right now, they won't know what's going on. This pill is here to help you fix that.

## What's a README?

The clue is in the name. A README is a file that should be read carefully before using any piece of code (as in, READ! ME!). At the barest minimum, it should contain a description of what the code does, how to install it, how to use it and how to run its tests. In addition, READMEs often include other information such as:

* Configuration instructions
* A file manifest (list of files included)
* Copyright and licensing information
* Contact information for the distributor or programmer
* Known bugs
* Troubleshooting
* Credits and acknowledgments
* A changelog (usually for programmers)
* A news section (usually for users)

On GitHub, if your repo contains a `README.md` file, this will be automagically displayed on the front page of your repo.

## What should my README contain?

Writing a README (and any other form of documentation) can be tedious, but it doesn't have to be. GitHub gives you a lot of the information listed above for free - bugs through GitHub issues, automatic license information, changelog through your commit history etc. etc. While on the course, you should keep your READMEs up to date - otherwise, you'll have to do all of them at the end, and from experience we can tell you that you are unlikely to enjoy this.

So, as a minimum, here's what you need:

* A `README.md` file in the root folder of your repo
* The title of the project
* What the project is/what it does
* How to install it (what to clone, what to run to get all dependencies)
* How to run it (is it a command line tool? Do you have to load it into IRB? Is is a web application? What port needs to be used?)
* How to run the tests

Later on, you can add screenshots and additional information to your heart's content, but make sure you have this with all your repos as you proceed through the course. You will thank yourself later.

For extra convenience, here is an easy-to-use template:

README.md

```
# Title of project

Brief description of what the project is

## Getting started

`git clone path-to-your-repo`
`command_to_install_dependencies` (e.g. `bundle`)

## Usage

`command_to_start` (e.g. `rackup` or `rails s`)
Navigate to `http://localhost:4567/`


## Running tests

`test_command` (e.g. `rspec`)
```

This may seem like not much, but this is the minimum amount of information a newcomer to your project will need to get started.

If you do feel like making your README extra awesome, [here is a list of awesome READMEs for inspiration](https://github.com/matiassingers/awesome-readme).

Happy documentationing.
