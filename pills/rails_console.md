# `rails console`

> **PROTIP: level up your Rails-fu with [this guide to using Rails on the command line](http://guides.rubyonrails.org/command_line.html).**

Rails has a very handy way of letting you play around with the internals of your app.

In Sinatra, you can run `irb` or `pry` to do this, but you also have to manually `require` your application's core files to get this running, which is a bit of a pain.

In Rails, you can just run 

`$ rails console`

and you're up and running. If you're in a hurry, you can type `rails c` instead. 

### Basics

If you've been making Yelp, you'll have Restaurants, Reviews and Users (depending on how far through the walkthrough you are). You can make queries directly on these objects.

```shell
$ rails console
> Restaurant.all # returns all restaurants from the database
> User.all # returns all users
> User.first # gets the first user
> User.find(1) # gets user with id = 1
```

### Manipulating database entries

Say you've filled your database with rubbish and want to wipe it.

```shell
$ rails console
> User.destroy_all
```

### What does this helper do?

Rails has lots of helpers, and `rails console` is a nice way of trying them out interactively. For example, you could have a go with `truncate`:

```shell
> helper.truncate("Testing", length: 5)
=> "Te..."
```

Or how about `pluralize`?

```shell
> helper.pluralize(2, 'dog')
=> "2 dogs"
```


### Playing in the sandbox

You can invoke the console in sandbox mode, so all your changes will be rolled back on reset. Go nuts!

```shell
$ rails console --sandbox
```

