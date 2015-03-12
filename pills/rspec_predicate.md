# RSpec - Predicate matchers

Predicate matchers are a nice feature of RSpec to enhance the readability of your code.

We can use predicate matchers any time we're working with methods that *end with a ?*.

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

The problem here is that our expectation doesn't read like an English sentence. We can refactor our test to use a predicate matcher like so:

```ruby
it 'is hairy' do
  fido = Dog.new
  expect(fido).to be_hairy
end
```

This test is 100% equivalent to the previous version, but is much more readable. Behind the scenes, RSpec takes everything after the `be_` (`hairy`) - adds a question mark to make `hairy`, then calls that method (expecting it to return a [truthy](https://github.com/makersacademy/course/blob/master/pills/boolean.md) value).

[TODO merge in the below in with the above]

`expect(the_bike).not_to be_broken` seems to be quite complex, let's break it down and analyse it.

The `expect()` method is provided by [rspec](http://rspec.info). It takes the object under test as an argument and returns a special object that has different methods that make the example pass or fail, depending on their arguments. One of these methods is `not_to()` that takes yet another [rspec](http://rspec.info) method `be_broken()` as an argument. Then the `not_to()` method takes a look at its argument and realises that if we don't expect the bike to `be_broken`, we must have a method `broken?()` in the `Bike` class. So it calls this method on the bike object that we passed to the `expect()` method and if it returns true, fails the example because we expect it `not_to` be true (:pill: [RSpec - Predicate matchers](https://github.com/makersacademy/course/blob/master/pills/rspec_predicate.md)).

The paragraph above is still complicated. Read through it several times but if it still seems unclear, don't worry, it's a bit advanced for now. We still want to explain it so that you know that this line of code is some crazy magic. Once you get more experience with [rspec](http://rspec.info), you'll get used to how it works.

[TODO: This document is very wordy - can we pull that language into pills and have more diagrams here?]

Why does it have to be so complicated? Because [rspec](http://rspec.info) is designed to write tests that read like English:

````ruby
# Expect the bike not to be broken
expect(the_bike).not_to be_broken
````

In order to achieve this readability [rspec](http://rspec.info) goes to great lengths doing all those crazy things described above. That's why it's complicated.

Another way to rewrite this line is

```ruby
# Expect the method broken? of the object 'bike' to return false
expect(the_bike.broken?).to be_false # in RSpec version 2.x.x
# or
expect(the_bike.broken?).to be false # in RSpec version 3.x.x
````

This is slightly less readable, isn't it? Yet it's exactly the same thing. Yet another way to write the same expectation is to use an old [rspec](http://rspec.info) syntax:

````ruby
# The method broken? of the object 'bike' should return false
bike.broken?.should be(false)
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
it 'has no flease' do
  fido = Dog.new
  expect(fido.has_fleas?).to eq false
end
```

Again, we can rewrite this test to be much more readable:

```ruby
it 'has no flease' do
  fido = Dog.new
  expect(fido).not_to have_fleas
end
```

This works like the previous example, but RSpec takes the additional step of transforming `have_` into `has_`.

## Predicates with arguments

Finally, we can also pass arguments into predicate matchers. For example:

```ruby
class Dog
  def is_friendy_to?(species)
    return 'false' if species == 'cats'
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
it 'is unfriendly to cats' do
  fido = Dog.new
  expect(fido).not_to be_friendly_to('cats')
end

it 'is friendly to everything else' do
  fido = Dog.new
  expect(fido).to be_friendly_to('humans')
end
```

Can also be rewritten using predicate matchers:

```ruby
it 'is unfriendly to cats' do
  fido = Dog.new
  expect(fido).not_to be_friendly_to('cats')
end

it 'is friendly to everything else' do
  fido = Dog.new
  expect(fido).to be_friendly_to('humans')
end
```

## Resources

- [Official RSpec docs on predicate matchers](https://www.relishapp.com/rspec/rspec-expectations/v/3-0/docs/built-in-matchers/predicate-matchers)
