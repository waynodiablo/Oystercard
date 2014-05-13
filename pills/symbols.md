# Symbols

So far we've dealt with very simple objects: numbers, strings (text), etc. On top of this Ruby has another class of objects called symbols. They are very widely used in Ruby, so they deserve a mention.

A symbol is an object of class Symbol. It begins with a colon:

````ruby
:this_is_a_symbol
:and_another_one
:france
:"even this is a symbol"
````

Symbols are not variables, so you can't assign anything to a symbol. However, you can use symbols as values:

````ruby
country = :france
player = :computer
current_mode = :drawing
````

They are often used in hashes as keys:

````ruby
capitals = {:france => "Paris", :germany => "Berlin"}
puts "The capital of France is #{capitals[:france]}"
````

Symbols are different from strings in many regards. Firstly, they are immutable. You can't change a symbol, split it in two or read its last character (unless you convert it to the string first). Secondly, they are created in memory only once, unlike strings.

````ruby
capital = "London" # memory allocated
current_city = "London" # memory allocated again
country = :france # memory allocated
last_visited = :france # the same symbol is reused
````

For a small number of variabless it doesn't matter, though.

Symbols are notoriously hard to understand if you never used them. A good rule of thumb is to use them whenever you need an identifier that should not change. Don't worry if it sounds confusing at the moment: we'll be using them in plenty of examples later.

## Symbols as hash keys

You know how to use strings as hash keys:

````ruby
capitals = {"France" => "Paris", "Germany" => "Berlin"}
````

You know how to use symbols as hash keys:

````ruby
capitals = {:france => "Paris", :germany => "Berlin"}
````

There is one more syntax that allows using symbols as hash keys:

````ruby
capitals = {france: "Paris", germany: "Berlin"}
````

Even though there's no colon in front of the symbol name, this is a perfectly valid syntax (introduced in Ruby 1.9). It's only used for hashes, so you can't use it anywhere else.

You can verify that it's just an alternative syntax by trying it in the irb. Note how irb uses the default syntax when it echoes the hash back to you.

