# Section 5: Views

We don't have to have a model immediately.  If we **remove the raise statement from the controller and run our tests** we should get the following error:

```
Missing template restaurants/index
```

This is because our controller index action is looking for an erb template to display. Let's create one of those views.

### Creating views

Much like in Sinatra, views tell your app how to present content on the page.  You've already seen how to use erb as a templating language, but there are many more options.  If you're feeling brave, why not give [Haml](http://haml.info/) a try (N.B. you will need to install the gem...)?  There are examples given for both erb and Haml; you only need to use one.

**erb:**
`$ touch app/views/restaurants/index.html.erb`

**haml:**
`$ touch app/views/restaurants/index.html.haml`

(Note the double file extension of the form 'index.html.erb' or 'index.html.haml'. Note that unlike sinatra that we don't have to specify the file directly. )

Now our error is that there's no text on the page! Fix it:

`app/views/restaurants/index.html.erb`:

```html
No restaurants yet
```

`app/views/restaurants/index.html.haml`:

```haml
No restaurants yet
```

Cool – but now RSpec is telling us we need a link on the page.

`app/views/restaurants/index.html.erb`:
```erb
No restaurants yet
<a href='#'>Add a restaurant</a>
```

`app/views/restaurants/index.html.haml`:
```haml
No restaurants yet
%a(href='#') Add a restaurant
```
We've just fudged this by setting the link's `href` value to '#', so it doesn't go anywhere – but it is a link all the same. And our test is passing.

Now let's try running out server again (if we didn't shut it down previously).  Note that we can use the following shorthand (where s is short for server)

```sh
bin/rails s
```

http://localhost:3000/restaurants should now show the content of the index.html.erb file in the browser.  There's a bit more work to get here than with Sinatra, but Rails is providing a layout that we'll use again and again. Each view is automatically wrapped in a layout file that by default is 'app/views/layouts/application.html.erb' which has the following contents:

erb:
```erb
<!DOCTYPE html>
<html>
  <head>
  <title>YelpClone</title>
  <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
  </head>
  <body>

    <%= yield %>

  </body>
</html>
```
haml:
```haml
!!!
%html
  %head
    %title YelpClone
    = stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true
    = javascript_include_tag 'application', 'data-turbolinks-track' => true
    = csrf_meta_tags

  %body
    = yield
```
The yield statement is the place that the controller specific template will be inserted.

### [Next Section - Models](6_models.md)
