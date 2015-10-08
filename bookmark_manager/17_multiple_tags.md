## Mutiple Tags

[Back to the Challenge Map](0_challenge_map.md)

At this point we can add a single tag and filter by tags, however we cannot yet add more than one tag to a link.  The utility of tags comes partly from being able to assign multiple tags to the same link, so let's make that functionality available to the user.

```
As a time-pressed user
So that I can organise my many links into different categories for ease of search
I would like to add tagS to the links in my bookmark manager
```

You've done all this before so let's also do a bit of configuration management and set up Rake tasks to allow us to effectively manager the state of the database.

## Learning Objectives covered

* Using DataMapper to manipulate the state of the database from Ruby (new LO!!!!)
* Know that common tasks are contained within the 'Rakefile'
* Define common tasks such as migrate
* Run common tasks from the command line with rake

## To complete this challenge, you will need to

- [ ] Write a failing feature test that adds multiple tags and checks that they are all present on the new link
- [ ] Make the test pass, check it works locally, then deploy and confirm everything is running fine on Heroku
- [ ] Create rake tasks for performing migrations using the rake gem
  - [ ] add one task to Rakefile for DataMapper.auto_upgrade!
  - [ ] add another task for DataMapper.auto_migrate!
  - [ ] ensure you no upgrade or migrate code left in your application apart from the Rakefile

## Resources

* [Rake on Wikipedia](https://en.wikipedia.org/wiki/Rake_(software))
* [Rake on Github](https://github.com/ruby/rake)

## [Solution](solutions/17.md)
