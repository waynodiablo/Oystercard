### Rake tasks for database management
:construction: :construction: :construction: THIS IS UNDER CONSTRUCTION :construction: :construction: :construction:

Since we are changing the schema of the database in a destructive way (creating a unique index), we need to execute `DataMapper.auto_migrate!` instead of `DataMapper.auto_upgrade!` after we create a unique index.

Right now our `auto_upgrade!` call is in `data_mapper_setup` but this creates two problems. First, we don't want to edit this file every time we want to run `data_migrate!` instead. Second, we don't want to run `auto_upgrade` every single time we respond to a request. Let's create a rake task for these operations, so that we could call them manually when we need to.

As we've seen before Rake is a tool for running automated tasks. The tasks are defined in `Rakefile` (with capital R). Add the following to a file called 'Rakefile' in the root folder of the project.

```ruby
require 'data_mapper'
require './app/data_mapper_setup'

task :auto_upgrade do
  # auto_upgrade makes non-destructive changes.
  # If your tables don't exist, they will be created
  # but if they do and you changed your schema
  # (e.g. changed the type of one of the properties)
  # they will not be upgraded because that'd lead to data loss.
  DataMapper.auto_upgrade!
  puts 'Auto-upgrade complete (no data loss)'
end

task :auto_migrate do
  # To force the creation of all tables as they are
  # described in your models, even if this
  # may lead to data loss, use auto_migrate:
  DataMapper.auto_migrate!
  puts 'Auto-migrate complete (data could have been lost)'
end
# Finally, don't forget that before you do any of that stuff,
# you need to create a database first.
```


The syntax should be self-explanatory. We define two tasks: "auto_migrate" and "auto_upgrade". Whenever we want to run any of them, we just invoke rake from the command line:

```
$ rake auto_migrate
```

This way you can upgrade or migrate your database manually after every change to the model. Ruby on Rails makes extensive use of Rake tasks, as we'll see later.
