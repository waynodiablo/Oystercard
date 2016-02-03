# Sinatra: `POST`ed `params`

[Back to the Challenge Map](00_challenge_map.md)

Our form allows a user to set their cat's name. It will construct a query string and make a request to `/named-cat` with that string appended. Sinatra will parse the query string to a `params` hash and use that to render the view. Sinatra will then respond with the rendered view as an HTML string.

This process forms the basis of almost all web applications. However, it's only half the story. So far you have only been using `GET` requests to interact with the server. There are other kinds of request.

In this challenge, you will hide your request parameters by using a **`POST`** request.

### Challenge Setup

Let's look at an incoming request from our server logs:

![Sample `GET` request](./images/sinatra_get_request.png)

We can identify several parts of the request:

![Annotated `GET` request](./images/sinatra_get_request_annotated.jpg)

- **host**: the server to which the request was sent
- **timestamp**: when the request was received at the server
- **method**: a verb that expresses the intention of the request
- **path**: the location within the server where the request will be handled

> We have omitted some other parts of the request. Can you figure out what they are?

Notice how we described the **method** as a verb that "expresses the intention of the request". So far, you have been using `GET` methods: a verb that is **asking for a server resource**. `POST` methods imply that the request is **asking to modify a server resource**. Since we are setting an `@name` variable on the server with our request, it would seem more appropriate to use a `POST` request instead of a `GET` request.

### Learning Objectives covered
- Use the `POST` request method
- Write a route that handles a `POST` request

### To complete this challenge, you will need to:

- [ ] Write a new `get` route that renders only the cat-naming `form`
- [ ] Add a `method` attribute to your `form` element, with the value `"post"`
- [ ] Change your `/named-cat` route to use `post` instead of `get`
- [ ] Interact with your application
- [ ] Observe the URL query string when you submit the form
- [ ] Observe the printed `params` when you submit the form
- [ ] Explain your observations to your pair partner.

### Resources

- [My First HTML form (MDN)](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/Forms/My_first_HTML_form)
- :pill: [`params`](../pills/params.md)
- [How are parameters sent in an HTTP POST request? (Stack Overflow)](http://stackoverflow.com/questions/14551194/how-are-parameters-sent-in-an-http-post-request)

### [Walkthrough](walkthroughs/14_sinatra_posted_params.md)
