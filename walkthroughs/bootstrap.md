Bootstrap
=========

Providing some basic CSS styles for common website components, e.g. tab navigation or pagination: http://getbootstrap.com/

* Need https://github.com/twbs/bootstrap-sass to use bootstrap with rails

* Following the instructions in the github README add following to Gemfile:

```
gem 'bootstrap-sass'
```

* run `bundle`

* add the following to application.css (and rename to application.css.scss)

```
@import "bootstrap-sprockets";
@import "bootstrap";
```

* add this to application.js

```
//= require jquery
//= require bootstrap-sprockets
```

* use jumbotron template from http://getbootstrap.com/examples/jumbotron/ - grab source of that: 'View' menu in Chrome then 'Developer-> View Source' - copy all and paste into application.html.erb

* adjust title and remove reference to favicon, author and description from meta tags

* remove all css and js references from under title and replace with rails tags to ensure the asset pipeline can serve separate or joined files as appropriate:

```
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
    <%= csrf_meta_tags %>
```

* change project name 

* remove the bootstrap core JS from the end, since rails will load that for us (?)

* add yield above footer - removing jumbotron component:
 

```html 
      <p class="notice"><%= notice %></p>
      <p class="alert"><%= alert %></p>
      <%= yield %>
      <div class="container">

      <hr>

      <footer>
        <p>&copy; Company 2014</p>
      </footer>
    </div> <!-- /container -->
```
* problem is now that navbar is fixed and obscures some content - fix that with addition to application.css.scss

```css
body {
  padding-top: 60px;
}
```

* now let's add the jumbotron to index.html.erb


```html
<% unless user_signed_in? %>
    <div class="jumbotron">
      <div class="container">
        <h1>Welcome to Instagram May</h1>
        <p>This is a template for a simple marketing or informational website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
        <p><a class="btn btn-primary btn-lg" role="button">Learn more &raquo;</a></p>
      </div>
    </div>
<% end %>
```

* now let's change the background

```css
.jumbotron {
  background: image-url('photo-collage.jpg');
}
```

* let's change so we can see the text more easily

```css
.jumbotron {
  background: image-url('photo-collage.jpg');

  .container {
    background: rgba(255,255,255,0.85);
    padding: 20px;
  }
}
```

* grid system is good for responsiveness - let's see that by editing the posts index.html.erb file to include a div class row

```html
<div class='container'>
    <% if @posts.none? %>
      No posts yet
    <% else %>
      <div class='row'>
      <% @posts.each do |post| %>
        <div class='col-md-4'>
        ...
        
        ...
        </div>
      <% end %>
      </div>
    <% end %>
  <%= link_to 'New post', new_post_path %>
</div>
```

* can experiment with alternate col styles, e.g. col-sm-4, or col-xs-4 to adjust when a smaller width browser will cause items to stack

* let's now add a panel component, grabbing example from: http://getbootstrap.com/components/#panels

```html
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">Panel title</h3>
  </div>
  <div class="panel-body">
    Panel content
  </div>
</div>
````

* add that into posts index.html.erb

```html
<div class='col-md-4'>
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title"><%= post.title %></h3>
  </div>
  <div class="panel-body">
    <% if post.image.present? %>
      <%= image_tag post.image.url(:thumb), class: 'uploaded-pic' %>
    <% end %>
    
    <p><%= post.description %></p>
    <p>Posted by: <%= post.user.email %></p>
  </div>
</div>
</div>
```

* looks good but now we have problem that images are overflowing.  Fix that with the following on application.css.scss

```css
.panel-body img {
  max-width: 100%;
}
```

* looking good, but let's move some things into a footer - and let's use scss nesting, e.g. 

```css
.panel-body {
  img {
    max-width: 100%;
  }

  p {
    margin-top: 20px;
  }
}
```

* and then let's move the post author into a footer

```html
            <p><%= post.description %></p>
          </div>
          <div class="panel-footer">Posted by: <%= post.user.email %>
          </div>
        </div>
```

* let's also adjust the new post link to make it more obvious: http://getbootstrap.com/css/#buttons

```html
  <%= link_to 'New post', new_post_path, class: 'btn btn-warning btn-lg' %>
```

* let's also fix up the sign up button works

```html
   <%= link_to 'Sign Up >>', new_user_registration_path, class:"btn btn-primary btn-lg" %>
```

* now let's get the form working - copy views/devise/sessions/new.html.erb into application.html.erb but replace 'resource' with User.new and 'resource_name' with :user (might have multiple types of user) and remove labels and use placeholder instead

```html
<%= form_for(User.new, as: :user, url: session_path(:user), html: {class: "navbar-form navbar-right"}) do |f| %>
<div class="form-group"><%= f.email_field :email, placeholder: 'Email', class: 'form-control', autofocus: true %></div>

<div class="form-group">
  <%= f.password_field :password, placeholder: 'Password', class: 'form-control', autocomplete: "off" %></div>

<%= f.button "Sign in", class: "btn btn-success"%>
<% end %>
```

* Now the sign in form should work as expected

* note that tests now fail due to confusion over sign in fields - can make more specific using within

Alternatives to Bootstrap include http://foundation.zurb.com


Challenges
-----

* add ability for users to like photos








![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/bootstrap.md)
