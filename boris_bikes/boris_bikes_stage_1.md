## Stage 1: Creating a Feature Test

We cannot possibly implement all functionality at once. We need to start somewhere and then increase the number of features until we are happy.  We'll often talk about a Minimum Viable Prototype (MVP) which is the minimum set of operating features needed for the client to test their business model, but before that we need to start with a single story.  Which story is the most likely to take us towards an MVP? What is the absolute minimum we could implement but still provide some value to the end user? Our first user story sounds promising:

```
As a member of the public,
So that I can get across town,
I'd like to access a bike that is not broken.
```

It's interesting to reflect that one could imagine a version of the boris bikes system that had no code or infrastructure at all.  There could simply be places where bikes could be left unlocked.  Bike rental would be free, and bikes would be returned or not on an honour policy.  One might argue that in London that would soon lead to all the bikes being stolen or broken, and so some system for managing fees and repairs and so forth was essential.  An honour based Boris Bikes system might seem like a joke, but it's excellent practice to check your assumptions.  Could what the client wants be delivered without writing a line of code?  Every line of code you write is a line of code that you may have to maintain in future. Every line of code you write now will support certain features that the client currently wants, but the client may change their mind, or the market may evolve, or who knows what.

To a certain extent you want to hold off writing any code for as long as possible, ensuring that you and your client agree on which user stories deliver value, and then pick the simplest one and exert the minimum effort to support it.  To the extent that a feature can be delivered without writing any code, then go for it and focus the code writing efforts on delivering features that really do require code.

As regards our story, or feature, above, let us assume that we are going to have some way of delivering a working bike to a user.  In the real Boris Bike's system this might involve a real person entering their credit card, validation via an online payment gateway and the unlocking of a physical lock to allow a bike to be removed from a real docking station.  In this tutorial let us assume that the interactive ruby (irb) environment is our user interface, and so if someone can type in something like docking_station.release_bike and that we can check that the bike released is not broken, then this corresponds to the high level feature we are looking for, something like this:

```sh
2.1.5 :001 > d = DockingStation.new
=> #<DockingStation:0x007fcc849f03a0 @bikes=[#<Bike:0x007fcc849f3c80 @broken=false>]>
2.1.5 :002 > b = d.release_bike
=> #<Bike:0x007fcc849f3c80 @broken=false>
2.1.5 :003 > b.broken?
=> false
```

Our goal is that we can create the necessary classes to support the above functionality.  Why did we choose to name the method that releases a bike into the station `release_bike()`. Naming things is one of [two hardest problems in Computer Science](http://martinfowler.com/bliki/TwoHardThings.html). We could have chosen a different name but this one seems good enough.

Now we don't want to have to test this functionality by hand every time we change anything.  It might seem like a trivial amount of effort in this case, but even small projects quickly accumulat a lot of functionality that all might break due to small changes elsewhere in the code base.  To stop us going completely insane chasing bugs back and forth through the system let's start by writing a feature test that will allow us to automatically check that the above is going to work.  We'll be using RSpec, a handy testing tool in Ruby, but there are many other testing tools such as MiniTest and Cucumber to name a couple of popular alternatives.  RSpec provides a syntax that while pure Ruby, reads very like English.

RSpec can also be described as a 'Domain Specific Language' (DSL).  In this case RSpec is a language specific to the domain of writing tests in an 'expect' style (note there are other styles - see the RSpec pill). The motivation is to make the tests as readable as possible, in order to make them comprehensible to other developers and ourselves 3 months later when we come back to look at them again.  The intention is that comprehensibility will lead to good maintainability, since most of the effort developing software comes from maintaining it rather than writing it in the first place.  When change comes, and it most likely will, we want to be able to simply and quickly comprehend what a test is doing and adapt it as necessary.

As mentioned before, in this simple system our feature test will also be an 'integration-test' that checks that two objects in our domain (the DockingStation and the Bike) can interact correctly.

```ruby
#we're describing our high level feature
describe 'member of public accesses bike' do
  # this is a specific outcome related to the feature
  it 'and it is not broken' do
    docking_station = DockingStation.new # initialize a new object, an instance of the DockingStation class
    bike = docking_station.release_bike  # ask the docking station to release a bike
    expect(bike).not_to be_broken        # expect that bike to respond to the method 'broken?' with false
  end
end
```

The above code should be placed in a file in a 'spec/feature' directory and named 'public_bike_access_spec.rb'. Whatever you do, **DO NOT** copy and paste this code, you must type it out yourself (not the comments).  It is essential that you type the code out yourself or you will not learn effectively.

Note that the comments here are simply to help you first time around.  Please don't include them in your code, and in general avoid comments, preferring to write code that is comprehensible without comments.

Please also ensure that you have [RuboCop](https://github.com/bbatsov/rubocop) operating as a browser plugin, or at the very least from the command line so that you can check every line of Ruby for any stylistic errors.  See the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide) [TODO: update toMakers Style Guide?] for details - it is particularly important to ensure that your Ruby files have a consistent style in terms of indentation etc.  It makes it easier to find errors in your code, and employers will be turned off by inconsistent coding style.  So make yourself employable and make sure you fix all RuboCop issues before you try to write more code, fix tests, or do anything else at all.

The code above is quite complex - see the [RSpec pill&nbsp;:pill:](../pills/rspec.md) if any aspect of it is unclear. The line `expect(the_bike).not_to be_broken` is perhaps particularly tricky and there are more details in the [RSpec predicate matchers pill&nbsp;:pill:](../pills/rspec_predicate.md).  For the rest of this stage we'll be focusing on the lines `docking_station = DockingStation.new` and `bike = docking_station.release_bike` and we'll come back to `expect(bike).not_to be_broken` in the next stage when we start writing unit tests.  For the moment the critical thing is that reading it we are clear about the intention of what we want to check, that the bike is not broken, rather than the precise Ruby syntax, but that should become clear by the end of the next stage on unit tests.  First up let's focus on getting this feature test up and partly and least running.

Assuming you have the above code in a file in the following structure:

```sh
→ tree
.
├── README.md
└── spec
    └── feature
        └── public_bike_access_spec.rb

```

You should be able to run RSpec on the base directory (i.e. the folder that holds the 'spec/' directory).  However if you are really keen on getting a job we recommend setting up your environment so that RuboCop will check for style violations before running any tests.  RSpec is a Ruby library or 'gem'.  In order to use RSpec we need to run 'gem install rspec'.  If we install two other gems, 'rake' a task management tool and 'rubocop' a style checker, we can add the following 'Rakefile' to the base of our project.

```ruby
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new(:cop)
RSpec::Core::RakeTask.new(:spec)

task default: [:cop, :spec]
```

and then all RSpec tests can be run using the command 'rake' which will do the equivalent of running first 'rubocop' and then 'rspec'.  The main advantage here is that you will not run your tests until you have fixed any style issues with your code.  Again please **DO NOT** copy and paste the above file, please type it out.  It may not make complete sense now, but this is pure Ruby and in time you will understand every component.

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

Then we can type the command 'rake' at the command line in the directory with the 'spec' folder and assuming no style violations we get something like the following:

```sh
→ rake
Running RuboCop...
Inspecting 2 files
..

2 files inspected, no offenses detected
/Users/tansaku/.rvm/rubies/ruby-2.1.5/bin/ruby -I/Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/lib:/Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-support-3.2.2/lib /Users/tansaku/.rvm/gems/ruby-2.1.5/gems/rspec-core-3.2.1/exe/rspec --pattern spec/\*\*\{,/\*/\*\*\}/\*_spec.rb

member of public accesses bike
  bike is not broken (FAILED - 1)

Failures:

  1) member of public accesses bike and it is not broken
     Failure/Error: docking_station = DockingStation.new
     NameError:
       uninitialized constant DockingStation
     # ./spec/feature/public_bike_access_spec.rb:3:in `block (2 levels) in <top (required)>'

Finished in 0.00049 seconds (files took 0.18432 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/feature/public_bike_access_spec.rb:2 # member of public accesses bike is not broken
```

There's a lot of information here, but it's important to work through it carefully.  There's nothing worse than seeing there's some sort of failure/error and then bashing a way a the code randomly in the hopes of fixing it.  The computer is giving you critical information about the precise nature of the underlying problem and you need to use that to work out what's wrong.  Now if you've worked through the [RSpec pill&nbsp;:pill:](../pills/rspec.md) this type of error and how to fix it should be clear. Do you know what to do?

Have a go in your pair at fixing this, and then check out [Stage 2](boris_bikes_stage_2.md)
