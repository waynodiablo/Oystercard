#Development environments

A web project usually has at least three environments: development, test and production. An environment is the "mode" the project is running in, determined by the set of the environment variables (the environment the shell variables are in and the environment the project is running in are two different concepts that share the same name).

The environment the project is running in determines the behaviour of the project. For example, if we have an e-commerce project, our payment processing would be different for the three environment:

1. in production all credit cards would be charged for real (when real customers use it)
2. in development (when writing code), we would use special "development" credit cards that behave like real ones, except that no money is actually spent
3. in test (when running automated tests), we wouldn't even connect to the card processing centre so as not to slow down the tests

Depending on the environment, we may or may not do certain things: e.g. send real emails in production but only pretend to do it in a test environment. Our code can print extensive debugging information in development but only show succinct error messages in production.

Databases are a major consideration: we don't want to use the same database in different environments. Imagine you have one million users registered on your website. You don't want to use the same database for development. When you launch the website locally you only want to have a database with a few users that you control manually. And when you run your tests, you want your database to be empty because every test assumes that there is nothing there that wasn't created explicitly. What happens if your test deletes all data from the database and you run them on a production or development database? You'd lose data. So, we really need to use one database per environment.

That is why we check what environment we're in, and default to development.