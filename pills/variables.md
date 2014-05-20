# Variables

Ruby would be a rather limited language if the only thing it could do is evaluate various expressions. Fortunately, it's much more powerful than this.

At some point, we'll want to start saving the results of evaluated expressions instead of just calculating them every time – that's where variables come in. For example, let's create a variable `people` with the value "Makers". Instead of providing screenshots, from now on we'll be just showing you what to type in irb (:pill: [Introducing Irb](https://github.com/makersacademy/course/blob/master/pills/irb.md)).

````ruby
people = "Makers"
````

This tells us to store the string "Makers" into the variable people. Notice that when we type `people` in our code, it doesn't have quotations around it – because it's a variable. This is how Ruby can tell the difference between variables (without quotes) and strings (with quotes).

Now we can reuse this variable if we need to:

````ruby
> people = "Makers"
=> "Makers"
> people + ' rock'
=> "Makers rock"
> "Hello, " + people
=> "Hello, Makers"
````

You create (assign) a variable by putting its name on the left and the value – on the right of the assignment.

````ruby
variable_name = value
````
For example:

````ruby
age = 18
name = "Joe Fox"
first_line = "Makers Academy, "
second_line = "25 City Rd., "
postcode = "EC1Y 1AA"
address = first_line + second_line + postcode
````

The value of `address` will be "Makers Academy, 25 City Rd., EC1Y 1AA". So, you create new variables (and change them) by putting the variable name on the left and the value on the right of the assignment.