# The Internet and the WWW

## Three tier web architecture

Today we will be talking about the arrows in this digram. The HTTP request and response.

![Three Tier Web Architecture](https://github.com/makersacademy/course/blob/master/images/3-tier-simple.png?raw=true)

## Map of the Web

![Communities of the Web](http://imgs.xkcd.com/comics/online_communities_2.png)

## The Web

What is the difference between the internet and the web?

| **The Web** |
-----------
| **The Net** |

Both are forms of networks. The internet is a network of servers connected by phone lines. The web is a network of documents linked by hyperlinks.

The web is built on top of the internet.

# Protocols!

Just like software, there are levels of abstraction in hardware too. Beneath the web layer are multiple tiers of networking abstraction.


| Protocol Layer         | Standards                            |
| -----------------------|--------------------------------------|
| *Your code...*         | *...goes here* (HTML, CSS, JS, Ruby) | 
| Application            | HTTP, DNS      |
| Transmission           | TCP, UDP       |
| Internet               | IP (v4, v6)    |
| Link Layer             | Ethernet, WIFI |

## Map of the internet

![Map of the internet](http://www.soundonsight.org/wp-content/uploads/2014/12/map_of_the_internet.jpg)

## A short history of the internet

* 1969 ARPA (Advanced research projects agency) connects 4 universities
* 1972 Email invented
* 1973 TCP/IP invented
* 1976 Queen Elizabeth sends her first email
* 1989 WWW invented by Tim Berners-Lee at CERN
* 1993 Mosaic browser developed

Before then you need to know the address of the FTP site or bulletin board you want to visit! There is no standard for composing documents as a hybrid of text and images.

CERN announce that their browser will be freely available to everyone.

# Protocol: IP (Internet Protocol)

Defines connections between networked hosts. Splits requests and responses into multiple packets (each one like an envelope with a destination on the front). Makes no guarantees that all packets will arrive at their destination.

Used by both TCP and UDP. We won't talk much about UDP but it's the protocol used by Skype and streaming video services where speed is more important that reliability.

# Protocol: TCP (Transmission Control Protocol)

Adds a layer over the top of IP that deals with *transmission control*. If packets get lost in transit, they are re-requested.

## TCP

If you'd like to see all your open TCP connections, type
`lsof -i`
into the terminal

Notice how each connection specifies a `host:port -> host:port` link. The source and the destination both have an IP address and a port.

Special hosts 127.0.0.1, 192.168.0.1

Special ports: 80, 443 (HTTP, HTTPS)
Also 22 - (SSH), 25 - (SMTP)

IP address is like your telephone number on the internet.

# DNS (Domain Name System)

DNS is like directory enquiries for the internet.

It allows us to give servers host names (e.g. google.com rather than 123.324.123.43).

It's an amazing distributed database. Billions of queries and millions of changes daily not surprising it sometimes takes a while for changes to propagate.

If you want to see what IP address a domain name maps to:
`host -t a google.com`

You can also query other types of DNS record, like the addresses of the nameservers themselves:
`host -t ns google.com`

Can mess with your own /etc/hosts file but wouldn't recommend it!

# HTTP

HTTP defines the format for how documents can be served over the internet.

## HTTP Request

What does it look like?

`telnet google.co.uk 80`

Then type `GET / HTTP/1.1` followed by two line returns.

What data is returned?

```text
HTTP/1.1 [status code] [status message]
[Header ...]
[Another Header...]

[Contents]
```

Notice how the contents is text representing HTML.

You can also request content of other types. For example an image:

`telnet google.co.uk 80` then `GET /images/srpr/logo11w.png HTTP/1.1` and two line returns.

# HTTP status codes

Status Codes in a nutshell:

1xx: hold on
2xx: here you go
3xx: go away / somewhere else
4xx: you messed up
5xx: I messed up

HTTP status cats!

https://www.flickr.com/photos/girliemac/sets/72157628409467125 

## Chrome console

You can view what's going on in Chrome by opening up the developer console `CMD-OPT-I`.

![All Requests](https://github.com/makersacademy/course/blob/master/images/console-requests.png?raw=true)

Select the network tab and make a web request in the usual way. You will see all the requests that are made in response.

You can click on a particular repsonse to see more information about it, including the headers, etc.

![Specific request](https://github.com/makersacademy/course/blob/master/images/console-request.png?raw=true)

Requests have headers and a body (which may be blank) in exactly the same way that responses do.

# HTML

You can also select elements in the browser 'right click' (control click) and select 'inspect element'. This allows you to see the parsed HTML response.

![Inspect element](https://github.com/makersacademy/course/blob/master/images/inspect-element.png?raw=true)

HTML is what allows documents displayed in the browser to link to other documents.

# Ruby console

Return a document as a string
```ruby
Net::HTTP.get 'google.com', '/'
```

You can also create a response object that can be queried for the attributes of the response.
```ruby
response = Net::HTTP.get_response 'google.com', '/'
response.code
response.message
response.body
response.each_header { |k, v| puts "#{k}:#{v}" }
```

# What have we discussed

Protocols!

Command-line utilities: `host`, `lsof`, `telnet`

We've looked at TCP, HTTP and a tiny bit of HTML.

# Sinatra

To find out how to create your own web server look at the [Sinatra Pill](https://github.com/makersacademy/course/blob/master/pills/sinatra_1.md)

# Resources

* [A video from a talk on this subject](https://www.youtube.com/watch?v=Q8gE9dwgopE)
* [Another one](https://www.youtube.com/watch?v=Xs9k0sPa27c)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/internet_web.md)
