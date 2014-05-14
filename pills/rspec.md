# RSpec

[RSpec](http://rspec.info) is one of the most used Behaviour Driven Development tools in the ruby community.

Before we start you will need to install [RSpec](http://rspec.info) on your machine.

````ruby
gem install rspec
````

Once you have installed [RSpec](http://rspec.info) you can see the different options of [RSpec](http://rspec.info) running the help command.


````ruby
rspec --help
````

## Hello BDD, hello RSpec

Let's write our first *test driven* program!

We will start with something simple and work our way up from there. Imagine we want to create a method that will greet us. What we want is a method we can call, passing in a name, and have a personalised greeting in return.

We first start by creating a new file calling it **greeter_spec.rb** with the following content:

````ruby
describe 'Greeter' do
  it 'greets Rico' do
    expect(greet('Rico')).to eq 'Hello, Rico, how are you today?'
  end
end
````

Once we save and run this code with **rspec greeter_spec.rb** we will see the code fail. Don't get anxious about this, [RSpec](http://rspec.info) is just trying to tell you what has happened and give you a hint as of what you can do to sort this out.

```
 rspec greeter_spec.rb
      
      Failures:
        
        1) Greeter greets Rico
           Failure/Error: expect(greet('Rico')).to eq 'Hello, Rico, how are you today?'
           NoMethodError:
             undefined method `greet' for #<RSpec::Core::ExampleGroup::Nested_1:0x007f9b55073800>
           # ./greeter_spec.rb:3:in `block (2 levels) in <top (required)>'
      
      Finished in 0.00036 seconds
      1 example, 1 failure
        
      Failed examples:
        
      rspec ./greeter_spec.rb:2 # Greeter greets Rico
````

If you look closer at the error message you will notice that the only thing [RSpec](http://rspec.info) is trying to tell us is that there is no such method called **greet**.
Let's look first into what we have done here. The first thing you notice is that we started our spec with a **describe** block.

````ruby
describe 'Greeter' do
````

What we are doing here is setting up our specification; we are trying to describe *something*, in this case our greeting method.

Next we start our *description* with something we want to describe about the greeter we are building. We enclose this **examples** (*some people call them test cases*) into **it blocks**.

Inside the **it block** we will add our test code. In our simple greeter the **it block** only contains the actual expectation we are setting:

````ruby
      expect(greet('Rico')).to eq 'Hello, Rico, how are you today?'
````

There is actually a lot going on here, let's look into it with more detail. Before we do that though I would like you to notice how well this actually reads; it's almost like an english phrase!

> Expect greet Rico to equal "Hello, Rico, how are you today?"

Examples, like this one, follow a common structure. First you prepare your data, then you perform some action and at the end you make sure what you where expecting did happen. We developers like to call that **Given, When, Then**.

Did the example we wrote have these elements? It actually did, the only reason you didn't see them at first is because we wrote them *inline*. How would it look like if we actually separated the example into it's **Given,When, Then** parts?

````ruby
it 'greets Rico' do
  name = 'Rico' # Given
  result = greet(name) # When
  expect(result).to eq 'Hello, Rico, how are you today?' # Then
end
````

Did you notice the **eq**? This is a so called [Matcher](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers). A [matcher](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers) is essentially a method that will match the operation inside the expect method (result) with the expectation ('Hello, Rico, how are you today?’). [RSpec](http://rspec.info) has a lot of [build in matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers) that you can make use of while writing your specs (*you can even write your own matchers!*)

The next thing we need to do is implement this method, but remember, we only want to implement the **simplest code that could possibly work!**

Let's first create a file `greeter.rb` with this content:

````ruby
def greet(name)
  'Hello, Rico, how are you today?'
end
````

If you impatiently ran the spec again you might have noticed that it's still failing for the same reasons as before. This is because we haven't told [RSpec](http://rspec.info) where to find the code we just wrote inside of our `greeter_spec.rb` file:

````ruby
require './greeter'

describe 'Greeter' do
    ...
````

Running the spec now will result in the test to pass:

````
rspec -f p greeter_spec.rb
.

Finished in 0.0085 seconds
1 example, 0 failures
````

One of the things that most people complain about is the concept of doing **the simplest thing that could possibly work**. If you look into our greet method this becomes obvious; trying to call the **greet** method with a different name, say **Chloë**, will obviously fail. **Or will it?** For a simple method like *greet* the answer is easy and obvious, when our code becomes more complex this **obvious** answers don't seem to be that obvious any longer. In order to avoid assumptions we need to prove that the code *really* does what we want it to do by writing another example in our spec file:

````ruby
it 'greets Chloë do
  expect(greet(“Chloë”)).to eq ‘Hello, Chloë, how are you today?’
end
````

Running [RSpec](http://rspec.info) will fail now (*and for the right reason*):

rspec -f p greeter_spec.rb
.F
      
Failures:
      
  1) Greeter greets Chloë
     Failure/Error: expect(greet('Chloë')).to eq 'Hello, Chloë, how are you today?'
          
      expected: "Hello, Chloë, how are you today?"
                  got: "Hello, Rico, how are you today?"
              
             (compared using ==)
      # ./greeter_spec.rb:11:in `block (2 levels) in <top (required)>'
            
      Finished in 0.00068 seconds
      2 examples, 1 failure
          
      Failed examples:
      
      rspec ./greeter_spec.rb:10 # Greeter greets #{student_name}
````

Fixing this code should be trivial enough, **let's do that!**

````ruby
def greet(name)
  "Hello, #{name}, how are you today?"
end
````

If we run our specs now we will see that our code works as expected:

````
rspec -f p greeter_spec.rb
..
      
Finished in 0.0006 seconds
2 examples, 0 failures
````

This simple example illustrates various points that you should keep in mind when writing software:

- Never assume anything or take anything for granted
- Only write the simplest thing that could possibly work to make a test pass.
It might be counter intuitive and awkward at the beginning, but it will make your code easier to read and write.
- **Baby Steps!**


When working on a project though you will not have your specs side by side with your *production* code. A common directory structure in a project looks more like this:

````
      ├── lib
      │   └── greeter.rb
      └── spec
          └── greeter_spec.rb
````

This way you are clearly separating your *real* code from your testing code. There is another tangible benefit to this, in your spec file you now can require the file under test much easier:

````ruby
require 'greeter' # No need for that ugly './' anymore
````

Another added benefit is that you can now run RSpec from the top level directory of your project without needing to specify the spec files you want to be running

````
rspec
````

[RSpec](http://rspec.info) will figure out which files are in the *lib directory* and which are in the *spec directory* and will map those with each other (*with help of your requires of course*) so that you can run your specs.
