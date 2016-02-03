# Sinatra: Introducing `params`

[Back to the Challenge Map](00_challenge_map.md)

Now we have an application that serves dynamic pages with random cat names. However, truly dynamic web applications must do more than translate paths to routes, and spit out pages depending on route. 

Much of the time, clients need only communicate a path to a server. For more complex interactions, they might need to communicate more information. For example, submitting an insurance form involves a client sending hundreds of pieces of information to a server.

In this challenge, you will use `params` to extract extra information from a client request.

### Learning Objectives covered
- Use `params` to extract information from a request
- Send `params` from a client in a query string

### To complete this challenge, you will need to:

- [ ] Rename your `/cat` route to `/random-cat`.
- [ ] Build a new route, `/named-cat`, that does the same as `/random-cat`.
- [ ] Instead of setting the `@name` instance variable equal to a sampled array, set it equal to `params[:name]`
- [ ] Visit your route from a browser
- [ ] Explain to your pair partner what you see
- [ ] In the browser URL, add the following **query string** after the `/named-cat` path: `?name=James`, and visit that page
- [ ] Explain to your pair partner what you see
- [ ] In the line before you assign your `@name` variable, print (`p`) the `params` of the request
- [ ] Restart your server and refresh the page. Check the terminal (**server logs**) and explain to your pair partner what you see
- [ ] Change parts of the **query string** within the URL bar of your browser until you can fully explain how it works to your pair partner.

### Resources

- :pill: [`params`](../pills/params.md)
- [Query String (Wikipedia)](https://en.wikipedia.org/wiki/Query_string)


### [Walkthrough](solutions/12_sinatra_introducing_params_solution.md)
