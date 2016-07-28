# Single page apps

## What is a single page app?

The essence of a single page app is that the browser never refreshes the page.  This means that, once the page loads, all changes happen by inserting HTML into the existing page.  Here is the a very hiny single page app.  (This code should be abstracted into separate files.  It's been put in one file for clarity.)

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Single page app</title>
  </head>

  <body>
    <a href="" id="hello-link">Say hello</a>
    <div id="greeting"></div>

    <script>
      makeSayHelloLinkClickSayHello();

      function makeSayHelloLinkClickSayHello() {
        document
          .getElementById("hello-link")
          .addEventListener("click", function(clickEvent) {
            clickEvent.preventDefault();
            sayHello();
          });
      };

      function sayHello() {
        document
          .getElementById("greeting")
          .innerHTML = "hello";
      };
    </script>
  </body>
</html>
```

When the user clicks the `Say hello` link, the text `hello` is displayed.  This text is inserted into the page dynamically, not sent from a server after a request/response cycle and a page refresh.

### Prevent default

What's up with that line that says `clickEvent.preventDefault()`?

Create an `index.html` page and paste in the code above.  Open the page in a web browser.  Click the link. Now remove the `clickEvent.preventDefault()` line and click the link.  What happens.  Research [why](https://developer.mozilla.org/en/docs/Web/API/Event/preventDefault).

## Navigation

How can a single page app have a navigation architecture (a web of different pages)?

### URLs with hashes

What about if we think of the `hello` greeting as content that belongs on its own "page" at its own URL?

Let's update our code to redirect the user to a new page when they click the `Say hello` link.  This subsequent page will show the `hello`.

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Single page app</title>
  </head>

  <body>
    <a href="/#/hello">Say hello</a>
    <div id="greeting"></div>

    <script>
      makeUrlChangeShowGreetingForCurrentPage();

      function makeUrlChangeShowGreetingForCurrentPage() {
        window.addEventListener("hashchange", showGreetingForCurrentPage);
      };

      function showGreetingForCurrentPage() {
        showGreeting(getGreetingFromUrl(window.location));
      };

      function getGreetingFromUrl(location) {
        return location.hash.split("/")[1];
      };

      function showGreeting(greeting) {
        document
          .getElementById("greeting")
          .innerHTML = greeting;
      };
    </script>
  </body>
</html>
```

Notice how the link sends the user to a new URL that includes a hash (`#`).  Navigatating to the current URL with a different hash doesn't refresh the page.  For example, if the user loads `http://localhost:4000`, then clicks a link to `http://localhost:4000#hello`, then clicks a link to `http://localhost:4000#howdy`, no page refreshes will occur.  This is the crux of how a single page app can retain data and have a site architecture.  Each hash maps to a different part of the app.  Each time the user moves to a new part of the app, the JavaScript execution context (all the variables and their data) are retained.

Notice how we don't need `event.preventDefault()` anymore.  There's no page refresh to prevent.

Notice how we don't need to bind an event handler to the `Say hello` link.  Instead, the `makeUrlChangeShowGreetingForCurrentPage()` function listens for `hashchange` events.  When one is fired, it takes the greeting from the hash part of the URL and displays that greeting.

### Many pages

What about if we have a list of greetings that we want to show on separate "pages" of our single page app? This is super easy! We just add links for each greeting page that we want.

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Single page app</title>
  </head>

  <body>
    <a href="#hello">Say hello</a> |
    <a href="#howdy">Say howdy</a> |
    <a href="#yo">Say yo</a> |
    <a href="#hey">Say hey</a> |
    <a href="#wotcha">Say wotcha</a>

    <div id="greeting"></div>

    <script>
      makeUrlChangeShowGreetingForCurrentPage();

      function makeUrlChangeShowGreetingForCurrentPage() {
        window.addEventListener("hashchange", showGreetingForCurrentPage);
      };

      function showGreetingForCurrentPage() {
        showGreeting(getGreetingFromUrl(window.location));
      };

      function getGreetingFromUrl(location) {
        return location.hash.split("#")[1];
      };

      function showGreeting(greeting) {
        document
          .getElementById("greeting")
          .innerHTML = greeting;
      };
    </script>
  </body>
</html>
```

## Resources

* [Single page web app on Wikipedia](https://en.wikipedia.org/wiki/Single-page_application)
* [`preventDefault()` on MDN](https://developer.mozilla.org/en/docs/Web/API/Event/preventDefault)
