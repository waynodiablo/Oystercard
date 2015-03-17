# jQuery protoype

This is a quick and simple prototype you can use to explore some of the concepts we will be looking at this week.

Set up a new folder and create the following structure:

```
├── gitprofile.html
└── js
    ├── gitprofile.js
```

Add the following to `gitprofile.html`:

```html
<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset="utf-8">
  </head>

  <body>
    <form class="gitprofile">
      <input class="username" placeholder="Enter GitHub username">
      <button type="submit">Load</button>
    </form>

    <main class="container">
    </main>

    <template>
      <article class="profile">
        <section class="pic">
        <img src={{avatar_url}}>
        </section>

        <section class="stats">
        <a href={{html_url}}>{{login}}</a>

        Repos: {{public_repos}}
        Followers: {{followers}}

        </section>
      </article>
    </template>
  </main>

  <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
  <script src="js/gitprofile.js"></script>

  </body>
</html>
```

And the following to `gitprofile.js`:

```javascript
$(document).ready(function() {

  $('.gitprofile').on('submit', function(e) {

    e.preventDefault();

    var url = 'https://api.github.com/users/' + $('input.username').val();

    var template = $('template').html();

    var info = $.get(url, function(info) {
      $('.container').prepend(Mustache.render(template, info));
    }).fail(function() {
      $('.container').prepend("User not found")
    }).always(function() {
      $('input.username').val('');
      });
  });
});
```

Make sure everything runs as expected.

##Discuss with your pair (and your byte)

* Make sure you undertand what each and every line of code is doing.
* Have a look at the `info` that is coming back from the `$.get` request. What information does this contain?
* Do you understand why we have to pass `info` into `function(info) { .... }`? What construct in Ruby does this resemble?
* Try using `cURL` to obtain the same data in the command line.
* What is a Mustache?
* What is a template?
* How does the template interact with the data that we receive from the API call?
* What is the point of the `.fail` and `.always` methods? What happens if you take them away?
* Could we refactor the functions passed to `fail` and `always` into separate, more clearly named functions?
* How could we test this?
* The external libraries used here are being loaded over a CDN. What is a CDN?
* Can you adapt this to another API? What would you have to change to make it work?
* How could we have the search results return automatically as you type into the search box?
* How would you test this? Would you implement this in a different way?

## Most importantly
* Feel free to poke, prod, tear apart, and rebuild this little example as much as you want.
* This may feel deceptively simple, but it actually contains a lot of the key concepts you will be looking at in the front-end this week.
