# RSpec - Predicate matchers

Predicate matchers are a nice feature of RSpec to enhance the readability of your code.

We can use predicate matchers any time we're working with methods that *end with a ?*.  By convention ruby methods that end with a question mark are expected to return a boolean (true or false) value.

## Expect to be_x

Imagine we have a `Dog` class with a method `hairy?`, which returns true.

```ruby
class Dog
  def hairy?
    true
  end
end
```

and an associated passing test:

```ruby
it 'is hairy' do
  fido = Dog.new
  expect(fido.hairy?).to eq true
end
```

Let's just review we are clear about how the above `expect(fido.hairy?).to eq true` works.  It is pure ruby code with parentheses omitted to make it more readable.  Here's what it would look like as ruby with all the parentheses added in:

```ruby
expect(fido.hairy?()).to(eq(true))
```

'expect', 'to' and 'eq' are all methods that RSpec provides.  'eq(true)' calls the RSpec method 'eq' with the single argument 'true', which returns an RSpec [Equality matcher object](http://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/equality-matchers), which is then passed an argument to the RSpec method 'to', which is being called on the the RSpec object that was returned as a result of calling 'expect(fido.hairy?())'.  This might seem hopelessly convoluted, but it is designed to make the end result more readable.

```ruby
expect(fido.hairy?).to eq true
```

It's also great practice of your Ruby skills to work out the series of calls and returning objects that support these kinds of statements.

However even though with poetry mode and so forth, this expectation doesn't read like an English sentence. We can refactor our test to use a [predicate matcher](http://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/predicate-matchers) like so:

```ruby
it 'is hairy' do
  fido = Dog.new
  expect(fido).to be_hairy
end
```

This test is much more readable than the previous version and is almost equivalent. Behind the scenes, RSpec takes everything after the `be_` (`hairy`) - adds a question mark to make `hairy`, then calls that method, expecting it to return a [truthy](https://github.com/makersacademy/course/blob/master/pills/boolean.md) value.  Note that the following expressions *are not equivalent*:
```ruby
expect(fido.hairy?).to be true
expect(fido.hairy?).to be_truthy
```
The first tests that `fido.hairy?` returns the specific value `true` (an instance of `TrueClass`).  The second tests that `fido.hairy?` returns any object that evaluates to true in Ruby (i.e. anything other than `false` and `nil`).

Why does it have to be so complicated? Because [rspec](http://rspec.info) is designed to write tests that read like English:

````ruby
# Expect the bike to be working
expect(bike).to be_working
````

In order to achieve this readability [rspec](http://rspec.info) goes to great lengths doing all those crazy things described above. That's why it's complicated.

Another way to rewrite this line is

```ruby
# Expect the method working? of the object 'bike' to return true
expect(bike.working?).to be_true # in RSpec version 2.x.x
# or
expect(bike.working?).to be_truthy # in RSpec version 3.x.x
````

This is slightly less readable, isn't it? Yet it's exactly the same thing. Yet another way to write the same expectation is to use an old [rspec](http://rspec.info) syntax:

````ruby
# The method working? of the object 'bike' should return true
bike.working?.should be_true # in RSpec version 2.x.x
````

The newer `expect` syntax should be used whenever possible but you'll come across older codebases using `should` syntax, so you should be familiar with it as well.


## Expect to have_x

Predicate matchers also work well with methods that begin with `has_`

```ruby
class Dog
  def has_fleas?
    false
  end

  def hairy?
    true
  end
end
```

```ruby
it 'has no fleas' do
  fido = Dog.new
  expect(fido.has_fleas?).to eq false
end
```

Again, we can rewrite this test to be much more readable:

```ruby
it 'has no fleas' do
  fido = Dog.new
  expect(fido).not_to have_fleas
end
```

This works like the previous example, but RSpec takes the additional step of transforming `have_` into `has_`.

## Predicates with arguments

Finally, we can also pass arguments into predicate matchers. For example:

```ruby
class Dog
  def friendly_to?(species)
    return false if species == 'cats'
    true
  end

  def has_fleas?
    false
  end

  def hairy?
    true
  end
end
```

```ruby
describe Dog do
  it 'is unfriendly to cats' do
    fido = Dog.new
    expect(fido.friendly_to('cats')).to be_falsy
  end

  it 'is friendly to everything else' do
    fido = Dog.new
    expect(fido.friendly_to('humans').to be_truthy
  end
end
```

Can also be rewritten using predicate matchers:

```ruby
describe 'Dog' do
  it 'is unfriendly to cats' do
    fido = Dog.new
    expect(fido).not_to be_friendly_to('cats')
  end

  it 'is friendly to everything else' do
    fido = Dog.new
    expect(fido).to be_friendly_to('humans')
  end
end
```

## Resources

- [Official RSpec docs on predicate matchers](https://www.relishapp.com/rspec/rspec-expectations/
docs/built-in-matchers/predicate-matchers)
