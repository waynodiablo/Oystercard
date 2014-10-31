# Active Record

Web frameworks typically include a friendly of getting your web app talking to a database. These are called **ORMs**, short for *object-relational mapping*. 

In Sinatra, you've used DataMapper to perform this task. In Rails, the built-in ORM is **Active Record**.

@@TOC@@

### What is it?

Active Record is a piece of software that interprets Ruby commands and turns them into SQL queries for you, so you don't have to deal with that yourself.

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


## Further reading

Martin Fowler 