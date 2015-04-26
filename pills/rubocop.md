Using Rubocop

Please also ensure that you have [RuboCop](https://github.com/bbatsov/rubocop) operating as an [editor plugin](https://github.com/bbatsov/rubocop#editor-integration), or at the very least from the command line so that you can check every line of Ruby for any stylistic errors.  See the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide) for details - it is particularly important to ensure that your Ruby files have a consistent style in terms of indentation etc.  It makes it easier to find errors in your code, and employers will be turned off by inconsistent coding style.  So make yourself employable and make sure you fix all RuboCop issues before you try to write more code, fix tests, or do anything else at all.


You should be able to run 'rspec' command in the base directory (i.e. the folder that holds the 'spec/' directory).  However if you are really keen on getting a job we recommend setting up your environment so that RuboCop will check for style violations before running any tests.  RSpec is a Ruby library or 'gem'.  In order to use RSpec we need to run 'gem install rspec'.  If we install two other gems, 'rake' a task management tool and 'rubocop' a style checker, we can add the following 'Rakefile' to the base of our project.

```ruby
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new(:cop)
RSpec::Core::RakeTask.new(:spec)

task default: [:cop, :spec]
```

and then all RSpec tests can be run using the command 'rake' which will do the equivalent of running first 'rubocop' and then 'rspec'.  The main advantage here is that you will not run your tests until you have fixed any style issues with your code.  Again please **DO NOT** copy and paste the above file, please type it out.  It may not make complete sense now, but this is pure Ruby and in time you will understand every component.  Eventually we'll see how the '::' symbol is used to refer to the nested namespaces created by Ruby classes and modules being defined within each other.

So now our file structure looks like this:

```sh
→ tree
.
├── README.md
├── Rakefile
└── spec
    └── feature
        └── public_bike_access_spec.rb
```

We'll also need one system file that won't show up on a tree view like this.  Please also add the following to a file named '.rubocop.yml'

```yml
Documentation:
  Enabled: false
Style/MethodDefParentheses:
  Enabled: false
```

These are Makers specific customizations of the Ruby style guide.  Once this is in place we can type the command 'rake' at the command line in the directory with the 'spec' folder and assuming no style violations we get something like the following:

:construction: UNDER CONSTRUCTION :construction:
