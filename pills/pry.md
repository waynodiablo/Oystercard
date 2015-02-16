# Pry

[REPLs](http://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) are one of the most valuable tools in your arsenal as a Developer. They allow you to become one with the programming language in a way that cannot be overstated.

Imagine you could see the world as Ruby sees it... REPLs give you EXACTLY that - __RUBY'S EYES!!!__

![NeoVision](https://raw.githubusercontent.com/makersacademy/course/master/pills/images/code_vision.jpg?token=ACI6tY6F41BUs0FM95qEDBZDqw-X4cuLks5U6urywA%3D%3D)

That's right - you can see precisely what Ruby is seeing. How many real-life conflicts would be resolved by being able to see through the other party's eyes? This is why using a REPL is so useful.

### IRB vs Pry

So [Pry](http://pryrepl.org/) isn't the only game in town. In fact, the default baked-in REPL is called IRB, and doesn't need to be installed. Our own Mihai is such an IRB advocate that he is likely to delete this pill out of sheer loyalty ;) To run IRB, simply fire up your Terminal (or better yet iTerm), and type ```irb```. More information on IRB can be found [here](https://github.com/makersacademy/course/blob/master/pills/irb.md).

To install Pry, simply type the following into your Terminal:
```shell
gem install pry
```

### So Why Pry?

Pry gives you a few features that are not currently supported by IRB. It is extendible and allows you:

#### Syntax Colouring

Some might argue that this isn't necessary, but for me it makes my code so much more readable, and therefore enjoyable <3

#### Previous Line Editing

This is huge. One thing that used to put me off using a REPL was the fact that if I made a mistake when writing out a method, I would have to start the entire thing again. but with Pry this is less of a problem:

```ruby
ᚹᚱᛘ ᛬ def hello
     |   puts "goodbye" # Damn, I meant to write puts "hello"
     |   show-input # This is a Pry command, to give me line numbers
1: def hello
2:   puts "goodbye" # Now I know I need to edit line 2...
     |   amend-line 2 # Another Pry command
1: def hello
2:
     |   puts "hello" # Pry goes back to line two, and lets me start typing again
     | end
=> :hello # and we see here that the method hello has been created!

```
Your prompt won't look like mine, as I have customised it. The default prompt looks more like this: ```(pry) main: 0>```

#### Gist Integration

[Github Gists](https://help.github.com/articles/about-gists/) are fantastic ways to share code snippets with others. You might just be trying to explain how a method/concept works for example and need to share properly formatted code remotely but you don't want to set up a whole repo just for a small piece of code. Or perhaps you want to share a top-secret algorithm without paying for private repos on Github. Either way, Gists are the answer, and Pry allows you to utilise them.

You will need to install an extra gem:
```shell
gem install pry-gist
```

Now, remember our ```hello``` method from before? Let's say I want to send this ground-breaking piece of code to Stephen via instant messaging - I can get Pry to create a gist for me:

```ruby
ᚹᚱᛘ ᛬ gist hello
```
This should result in the following output:

```shell
Gist created at URL https://gist.github.com/6a99e05ea063a8fe2f20, which is now in the clipboard.
```

See that? Pry not only creates your Gist, but places it on your clipboard too! All you have to do is click in your Broswer's address bar and paste...

There are lots of other options with this particular integration, which I have included below:

```ruby
gist -m my_method                         # gist the method my_method
  e.g: gist -d my_method                  # gist the documentation for my_method
  e.g: gist -i 1..10                      # gist the input expressions from 1 to 10
  e.g: gist -k show-method                # gist the command show-method
  e.g: gist -c Pry                        # gist the Pry class
  e.g: gist -m hello_world --lines 2..-2  # gist from lines 2 to the second-last of the hello_world method
  e.g: gist -m my_method --clip           # Copy my_method source to clipboard, do not gist it.
```

#### Command Line Navigation

Super simple, but Pry will run any terminal command as long as you put a ```.``` first :)

```ruby
ᚹᚱᛘ ᛬ .pwd
/Users/roidriscoll
```

How useful is that?! :)

#### Debugging with Pry

One of the most useful features in Pry is the ability to insert a line into your code which acts as a breakpoint. When you then run that code, Pry will automatically open, and you will be inside your program, frozen in time at that exact location. This means that you can use Pry to interrogate your objects and see exactly what's going on with your variables etc to make sure that everything is going as planned.

[Check out this excellent tutorial on how to debug using Pry.](http://yorickpeterse.com/articles/debugging-with-pry/)

If you are looking for a tl;dr, just write some code, ```'require pry'``` at the top of the file, and put ```binding.pry``` where you want time to stand still. Here's some sample code for you to give that a try:

```ruby
require 'pry'

string  = " <- index number"
array   = [0,1,2,3,4,5]

binding.pry # Now poke around inside 'array'

array.each do |element|
  array[element] =  element.to_s + string
end

# place binding.pry here, next, and see what's going on with 'array' now...

puts array

```
