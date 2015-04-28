# Understanding the stack trace from Boris Bikes

When Ruby encounters an exception, it will raise that exception through the layers of the currently executing code (called the 'stack').  If no code in the stack handles the exception, it will eventually terminate the program and output a [stack trace](https://en.wikipedia.org/wiki/Stack_trace).

The stack trace is useful as it helps us to understand where in our program the error lies and the route the code took to get there.

Here is the stack trace from [Stage 3 of Boris Bikes](../boris_bikes/boris_bikes_stage_3.md):

```
/Users/silvabox/source/makers_academy/boris-bikes/spec/bike_spec.rb:1:in `<top (required)>': uninitialized constant Bike (NameError)
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1226:in `load'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1226:in `block in load_spec_files'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1224:in `each'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1224:in `load_spec_files'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/runner.rb:97:in `setup'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/runner.rb:85:in `run'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/runner.rb:70:in `run'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/runner.rb:38:in `invoke'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/exe/rspec:4:in `<top (required)>'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/bin/rspec:23:in `load'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/bin/rspec:23:in `<main>'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/bin/ruby_noexec_wrapper:14:in `eval'
	from /Users/silvabox/.rvm/gems/ruby-2.0.0-p195/bin/ruby_noexec_wrapper:14:in `<main>'
```
The first line is the most important one. It explains what the problem is and where it occurred:

```
/Users/silvabox/source/makers_academy/boris-bikes/spec/bike_spec.rb:1:in `<top (required)>': uninitialized constant Bike (NameError)
```

In this case, the problem is in the file `bike_spec.rb` on line 1. The `<top (required)>` means that the code causing trouble is not part of any specific method. The error that occurred is of the type [NameError](http://www.ruby-doc.org/core-2.1.5/NameError.html) and it's human-readable explanation is `uninitialized constant Bike`

Other lines in the output show the path in the code Ruby went through before encountering the error on line 1 of `bike_spec.rb`. The second line was executed right before the line 1 was executed.

```
/Users/silvabox/.rvm/gems/ruby-2.0.0-p195/gems/rspec-core-3.2.2/lib/rspec/core/configuration.rb:1226:in `load'
```

This tells us that a line 1226 in the file `configuration.rb` that is inside a method "load" called our line in bike_spec that ultimately caused an error. This file is part of the [rspec-core](https://github.com/rspec/rspec-core) gem, version 3.2.1 that's installed for the version of Ruby 2.1.5 managed by the Ruby Version Manager rvm (hence these files are all in ~/.rvm). Normally you wouldn't go there unless you suspect a gem is misbehaving or you want to really understand how it works. However, if this stack trace goes through your code for a while before raising an error, this information would be far more valuable.

The next line in the stack trace shows what was executed directly before `configuration.rb:1226` and so on. In this case the stack trace is showing the flow of execution through the underlying system code before the error was encountered.  In general you'll be hunting through stack traces to see if there are any parts of *your code* being hit and focusing on those.
