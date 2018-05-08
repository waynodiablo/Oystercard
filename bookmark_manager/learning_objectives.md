## Learning Objectives: Bookmark Manager

Learning Objectives are tagged with :heart: for **critical objectives**, :yellow_heart: for **important objectives** and :green_heart: for **nice-to-have objectives**.

Under each objective is an example thing. If you can confidently do that example thing (doing research while attempting it is fine), you've met that objective.

### Agile & TDD

* :heart: Generate User Stories from Requirements
  * Turn "users got to log in" into "As a user, so that I can access my stuff, I want to log in".
* :heart: Build a complete full-stack feature.
  * Write a feature test for viewing bookmarks. Build the feature, including controller, model, and database code.

### Engineering and 'Dev Recipes'

* :heart: Set up a Ruby web project.
  * Take an empty directory. Get Sinatra up and running and showing "Hello World" when I visit `localhost`.
* :heart: Attach a database to a web application.
  * Use SQL in a controller to read a bookmark record from a database.
* :heart: Separate application behaviour from database behaviour.
  * Write a controller method that gets all bookmarks from a database and renders them into a view.
* :heart: Map objects across systems.
  * Explain how a `Bookmark` instance and a bookmark database record are related to one another.
* :yellow_heart: Create a CRUD system.
  * Create, Read, Update, and Delete bookmark records in a database from a user-clickable web interface.
* :yellow_heart: Implement a RESTful routing convention.
  * Turn routes like this: `GET /show-bookmark-1` into routes like this: `GET /bookmarks/1`.
* :green_heart: Wrap an adapter object.
  * Call `Bookmark.create` and get back an instance of the `Bookmark` class with all the attributes you passed to `.create`, and an `id` attribute.
* :green_heart: Validate in the model layer.
  * Stop `Bookmark.create` from creating a bookmark record in the database if its URL is invalid.
* :green_heart: Build a Registration system.
  * Allow a user to sign up to an application through a clickable form. Also, encrypt their password.
* :green_heart: Build an Authentication system.
  * Allow a user to sign in to an application through a clickable form, using some details including their password.

### Databases

* :heart: Install PostgreSQL.
  * Make it so that when you type `psql` into your Terminal, you get an interface to PostgreSQL.
* :heart: Create a database.
  * Make it so that when you list databases (`\l`) in `psql`, you can see a database you created in the list of databases.
* :heart: Implement a one-to-many relationship.
  * Get all comments for a bookmark using SQL, or with a method like this: `bookmark.comments`.
* :yellow_heart: Use the `psql` command to interact with PostgreSQL.
  * Create a database in `psql`. Add a table. Add some records. Read those records.
* :yellow_heart: Create tables using SQL.
  * Make it so that when you list a table (`\dt`) in `psql`, you see a table you created.
* :yellow_heart: Use SQL query terms like `SELECT`, `FROM`, `WHERE`, `*`.
  * Use `psql` to read all bookmarks, then just bookmarks with `https` URLs, from a database.
* :yellow_heart: Use SQL CRUD terms like `INSERT`, `DELETE`, and `UPDATE`.
  * Use `psql` to create a new bookmark in a database. Then update its URL. Then delete it.
* :yellow_heart: Implement a many-to-many relationship.
  * Get all tags for a bookmark using SQL, and all bookmarks for a tag using SQL, or with methods like this: `bookmark.tags` and `tag.bookmarks`.

### Tooling

* :yellow_heart: Set up a test environment.
  * When you run your tests, your application only writes and reads data from a 'test database'. The test database is emptied between tests. 
* :green_heart: Use database GUIs to interact with databases.
  * Use TablePlus to read and write from and to your database.
* :green_heart: Use Rake to automate environment tasks.
  * Take a script you run from the command-line like this: `ruby my_automation_script.rb` and make it work when you do this: `rake script:automate`.

## Skills

* :yellow_heart: Test-Drive advanced Objects in Ruby, including adapter, wrapper, and service objects.
  * Write a test for a `Bookmark.create` method that takes properties as arguments, and gives you back an object which exposes all those properties as attributes, and has an `id` attribute.
* :heart: Use a step-by-step approach to pull out logic from concretes to abstractions.
  * Take a line of SQL written in a controller that reads bookmarks from the database. Encapsulate it in a method on a `Bookmark` model.
