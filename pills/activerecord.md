# Active Record

Web frameworks typically include a friendly way of getting your web app talking to a database. These are called **ORMs**, short for *object-relational mapping*. 

In Sinatra, you've used DataMapper to perform this task. In Rails, the built-in ORM is **Active Record**.

- [What is it?](#what-is-it)
- [Pluralisation is important](#pluralisation-is-important)
- [CRUD commands in Active Record](#crud-commands-in-active-record)
- [Validations](#validations)
- [Migrations](#migrations)
- [Further reading](#further-reading)

### What is it?

Active Record is two things.

Firstly, the *active record pattern* is an architectural design pattern for software that works with databases, which Martin Fowler first named (see the Further Reading section at the end of this pill). In this pattern, each database table becomes a *class*, and an *instance* of that class refers to a specific row within that table.

So a `RESTAURANTS` table becomes a `Restaurant` class, and a given `Restaurant` is mapped to a row of that table. We can ask that `Restaurant` instance questions about itself – its ID, its name, etc. – by making method calls to it, and our ORM will handle turning those queries into SQL commands and returning the result.

Secondly, *Active Record* is a piece of software that interprets Ruby commands and turns them into SQL queries for you, so you don't have to deal with that yourself. It's part of Rails, so you get it by default with all Rails apps.

### Pluralisation is important

### CRUD commands in Active Record

As you might expect, CRUD commands (create, read, update, delete) are super easy with Active Record.

Let's say we have a User model that we're working with at the moment (so a CREATE command will make a new user).

| Action | Command |
| ------ | ------- |
| CREATE | `User.create`, `User.new` |
| READ | `User.first`, `User.all`, `User.find_by(name: 'Dave')` |
| UPDATE | `user.update(name: 'Spike')` (where 'user' has been defined) |
| DELETE | `user.destroy` (where 'user' has been defined) |

**Create** is a funny one. You can either give the user some properties and create it in a single step with `User.create`:

```ruby
User.create(name: "Dave", occupation: "Philosopher/Ruby legend")
```

Or in two steps with `User.new` and then `User.save`:

```ruby
# creates a user but doesn't save it to the database
user = User.new 

# give the user some properties:
user.name = "Spike"
user.occupation = "node Warrior"

# and then save.
user.save
```

There are many more **Read** methods than can be covered here – have a look at the [appropriate RailsGuide](http://guides.rubyonrails.org/active_record_querying.html) for a comprehensive list.

### Validations

Model validations are performed by Active Record – you know, all those tests for 'uniqueness' and password length and so on.

### Migrations

Active Record also deals with migrations. (Is there *anything* it doesn't do?)

## Further reading

* [Martin Fowler, *Patterns of Enterprise Application Architecture*](http://books.google.co.uk/books?id=FyWZt5DdvFkC&lpg=PA1&dq=Patterns%20of%20Enterprise%20Application%20Architecture%20by%20Martin%20Fowler&pg=PT187#v=onepage&q=active%20record&f=false) – Google Books
* [Active Record Basics](http://guides.rubyonrails.org/active_record_basics.html) – RailsGuides
