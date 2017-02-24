#Learning Objectives: Intro to the Web

*Learning Objectives are organised by topic and subtopic. As you go down the bullet-point list below each subtopic header, skills become more advanced/involved.*

[Back to the Challenge Map](README.md)

## The Web

### Servers and Clients
* Define 'server' as 'something that receives requests and issues responses'
* Define 'client' as 'something that issues requests and receives responses'
* Explain how servers and clients interact

### HTTP
* Recall that 'HTTP' means 'HyperText Transfer Protocol'
* Recall that HTTP is the _de facto_ way of getting and sending information across the web
* Remember some common HTTP status codes: 403, 404, 200, 500.

### REST
* Know that 'REST' means 'Representational State Transfer'
* Explain that REST is made up of `POST`, `GET`, `PUT`, and `DELETE` commands
* Explain how HTTP and REST are related

## Web technologies

### Indirect and direct links
* Know that the anchor tag is written as `<a></a>`
* Explain how to use the `href` attribute to set a destination for a hyperlink
* Use the `target` attribute in an anchor tag

### HTML
* Know that 'HTML' means 'HyperText Markup Language'
* Recognise that HTML establishes the **semantic structure** of a web page
* Explain that HTML is made up of structured tags
* Differentiate between self-closing and normal ('block') tags
* Use HTML tags such as `<div>`, `<img />` and `<a>`

### CSS
* Know that 'CSS' means 'Cascading Style Sheets'
* Remember a bunch of often-used CSS properties
* Explain how to use CSS selectors to target specific HTML structures
* Explain how CSS selectors and HTML classes go hand-in-hand
* Diagram the CSS 'box model'
* Use some simple CSS properties to style an HTML webpage

## Web Frameworks

### Web Application Development
* Explain how servers and clients interact
* Explain how templates are filled with application content to render webpages
* Develop a simple web application

### Sinatra
* Know that Sinatra is a Ruby gem to make application code accessible across the web
* Explain how Sinatra's routing and parameters work
* Use Sinatra's template rendering capabilities to create pages for a web application
* Build an application using Sinatra

### Feature/Acceptance testing using Capybara
* Recall that Capybara is a library for testing web interfaces via a 'headless browser'
* Remember what a 'headless browser' is
* Describe links between Capybara and RSpec
* Discuss why Capybara is a useful extension to RSpec's testing abilities

### Parameters
* Know that parameters are are way to query a server for specific information
* Explain how to access parameters from a server environment in Ruby (using Sinatra)
* Construct parameters within a URL, using `?x=y` and `&`
* Build a Sinatra application that uses parameters

### Sessions
* Describe a session as a way to persist information between webpages
* Explain how to set and get the session within a Sinatra application
* Suggest more appropriate methods for long-term storage (i.e. databases)

### Routing
* Diagram the routing layer within a server
* Relate REST principles with Routing principles
* Construct a simple router in a Sinatra application

# SOLID Principles
## O - Open/Closed Principle
* Explain what "an object should be open for extension, but closed for modification" means
* Give reasons why the Open/Closed Principle makes for more easily extensible applications

## I - Interface Segregation Principle
* Define an interface as a way to interact with application objects
* Remember that SOLID code should avoid interfaces requiring objects to be of a specific type
* Link 'duck typing' with Interface Segregation Principle
