# Sinatra: Getting Started

[Back to the Challenge Map](README.md)

You should now understand that clients - such as browsers, or command-line tools like _HTTPie_ - can make requests for resources from servers. Those servers will respond with the resource, and some associated metadata. The resource itself is usually contained within the response _body_. The metadata is contained within the response _headers_. All of this communication is done via HTTP.

So far, you have been using a client to request a resource from a server. As web developers, we are more interested in building the servers that can respond to requests with appropriate resources.

We can create and run 'servers' from within our own laptops. There is no practical difference between a server running inside your machine and a server running on a machine the other side of the world: you can interact with a **local** server in the same way you would with a **remote** server.

In this challenge, you will set up a basic **web framework**, Sinatra, that can receive and respond to HTTP requests. You will run Sinatra from within your own computer.

### Learning Objectives covered
- Create a Sinatra application.
- Run the Sinatra app locally.

### Challenge setup

For this challenge you will need a Gemfile listing Sinatra as a dependency.

### To complete this challenge, you will need to:

- [ ] Create a project directory with the `sinatra` gem installed via a Gemfile
- [ ] Create a file for your application, `app.rb`.
- [ ] Require `sinatra` at the top of the file.
- [ ] Run the app from the command line: `ruby app.rb`.
- [ ] Explain to your partner the significance of what you see in the terminal
- [ ] Use a browser to visit your application at `http://localhost:4567`

### Resources

* [Sinatra Main Intro Documentation](http://www.sinatrarb.com/intro.html)
* [Sinatra Up and Running (Book)](http://shop.oreilly.com/product/0636920019664.do)
* [Jump Start Sinatra (Book)](http://www.sitepoint.com/store/jump-start-sinatra/)

### [Walkthrough](walkthroughs/sinatra_getting_started.md)
