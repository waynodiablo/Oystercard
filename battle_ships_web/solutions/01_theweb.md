# Solution - The Web: An Introduction

cURL must be the most powerful tool in the UNIX toolbox! Let's use it to make a request to the cURL homepage:
```sh
$ curl http://makersipsum.herokuapp.com/
```

In this example, our command line is the client and "http://makersipsum.herokuapp.com/" is the server. Using cURL, we make a request for information, which the server provides and cURL dumps to the terminal.

The information we get back is in the form of text, marked up with HTML.

> In this example, the command line & cURL act as a client. When we browse the internet, the browser acts as the client. In other situations, web applications can play the role of client to other web "server" applications.
