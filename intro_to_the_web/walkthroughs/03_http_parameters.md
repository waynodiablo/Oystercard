# Walkthrough - HTTP III: Parameters

[Back to the Challenge](../03_http_parameters.md)

Let's try to dissect the URL, "http://www.example.com/home?name=Bob&age=21"

- "http://www.example.com" The first part specifies the domain name. It indicates which web server to make the request to.
- "/home" This part specifies the path to the resource we want on that server, the home page.
- "?name=Bob&age=21" This part is the query string. Notice the following: 
  - It is separated from the path by a "?"
  - It contains two parameters, "name=Bob" and "age=21".
  - The two parameters are separated by an ampersand ("&").
  - The keys are "name", and "age". They have the values "Bob" and "21" respectively.

I can visit 'http://makersipsum.herokuapp.com/' passing my name as a parameter with the following URL:
- http://makersipsum.herokuapp.com/?name=Ptolemy

This greets me. When I revisit the page, however, without passing a parameter, the greeting disappears. What this tells us is that passing data in this way does not cause changes to persist to the server.

[Forward to the Challenge Map](../00_challenge_map.md)
