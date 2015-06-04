# Floats

Working with numbers in Ruby is simple and intuitive:

```ruby
1 + 1
#=> 2

5 * 5
#=> 25
```

However, when we're working with integers (whole numbers), we can sometimes get unexpected results:

```ruby
(3 / 5) * 15
#=> 0
```

Why does this return 0, rather than the expected result 9? When we perform an operation with integers that doesn't return a whole number, Ruby will round to the nearest integer:

```ruby
5 / 2
#=> 2

17 / 10
#=> 1

3 / 5
#=> 0
```

This is where the [Float](http://www.ruby-doc.org/core-2.1.2/Float.html) class is useful. We can create a float just by adding a decimal point to the end of our number:

```ruby
cm_in_an_inch = 2.54
cm_in_an_inch.class
#=> Float
```

If any part of an arithmetic operation is a float, the result will be a float too:

```ruby
5 / 2.0
#=> 2.5

5.0 / 2
#=> 2.5
```

We can thus fix our original example:

```ruby
(3.0 / 5) * 15
#=> 9.0
```

We can also convert any integer into a float, using the `.to_f` method:

```ruby
(3.to_f / 5) * 15
#=> 9.0
```

## Limitations of floats

It's important to understand that floats aren't appropriate for all situations. Ruby optimises floats to be efficient - but that means they can behave strangely when we dealing **with large numbers** or situations where **precision is important**.

If you type `129.95 x 100` into a calculator, you should get 12,995 back. However in Ruby:

```ruby
(129.95 * 100) == 12995
#=> false

(129.95 * 100) < 12995
#=> true
```

What's going on here? If we run `129.95 * 100` in isolation, we'll see the problem:

```ruby
129.95 * 100
#=> 12994.999999999998
```

The result is being set to very slightly less than 12,995. Depending on the specific program, this lack of absolute precision may not be a major issue. If it is, we can use the [BigDecimal](http://ruby-doc.org/stdlib-2.1.2/libdoc/bigdecimal/rdoc/BigDecimal.html) class instead, which is less efficient, but guaranteed to be precise.

BigDecimal is part of the standard library - we don't have to install anything, but we do have to `require` it. We can convert a float to a BigDecimal using the `to_d` method:

```
require 'bigdecimal'
require 'bigdecimal/util'

result = 129.95.to_d * 100
result == 12995
#=> true
result < 12995
#=> false
```

## Resources

- [Float class](http://www.ruby-doc.org/core-2.1.2/Float.html)
- [BigDecimal class](http://ruby-doc.org/stdlib-2.1.2/libdoc/bigdecimal/rdoc/BigDecimal.html)
