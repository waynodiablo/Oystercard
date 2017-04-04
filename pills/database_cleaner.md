# Database Cleaner

When a test runs, it assumes that the database is empty. The test is not obliged to leave the database clean, though. We need to take care of this ourselves, and DataBase cleaner is an excellent tool to do just that. 

Add the ```database_cleaner``` gem to the ```Gemfile``` and bundle it. Then, require it in ```spec_helper.rb``` and configure RSpec to use it.

```ruby
RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
```

This will make sure that the database is cleared after every test run.
