# Solution - The Hypertext Transfer Protocol

The following command makes a request to 'http://curl.haxx.se/' with "verbose" mode enabled:

```sh
curl -v http://curl.haxx.se/
```

Let's divide the response into three sections:
```
> GET / HTTP/1.1
> Host: makersipsum.herokuapp.com
> User-Agent: curl/7.43.0
> Accept: */*
>
```
Above is the *request*. It contains request headers and other information. This originates from the *client*: we sent it!

```
< HTTP/1.1 200 OK
< Connection: keep-alive
< Content-Type: text/html;charset=utf-8
< Content-Length: 681
< X-Xss-Protection: 1; mode=block
< X-Content-Type-Options: nosniff
< X-Frame-Options: SAMEORIGIN
< Server: WEBrick/1.3.1 (Ruby/2.0.0/2015-04-13)
< Date: Thu, 24 Sep 2015 16:56:51 GMT
< Via: 1.1 vegur
<
```
Above are the *response* headers. They originate from the server.

```
<h1>This is the beginning of the response body</h1>
  <p>Bacon ipsum dolor amet tenderloin turkey picanha drumstick pancetta. Shoulder frankfurter prosciutto chuck chicken, meatloaf strip steak tenderloin fatback drumstick brisket sirloin doner pastrami. Fatback meatloaf leberkas filet mignon, drumstick pig ribeye beef pastrami prosciutto kielbasa frankfurter. Cow landjaeger sausage, short ribs shoulder pig pancetta pastrami ball tip salami tongue. Pork loin andouille pastrami tongue. Drumstick pork filet mignon, ham tail meatball bresaola flank jerky leberkas sirloin spare ribs. Alcatra pig pork chop, ham picanha andouille rump ground round.</p>
<h2>This is the end </h2>
* Connection #0 to host makersipsum.herokuapp.com left intact
```
Lastly, the *body* of the response. This is the information that motivated our request in the first place. It originated from the server.
