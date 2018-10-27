Content Delivery Network
=======================

:construction: UNDER CONSTRUCTION :construction:

In web development a content delivery network ([CDN](https://en.wikipedia.org/wiki/Content_delivery_network)) is an server that is designed specifically for quickly serving static assets such as javascript libraries and CSS files.  For example:

* https://code.jquery.com/
* https://www.cloudflare.com/
* http://www.bootstrapcdn.com/

The idea is to improve your website's loading times by having static assets load quickly off super-fast servers, and have your own server focus on the dynamic application code.  Also if you are using a popular CDN then the chances are that your users' browsers will have already locally cached those files loading them for other sites, further speeding up the load time of your website.

It's all win-win unless you want to develop offline, e.g. on a commute on an underground train, in which case you'll want to ensure you also have copies of the assets stored locally.  

Using CDNs does also introduce a dependency so that if a CDN goes down, so does your site, but the CDNs work hard to have good uptimes, so it's usually a reasonable risk.

## Loading an asset from your local server

```html
<html>
  <head>
    <script type="text/javascript" src="lib/jquery-1.8.3.min.js"></script>
  <head>
...

```

## Loading an asset from a CDN


```html
<html>
  <head>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.8.3.min.js"></script>
  <head>
...

```

Note the 'min' in the jquery examples above.  This refers to minified javascript (or other asset, e.g. CSS), which is the same javascript, but with all the spaces taken out, and possibly all the variable names reduced to the minimum possible.  The idea is to simply shrink the file size to reduce the time it takes to load.  It also has the effect of making the file almost unreadable to humans.  If you are in development mode and may need to debug through the file prefer the non-minified versions of assets.  Prefer minified versions when going into production.


![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/content_delivery_network.md)
