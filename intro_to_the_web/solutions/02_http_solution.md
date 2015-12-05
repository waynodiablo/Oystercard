# Solution - The Hypertext Transfer Protocol

[Back to the Challenge](../02_http.md)

The following command makes a request to 'http://makersipsum.herokuapp.com/' with "verbose" mode enabled:

```sh
http -v http://makersipsum.herokuapp.com/
```

Let's divide the response into three sections:
```
GET / HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Connection: keep-alive
Host: makersipsum.herokuapp.com
User-Agent: HTTPie/0.9.2
```
Above is the *request*. It contains request headers and other information. This originates from the *client*, "HTTPie/0.9.2", we sent it!

```
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 681
Content-Type: text/html;charset=utf-8
Date: Fri, 25 Sep 2015 11:21:44 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2015-04-13)
Via: 1.1 vegur
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
```
Above are the *response* headers. They originate from the server. We can see *metadata* such as what language the server is running on.

```
<h1>This is the beginning of the response body</h1>
  <p>Bacon ipsum dolor amet tenderloin turkey picanha drumstick pancetta. Shoulder frankfurter prosciutto chuck chicken, meatloaf strip steak tenderloin fatback drumstick brisket sirloin doner pastrami. Fatback meatloaf leberkas filet mignon, drumstick pig ribeye beef pastrami prosciutto kielbasa frankfurter. Cow landjaeger sausage, short ribs shoulder pig pancetta pastrami ball tip salami tongue. Pork loin andouille pastrami tongue. Drumstick pork filet mignon, ham tail meatball bresaola flank jerky leberkas sirloin spare ribs. Alcatra pig pork chop, ham picanha andouille rump ground round.</p>
<h2>This is the end </h2>
* Connection #0 to host makersipsum.herokuapp.com left intact
```
Lastly, the *body* of the response. This is the information that motivated our request in the first place. It originated from the server.

[Forward to the Challenge Map](../00_challenge_map.md)
