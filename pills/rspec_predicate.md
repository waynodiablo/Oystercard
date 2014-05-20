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