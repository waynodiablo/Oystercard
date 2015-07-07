# The Configuration Pattern
:construction: Under construction :construction:

A number of Ruby gems have a pattern of configuration that looks like the following.

Given a module `bar`:

```ruby
module Bar

  def baz
    "Hello, World!"
  end

end
```

If we want to configure `Foo`, a gem that implements the configuration pattern, to make available `Bar`'s methods, then we would do the following:

```ruby
require 'foo'
require 'bar'

Foo.configure do |config|
  config.include Bar
end
```

Then we could do something like the following:

```ruby
Foo.run do
  baz #=> "Hello, World!"
end
```

You needn't understand how this is working "under the hood", only why it exists and how to use it. (though [look here](https://robots.thoughtbot.com/mygem-configure-block) if you are interested).

This allows the user of such a gem to *modify* or *extend* its behaviour. In the case of RSpec, for example, we may wish to *extend* its behaviour with a library such as [FactoryGirl](https://github.com/thoughtbot/factory_girl) so that we can easily set up test data. This is done like so:

```ruby
require 'rspec'
require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
```
