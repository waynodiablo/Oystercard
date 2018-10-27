# Sinatra: `erb`

[Back to the Challenge Map](README.md)

Our web application is far more manageable now we have separated the _routing_ (or 'controller') and _presentation_ (or 'view') concerns. We can still render our delightful cat picture, too:

![Wow, such cat](./images/sinatra_cat_route.png)

In this challenge, you will use `erb` to give your cat a random name.

### Challenge Setup

`erb` is very powerful. It is part of the Ruby Standard Library. When passed a regular string, `erb` will do nothing: in Sinatra, running `erb("a string")` will simply return `"a string"`.

The power of ERB comes when you include the following symbols: `<%= %>` somewhere in a string. Any Ruby expression within those 'braces' will be evaluated, and then interpolated into the string.

Here is an example of both situations.

```ruby
# within a Sinatra route

erb "Hi there, Visitor!"
# => "Hi there, Visitor!"

erb "Hi there, Visitor <%= 2 + 2 %>!"
# => "Hi there, Visitor 4!"
```

If you omit the `=` on the first of the 'ERB tags', the expression will be evaluated but not interpolated into the string:

```ruby
# within a Sinatra route

erb "Hi there, Visitor <% 2 + 2 %>!"
# => "Hi there, Visitor!"
```

### Learning Objectives covered
- Embed a Ruby expression within a View

### To complete this challenge, you will need to:

- [ ] Add an `h1` tag to your `index.erb` view file, with the words 'My name is ' inside it.
- [ ] At the end of the `h1` tag (before it closes), append an empty interpolated Ruby Expression using `<%= %>` ('ERB tags')
- [ ] Inside these ERB tags, write an expression that `sample`s a random name from the following array: `["Amigo", "Oscar", "Viking"]`
- [ ] Restart your server and visit the path associated with the cat route.

### Resources

- [Sinatra Views](http://www.sinatrarb.com/intro.html#Views%20/%20Templates)
- [ERB (Ruby Docs)](http://ruby-doc.org/stdlib-2.2.3/libdoc/erb/rdoc/ERB.html)
- [An introduction to ERB Templating](http://www.stuartellis.eu/articles/erb/)

### [Walkthrough](walkthroughs/sinatra_erb.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/intro_to_the_web/sinatra_erb.md)
