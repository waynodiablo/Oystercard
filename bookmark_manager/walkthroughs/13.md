# Walkthrough

[Back to Challenge](../13_configuring_the_rack_env.md)

Run rackup and you should get an error saying that your `config.ru` file is not found if you haven't made one already.

Let's create that now in the root of your project

```ruby
  # config.ru
  require './app/app.rb'

  run BookmarkManager
```

Create a new link from the new link form and confirm that it's been created.

Run your tests and now if you check your `/links` page you should see that there are no more links, because DatabaseCleaner has deleted all the links. This is why we must distinguish between test and development environments.

In psql run `CREATE DATABASE bookmark_manager_development;` to create a new database.

In your `app.rb` put this on the first line to ensure that the app runs in development mode by
default

```ruby
ENV["RACK_ENV"] ||= "development"
```

At the top of your spec_helper to ensure that your tests run the application in test mode

```ruby
ENV["RACK_ENV"] = "test"
```

Finally in `link.rb` update your DataMapper config to the following to ensure that the correct database is used depending on the Rack environment.

```ruby
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
```

Now you should be able to add data in your app and to run the tests without removing the links that you created manually through the web interface. 

[Next Challenge](../14_deploying_to_heroku.md)
