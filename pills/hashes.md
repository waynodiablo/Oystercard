# Hashes

Hash is another data structure that's widely used in Ruby. It's also a collection of elements, except that you can specify the indexes (or keys) you use to reference the elements. Consider this code:

````ruby
capitals = {"Great Britain" => "London", "France" => "Paris", "Germany" => "Berlin"}
````

This is very similar to an array, except we can use country names to reference the capitals. So, instead of `capitals[0]` we can now to `capitals["Great Britain"]` to get the same result.

Hashes are very convenient if you need to associates two sets of data: countries and capitals, usernames and number of friends, book titles and the number of readers, and so on.

Just like an array, a hash is an object of class Hash, for which you can easily find the documentation by googling "ruby hash" ([try it!](https://www.google.com/?q=ruby%20hash#q=ruby+hash) ). The Hash class also has lots of methods that allow you to query and update the hash. Finally, just like an array, there are two ways to create a new, empty hash:

````ruby
empty_hash = {}
another_empty_hash = Hash.new # same as {}
````

Play with the hash in irb (:pill:  [irb](https://github.com/makersacademy/course/blob/master/pills/irb.md) ) to learn how to use it. You'll be using hashes and array in every Ruby project you'll ever build.



![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/hashes.md)
