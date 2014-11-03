# Rails helper methods

## What are helpers?

Rails has lots of helper methods which make life easier. These are methods which can be called on in your web app. `truncate`, for example, accepts a word and an integer as arguments, and then truncates that word if it's longer than the specified length. `pluralize` takes a singular noun and pluralizes it.

`rails console` is a nice way of trying them out interactively. For example, you could have a go with `truncate`:

```shell
> helper.truncate("Testing", length: 5)
=> "Te..."
```

Or how about `pluralize`?

```shell
> helper.pluralize(2, 'dog')
=> "2 dogs"
```
