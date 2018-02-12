## Multiple Tags

[Back to the Challenge Map](00_challenge_map.md)

At this point we can add a single tag and filter by tags, however we cannot yet add more than one tag to a link.  The utility of tags comes partly from being able to assign multiple tags to the same link, so let's make that functionality available to the user.

```
As a time-pressed user
So that I can organise my links into different categories for ease of search
I would like to add tags to the links in my bookmark manager
```

You've done all this before so let's also do a bit of configuration management and set up Rake tasks to allow us to effectively manage the state of the database.

## Learning Objectives covered

* Know that common tasks are contained within the 'Rakefile'
* Define common tasks such as migrate/upgrade
* Run common tasks from the command line with rake

## To complete this challenge, you will need to

- [ ] Write a failing feature test that adds multiple tags and checks that they are all present on the new link
- [ ] Make the test pass, check it works locally, then deploy and confirm everything is running fine on Heroku
- [ ] Create rake tasks for performing database migrations and upgrades using the `rake` gem
  - [ ] add one task to the Rakefile for DataMapper.auto_upgrade!
  - [ ] add another task for DataMapper.auto_migrate!
  - [ ] ensure you remove any calls to `DataMapper.auto_upgrade!` or `DataMapper.auto_migrate!` from your application code.  (But keep the ones you added to your Rakefile, of course.)

## Resources

* [Rake on Wikipedia](https://en.wikipedia.org/wiki/Rake_(software))
* [Rake on Github](https://github.com/ruby/rake)

## [Walkthrough](walkthroughs/19.md)
