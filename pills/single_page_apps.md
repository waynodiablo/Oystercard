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
    <a href="" id="tiger-link">Tiger</a>
    <div id="animal"></div>

    <script>
      makeTigerLinkClickSayTiger();

      function makeTigerLinkClickSayTiger() {
        document
          .getElementById("tiger-link")
          .addEventListener("click", function(clickEvent) {
            clickEvent.preventDefault();
            sayTiger();
          });
      };

      function sayTiger() {
        document
          .getElementById("animal")
          .innerHTML = "tiger";
      };
    </script>
  </body>
</html>
```

When the user clicks the `Tiger` link, the text `tiger` is displayed.  This text is inserted into the page dynamically, not sent from a server after a request/response cycle and a page refresh.

### Prevent default

What's up with that line that says `clickEvent.preventDefault()`?

Create an `index.html` page and paste in the code above.  Open the page in a web browser.  Click the link. Now remove the `clickEvent.preventDefault()` line and click the link.  What happens.  Research [why](https://developer.mozilla.org/en/docs/Web/API/Event/preventDefault).

## Navigation

How can a single page app have a navigation architecture (a web of different pages)?

### URLs with hashes

What about if we think of the `tiger` as content that belongs on its own "page" at its own URL?

Let's update our code to redirect the user to a new "page" when they click the `Tiger` link.  This subsequent page will show the `tiger`.

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Single page app</title>
  </head>

  <body>
    <a href="#tiger">Tiger</a>
    <div id="animal"></div>

    <script>
      makeUrlChangeShowAnimalForCurrentPage();

      function makeUrlChangeShowAnimalForCurrentPage() {
        window.addEventListener("hashchange", showAnimalForCurrentPage);
      };

      function showAnimalForCurrentPage() {
        showAnimal(getAnimalFromUrl(window.location));
      };

      function getAnimalFromUrl(location) {
        return location.hash.split("#")[1];
      };

      function showAnimal(animal) {
        document
          .getElementById("animal")
          .innerHTML = animal;
      };
    </script>
  </body>
</html>
```

Notice how the link sends the user to a new URL that includes a hash (`#`).  Navigatating to the current URL with a different hash doesn't refresh the page.  For example, if the user loads `http://localhost:4000`, then clicks a link to `http://localhost:4000#tiger`, then clicks a link to `http://localhost:4000#lion`, no page refreshes will occur.  This is the crux of how a single page app can retain data and have a site architecture.  Each hash maps to a different part of the app.  Each time the user moves to a new part of the app, the JavaScript execution context (all the variables and their data) are retained.

Notice how we don't need `event.preventDefault()` anymore.  There's no page refresh to prevent.

Notice how we don't need to bind an event handler to the `Tiger` link.  Instead, the `makeUrlChangeShowAnimalForCurrentPage()` function listens for `hashchange` events.  When one is fired, it takes the animal from the hash part of the URL and displays that animal.

### Many pages

What about if we have a list of animals that we want to show on separate "pages" of our single page app? This is super easy! We just add links for each animal page that we want.

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Single page app</title>
  </head>

  <body>
    <a href="#tiger">Tiger</a> |
    <a href="#lion">Lion</a> |
    <a href="#cheetah">Cheetah</a> |
    <a href="#leopard">Leopard</a>

    <div id="animal"></div>

    <script>
      makeUrlChangeShowAnimalForCurrentPage();

      function makeUrlChangeShowAnimalForCurrentPage() {
        window.addEventListener("hashchange", showAnimalForCurrentPage);
      };

      function showAnimalForCurrentPage() {
        showAnimal(getAnimalFromUrl(window.location));
      };

      function getAnimalFromUrl(location) {
        return location.hash.split("#")[1];
      };

      function showAnimal(animal) {
        document
          .getElementById("animal")
          .innerHTML = animal;
      };
    </script>
  </body>
</html>
```

## Resources

* [Single page web app on Wikipedia](https://en.wikipedia.org/wiki/Single-page_application)
* [`preventDefault()` on MDN](https://developer.mozilla.org/en/docs/Web/API/Event/preventDefault)
