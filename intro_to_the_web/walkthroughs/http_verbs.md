# Walkthrough - HTTP II: GET / POST Requests

[Back to the Challenge](../http_verbs.md)

In this challenge we introduced the idea that there are different kinds of HTTP requests, namely *GET* and *POST*. Further along you will see that there are 2 further kinds of HTTP requests. By following the challenge steps we hope to understand how the server knows whether an incoming request is *GET* or *POST*.

The first two steps are review of the previous of the previous challenge. Making the http request: `http -v http://getpostworkout.herokuapp.com/`, we should see:

```sh
GET / HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Connection: keep-alive
Host: getpostworkout.herokuapp.com
User-Agent: HTTPie/0.9.2
```

The first line, `GET / HTTP/1.1`, tells us three things: the **method**, `GET`, the **path**, `/`, and the HTTP version, `HTTP/1.1`. Clearly, then, this was a *GET* request. Had we made a request to "getpostworkout.herokuapp.com/whatever", the first line would look slightly different. Try it.

### Making a POST request

Let's try to send some data to the server:

`http -f POST https://getpostworkout.herokuapp.com/ name=Ptolemy`

Visiting the URL in the browser, we can see that making a *POST* request caused a change on the server. The important difference between *GET* and *POST* requests, then, is that the first is typically used by a client to pull down data from a server, while the second is used by a client to submit data to a server. But how did the server know that it was a *POST* request? Let's do the same thing again with "verbose" mode on:

`http -f -v POST https://getpostworkout.herokuapp.com/ name=Ptolemy`

(ignore the lines that start with \*)
```sh
POST / HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Connection: keep-alive
Content-Length: 12
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Host: getpostworkout.herokuapp.com
User-Agent: HTTPie/0.9.2
```
This first section shows the request. It's reasonable to conclude from this that the server knew the method of the request because it was indicated in the first line, `POST / HTTP/1.1`.
```
name=Ptolemy
```
This is the "request body". Here is the data that we submitted. On to the server's response...

```
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 34
Content-Type: text/html;charset=utf-8
Date: Fri, 25 Sep 2015 11:25:40 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2015-04-13)
Via: 1.1 vegur
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block

Your name, Ptolemy has been saved!
```

As you can see, when the server sends back a response to POST request, that response also has content. In this case, a string.

> A note on browsers: while HTTPie is a client that provides a means of making POST requests to a server, browsers by default make GET requests. When you type in the url "https://getpostworkout.herokuapp.com/" and press enter, your browser is making a GET request to the named server. This is important because when building a web application we want to carefully control our data. By ensuring that our server only responds to GET requests with information, and do not create or manipulate any data as a result, we can be confident users casually browsing our site won't accidentally make unintended changes. In short, the distinction between the HTTP methods, or verbs, is relevant to the control of data.

[Forward to the Challenge Map](../README.md)
