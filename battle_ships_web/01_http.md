# HTTP: An Introduction

[Back to the Challenge Map](00_challenge_map.md)

A **web framework** is a program that sends and receives messages online over the **Hyper Text Transfer Protocol**. As the morse-code "protocol" can be used to transmit a message from a ship to a submarine, HTTP is an efficient means of communication between very different technologies.

This challenge will introduce you to the structure of the HTTP request and response and the request/response cycle.

### Learning Objectives covered
- Use CURL to make an HTTP request.
- Understand the important elements of an HTTP request.
- Understand the important elements of an HTTP response.

### Challenge setup

This challenge uses [cURL](http://curl.haxx.se/), a command line tool useful for making HTTP requests. It comes with the operating system.

### To complete this challenge, you will need to:

- [ ] From the command line, Use cURL to make a request to 'http://curl.haxx.se/'.
- [ ] Explain to your partner what you see.
- [ ] Make the same request but using the `--verbose` flag. Find the lines that describe the request (they start with ">").
- [ ] Describe to your partner what "GET / HTTP/1.1" means.
- [ ] Make the same request but using the `--head` flag to only display the **headers**.
- [ ] Describe to your partner what "HTTP/1.1 200 OK" means.
- [ ] Using the `--head` flag, make a request to "http://www.makersacademy.com/nikeshscastle". What's different about the **headers**?

### Resources

- [cURL: GET](http://curl.haxx.se/docs/httpscripting.html#GET)
- cURL manual: type `man curl` from the command line

### [Solution](solutions/3.md)
