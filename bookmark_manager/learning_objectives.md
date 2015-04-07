##Learning Objectives: Bookmark Manager

*Learning Objectives are organised by topic and subtopic. As you go down the bullet-point list below each subtopic header, skills become more advanced/involved.*

## Databases

### Setup
* Define DataMapper as a gem for including persistence functionality in Ruby classes ('models')
* Configure DataMapper to use a Postgres database
* Construct a data schema within a Ruby model
* Differentiate between `development`, `test`, and `production` environments
* Use DatabaseCleaner to remove data from a test database

### Persistence
* Define 'persistence' as the storage of information long-term
* Contrast database persistence with session persistence and persistence on the filesystem

### SQL
* Know that 'SQL' means 'Structured Query Language'
* Explain how SQL is used to query databases
* Use SQL query terms like `SELECT`, `FROM`, `WHERE`, and `*`

### Relational Databases
* Describe the structure of a database, referencing 'tables' and 'rows'
* Define 'primary key' as the main key for a database table row
* Define 'foreign key' as a key referencing rows on a different database table
* Describe 'relational' databases as databases that store references to other tables as 'foreign keys'

### Postgres
* Define 'PostgreSQL' as 'a particular type of relational database'
* Know that `psql` is a command-line tool to interact with a Postgres database
* Install Postgres
* Use the psql command to interact with Postgres

### Server interaction with Database
* Use incoming `params` to persist models to a database
* Create a many-to-many relationship between models using `:through`
* Create a bookmark manager that interacts with a database
* Use validation within models through DataMapper's `validates_uniqueness_of` method
* Use validation at the database level through DataMapper's `:unique` option

### Security/Passwords
* Define Bcrypt as a library for encrypting/decrypting strings
* Explain that Bcrypt functionality can be included in Ruby models by including the `bcrypt` gem
* Use Bcrypt to encrypt a password and save it to the database
* Use `session` to manage a user's authenticated state
* Configure password verification with a `password_confirmation` field
* Create a basic registration/authentication system from scratch
* Create a password recovery system

### Rake tasks for database management
* Know that common tasks are contained within the 'Rakefile'
* Define common tasks such as `migrate`
* Run common tasks from the command line with `rake`

## Backend development

### Sinatra
* Integrate Postgres persistence with Sinatra
* Use `redirect_to`
* Use 'wildcard' `params` within Routes (such as `/tags/:text`)
* Create helpers
* Handle input errors
* Use the `flash` to display messages to users
* Create more descriptive routes
* Send emails using Sinatra

## Frontend development

### CSS
* Use a CSS Reset
* Use CSS properties including `display`, `background`, `background-image`, `color`, etc
* Define classes in HTML and style them using CSS
* Use shadows in CSS
* Use `flexbox`
* Style a frontend of medium complexity using CSS

### HTML/ERB
* Use `erb` syntax to display data from Ruby models within a template
* Construct a form to `POST` model data from the frontend to the server
* Use helpers (like `current_user`) within templates
* Create a mid-complexity frontend structure using `erb`
* Construct a form for signing up ('registering') a user
* Construct a form for signing in ('authenticating') a user
* Construct a form for signing out ('de-authenticating') a user

## Testing

### TDD
* Use the TDD process to build a database-interacting interface, step-by-step

### RSpec & Capybara
* Use RSpec to test database functionality
* Use Capybara to create feature tests that include database functionality
* Refactor Capybara feature tests to modularize database processes
