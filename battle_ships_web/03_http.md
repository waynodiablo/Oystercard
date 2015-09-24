# HTTP II: GET / POST Requests

[Back to the Challenge Map](00_challenge_map.md)

So far we've seen that HTTP is used as a means of communicating between clients and servers. We've composed HTTP *requests* that ask a server for information in the form of a web page. In the language of HTTP, this kind of request is typically done as a **GET** request: a request that "gets" information. There are, however, other kinds of requests we can make, such as **POST**.

In this challenge you will learn the different use-cases for two kinds of HTTP request, GET and POST.

### Learning Objectives covered
- Understand from a request's headers whether it is a GET or POST request.
- Understand that a POST request creates data.
- Understand the different use-cases for GET and POST requests.

### To complete this challenge, you will need to:

- [ ] Use cURL's "-v" flag and make a request to 'http://getpostworkout.herokuapp.com/'.
- [ ] Study the request headers. Decide with your pair whether it was a GET or a POST request.
- [ ] Use cURL and send your name as data to 'http://getpostworkout.herokuapp.com/': `curl --data "name=YourNameHere" https://getpostworkout.herokuapp.com/`
- [ ] Visit 'http://getpostworkout.herokuapp.com/'. Explain to your partner what has happened to the data that you sent.
- [ ] Make the same request again, this time with the `-v` flag.
- [ ] Explain to your partner what was different about the request headers compared to the first step.

### Resources

- [cURL: How can I see request headers?](http://stackoverflow.com/questions/866946/how-can-i-see-the-request-headers-made-by-curl-when-sending-a-request-to-the-ser)
- [cURL: How can I see response headers?](http://stackoverflow.com/questions/10060098/getting-only-response-header-from-http-post-using-curl)

### [Solution](solutions/3.md)
