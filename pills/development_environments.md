Development Environments
========================

A web project usually has at least three environments: development, test and
production. An environment is the "mode" the project is running in, determined
by the set of the environment variables (the environment the shell variables are
in and the environment the project is running in are two different concepts that
share the same name, annoyingly).

The environment the project is running in determines the behaviour of the
project. For example, if we have an e-commerce project, our payment processing
would be different for the three environment:

- _in production_ (when real customers use it) all credit cards would be charged
  for real.
- _in development_ (when writing code) we would use special "development" credit
  cards that behave like real ones, except that no money is actually spent
- _in test_ (when running automated tests) we wouldn't even connect to the card
  processing centre to not slow down the tests

Depending on the environment, we may do or not do certain things - like send real
emails in production but only pretend to do it in a test environment. Our code
can print extensive debugging information in development but only show succinct
error messages in production.

For example, **use Bundler as an example of different environments with diff
gems**

The same goes for databases: we don't want to use the same database in all our
different environments. Imagine you have one million users registered on your
website - you don't want to use that same database for your development work.
When you launch the website locally you only want to have a database with a few
users that you control manually. And when you run your tests, you want your
database to be empty because every test assumes that there is nothing there that
wasn't created explicitly. What happens if your test deletes all data from the
database and you run in on a production or development database? You'd lose
data. So we really need to use one database per environment.

A good way to do this is by setting your environment using environment
variables. For instance in a Sinatra app:

```ruby
env = ENV["RACK_ENV"] || "development"
```

Here the `env` variable is set to the value of the `RACK_ENV` environment
variable, or defaults to `development` when none is present.

We can then  select the database based on the environment (in this case using
DataMapper and PostgreSQL):

```ruby
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
```

We can then specify the value of `RACK_ENV` to change the database we are using.
For instance when using Rspec, in our spec_helper we can specify the `RACK_ENV`
to be `test`, so that our tests will use the test database:

```ruby
ENV["RACK_ENV"] = 'test'
```

