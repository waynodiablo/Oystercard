# Strings

***Strings*** are the standard way to represent bodies of text of arbitrary content and length.

## String notation

A *string literal* is generally enclosed in quotation marks:

` "This is a string." `

Single quotes can also be used:

` 'This is also a string.' `

But a single-quoted string behaves differently, in some circumstances, than a double- quoted string. The main difference is that [string interpolation](https://github.com/makersacademy/course/blob/master/pills/string_interpolation.md) doesn’t work with sin- gle-quoted strings. Try these two snippets, and you’ll see the difference:

````ruby
2.1.1 :001 > puts "Two plus two is #{2 + 2}."
Two plus two is 4.
 => nil 
2.1.1 :002 > puts 'Two plus two is #{2 + 2}.'
Two plus two is #{2 + 2}.
 => nil 
2.1.1 :003 > 
````

As you’ll see if you paste these lines into irb, you get two very different results:

` Two plus two is 4. `
` Two plus two is #{2 + 2}. `


## Basic string manipulation

**Basic** in this context means manipulating the object at the lowest levels: retrieving and setting substrings, and combining strings with each other.

### GETTING AND SETTING SUBSTRINGS

To retrieve the *n*th character in a string, you use the [] operator/method, giving it the index, on a zero-origin basis, for the character you want. Negative numbers index from the end of the string:

````ruby
>> string = "Ruby is a cool language." => "Ruby is a cool language."
>> string[5]
=> "i"
>> string[-12] => "o"
````

If you provide a second integer argument, *m*, you’ll get a substring of *m* characters, starting at the index you’ve specified:

````ruby
>> string[5,10] 
=>"is a cool "
````

You can also provide a single range object as the argument. 

````ruby
>> string[7..14] 
=> " a cool "
>> string[-12..-3]
=> "ol languag"
````

### COMBINING STRINGS

There are several techniques for combining strings. 

To create a new string consisting of two or more strings, you can use the + method/operator to run the original strings together:

````ruby
>> "a" + "b"
=> "ab"
>> "a" + "b" + "c"
=> "abc"
````

The string you get back from + is always a new string. You can test this by assigning a string to a variable, using it in a + operation, and checking to see what its value is after the operation:

````ruby
>> str = "Hi "
=> "Hi"
>> str + "there."
=> "Hi there."
>> str
=> "Hi"
````

### STRING COMBINATION VIA INTERPOLATION

At its simplest, [string interpolation](https://github.com/makersacademy/course/blob/master/pills/string_interpolation.md) involves dropping one existing string into another.


