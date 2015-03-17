#jQuery protoype

This is a quick prototype you can use to explore some of the concepts we will be looking at this week.

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
    <base href='../'>
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
        <a href={{http_url}}>{{login}}</a>

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
    }).fail(notFound)
      .always(resetInput);

    function resetInput() {
      $('input.username').val('');
    }

    function notFound() {
      $('.container').prepend("User not found")
    }
  });
});
```

Make sure everything runs as expected.
