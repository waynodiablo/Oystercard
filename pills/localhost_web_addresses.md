### What does `localhost:4567` mean?

`localhost:4567` is in fact an address in two parts:

- `localhost`: you computer's _hostname_ for itself. On my machine, `localhost` means _my_ machine, and on your machine, `localhost` means _your_ machine. `localhost` is usually the same as the IP address **127.0.0.1**, or **0.0.0.0** (but you can configure this: maybe find out where?)
- `4567`: the _port_ used to connect to `localhost`.

Every internet connection requires at least two parameters: the _hostname_ (such as `localhost`, 'google.com', or '192.168.1.1'), and a port (80, 3000, 4567 or some other). In this case, Sinatra is 'listening for connections' on `localhost` and port `4567`.

Why don't you normally specify a port when connecting to a web server? Why can you type 'google.com' in the address bar and it will work without the port? The reason is that by convention, web servers usually run on port 80, so your browser assumes you want to use port 80 if you don't specify any. So, when you type this in the address bar

`www.google.com`

your browser actually opens the connection to

`www.google.com:80`

Try specifying the port in the browser bar now: it works just fine. But, try a port number that Google doesn't expect and you won't get a response. For example, you'll get an error if you do this

`www.google.com:22`

As we mentioned, the port 80 is reserved for web (HTTP) connections but there are many more. For example, ssh (secure shell connection) uses port 22 and https (encrypted HTTP connection) usually run on port 443. However, all of those are just conventions. Nothing prevents you from running an ssh server on port 80, if you insist on it.

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/localhost_web_addresses.md)
