# Section 1: Installation & Orientation

#### Installing Rails

`$ gem install rails` will install the Rails gem. Expect it to take a while. `rails --help` gives a nice help menu.

Right. All installed? Then let's begin.


### Making a new Rails app:

##### The basic way:

`$ rails new yelp_clone`


##### The Makers way:

`$ rails new yelp_clone -d postgresql -T`


#### Anatomy of the `new` generator:

* `yelp_clone` is the name of your app – Rails will create this in a new directory.
* By default, Rails uses Test::Unit for testing. The `-T` switch turns off the built-in Rails test suite, because we're going to use RSpec for this project.
* `-d` preconfigures your app for a particular type of database. By default, this is SQLite – which is a useful toy database, but can't be used on Heroku. In this case, we're overriding the default to use PostgreSQL.


#### Where'd all those files come from???

True to its 'opinionated' name, Rails is full of files and folders right from the start. This is an example of Rails touting a certain kind of configuration, which is a strong recommendation for how to organise the files in your project. Here's what some of them do:

* `app` – **where your code goes**. Contains models, views and controllers; as well also JavaScript & CSS assets
* `bin` – contains specific versions of executables such as rails and rake for doing low level tasks
* `config` – configuration information, including `database.yml` which includes database configuration details and a routes file
* `db` - all our database related code for migrating and seeding the database
* `lib` - place to put non-rails ruby code
* `lib/tasks` - the home for your custom rake tasks
* `log` – keeps server logs and terminal output
* `public` – public resources. These will remain available even if the server goes down. Includes all your error pages by default
* `tmp` - temporary stuff gets stored here
* `vendors` – a place for resources that you didn't write but are needed for the project, like jQuery; also called 3rd party assets


#### Start the server

`$ bin/rails server` or `$ bin/rails s` will get you started. (Rails has lots of these little command-line shortcuts.) Now visit http://localhost:3000.

If you see an error, you'll likely need to run a `rake` task to get your database built:

`$ bin/rake db:create`

**PRO-TIP:** Sometimes there can be a bit of a frustrating problem at this stage, where depending on your system configuration, the above might work, then again it might be necessary to run the following as well:

`$ bin/rake db:create RAILS_ENV=test`

This is a frustrating and intermittent problem. The most frustrating part of it, is that `rake db:` things are magic, and the very best advice you can heed at this stage is this: **ACCEPT THE MAGIC.** You may be filled with a burning desire to understand every little part of how Rails works, but at this stage it is unnecessary.

The ideal level of knowledge at this point, is that you need to run a `rake` task to build your database before you can get anywhere with your app - and sometimes you need to run a slightly different version of that `rake` task if the first doesn't work.

### [Next Stage - Setting Up Tests](2_setting_up_tests.md)
