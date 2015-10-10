# Sinatra: `POST` and `redirect`

[Back to the Challenge Map](00_challenge_map.md)

Our app now expects users to visit one page - found at the `/cat-form` path - and submit a form which takes them to another - the `/named-cat` path.

If you're particularly pendantic you'll notice that we are not using `POST` in a fully conventional way. When the client submits a `POST` request, it should _modify a resource_. At the moment, we are both modifying a resource and _retrieving information_ in one route:

```ruby
# in app.rb
post '/named-cat' do
  p params
  @name = params[:name] # modify a resource
  erb :index # retrieve information
end
```

So, we are behaving unconventionally. We are also violating the Single Responsibility Principle: our `POST /named-cat` route currently has _two_ responsibilities.

In this challenge, you will refactor your code to implement a `POST`-`redirect` loop. This loop will better follow HTTP conventions.

> During this challenge, you will notice that your form no longer 'works'. Don't worry. We'll address that in the next challenge.

### Learning Objectives covered
- Implement a `POST`-`redirect` loop

### To complete this challenge, you will need to:

- [ ] Add a route that responds to incoming `GET /named-cat` requests
- [ ] Render the view containing your cat picture as the return value to this route
- [ ] Replace the render statement from your `POST /named-cat` route with a `redirect` to the `/named-cat` path.
- [ ] Interact with your application, explaining changes in the server logs to your pair partner.

### Resources


### [Solution](solutions/13_sinatra_post_and_redirect.md)