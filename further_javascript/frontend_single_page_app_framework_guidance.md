# Frontend, single page app framework guidance

## What should the framework do for the user?

Think about the things the framework could handle for the user.  Some are common to many frontend, single page apps.  Others are particular to the notes app, and not generally useful.

The notes app needs to do lots of things: generate HTML from data and static HTML, store data in models, generate unique ids for models, update the page content when the browser goes to a new URL, show HTML forms, extract the data from submitted HTML forms, and many other things.  Which of these could your framework handle for the notes app? Which of these things are common enough that they will be useful features for other users building other frontend, single page apps?

## A good abstraction

Once you've decided that your framework should have a particular feature, you need to decide what abstraction it should use.  This often means deciding how the user should structure their code when they use this feature.

As an example, take the abstraction that Sinatra provides to let the user decide what code should be run for an incoming HTTP request:

```ruby
get "/hello" do
  "hello"
end
```

To decide, Sinatra looks at the HTTP verb (`GET`) and the URL (`/hello`).  These are rich sources of information about what the request is asking for, so they are a good abstraction to use to decide what code should run in response.

Maybe Sinatra could have used another abstraction.  It could have expected HTTP requests to name a function to run (like `sayHello`), and then respond to the request with the value returned by the function.  That would significantly change the way a user uses Sinatra.

## A nice API

This is closely related to a good abstraction.  Sinatra has a very nice syntax for defining routes and their handler functions.  The following would work just as well, but wouldn't be as elegant:

```ruby
hello_action = Proc.new do
  "hello"
end

sinatra.add_route("/hello", hello_action)
```

When you decide on the API for your abstraction and feature, try to make it as terse and readable as you can.

## Resources

- [Writing tests without a testing framework](../pills/writing_tests_without_a_testing_framework.md)
- :pill: [Frontend, single page app](https://github.com/makersacademy/course/blob/master/pills/frontend_single_page_app.md)
- [Constructor and prototype pattern](https://github.com/maryrosecook/constructor-and-prototype-pattern-workshop)
- :pill: [JavaScript module pattern](https://github.com/makersacademy/course/blob/master/pills/javascript_module_pattern.md)
