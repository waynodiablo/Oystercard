# Parallel assignment

Consider this code:

````ruby
age = player[:age]
name = player[:name]
````

You can refactor it to an equivalent code that takes only one line of code

````ruby
age, name = player[:age], player[:name]
````

It also works if you have an array on the right side of the assignment. Let's say you've got an array with a name, age and a job title that you read from a file:

````ruby
employee_data = file.readline #=> ["Joe Wilson", 17, "salesman"]
````

If you want to assign all elements to variables, you can do it in one line:

````ruby
name, age, job_title = employee_data
"#{name}, aged #{age}, is a #{job_title}" #=> "Joe Wilson, aged 17, is a salesman"
````


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/parallel_assignment.md)
