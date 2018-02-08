# Walkthrough

[Back to Challenge](../12_configuring_database_cleaner.md)

#Database Cleaner

To prove that this is a problem, we uncomment an important line of code:
```ruby
post '/links' do
  # Link.create(url: params[:url], title: params[:title])
  redirect to('/links')
end
```
The tests continue to pass!

To fix this add the ```database_cleaner``` gem to the ```Gemfile```. Then configure RSpec to use it:

```ruby
require 'database_cleaner'
...

RSpec.configure do |config|
  # Everything in this block runs once before all the tests run
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  # Everything in this block runs once before each individual test
  config.before(:each) do
    DatabaseCleaner.start
  end

  # Everything in this block runs once after each individual test
  config.after(:each) do
    DatabaseCleaner.clean
  end

end
```

This will make sure that the database is cleared after every test run. If you uncomment the code, your tests should be green again.

[Next Challenge](../13_configuring_the_rack_env.md)
