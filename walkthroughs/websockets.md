WebSockets Walkthrough
=====================

[Video from June session](https://www.youtube.com/watch?v=BjmapdUUZzw)

The objective is to add some lightweight 'liking' functionality so that users can like individual posts, and also that all browsers pointing at the same page will update the number of likes, so that we avoid having a stale number of likes on a page that has been left open.

Let us consider how we might do this with traditional push based HTTP

Ajax allows us to get data to the client without a page refresh, but still requires a client initiated request

One way to have the client get updated regularly is to do ‘polling’ where the client keeps asking the server for updates, and either the responsiveness is low, e.g. poll every 30 seconds - one can increase the poll frequency, but then that puts a serious load on the server


Solution is websockets which is not HTTP, and it is push based rather than pull based (like HTTP).  It means having a continuously open lightweight connection between server and client that can have information pushed over it.  This allows us to get instantaneous updates on pages from other peoples actions


* So let's start by adding a new feature spec: like_features_spec.rb

```ruby
require 'rails_helper'

describe 'liking posts' do
  before do
    alex = User.create(...)
    alex.posts.create(title: 'cool post', description: 'hello world')
  end
  
  it 'is initially at 0 likes' do
    visit '/posts'
    expect(page).to have_content '♥ 0'
  end
end
```

* check that this fails, and now adjust _post.html.erb

<%= link_to '♥ 0', '#' %> 

* but where do we want this link to point to?

then think about what sort of route we'd like to use for the link

* adjust the routes.rb to have likes nested inside posts

```ruby
Rails.applicatons.routes.draw do
  devise_for :users
  resources :posts do
    resources :likes
  end
 
  resources :tags
end
```

* rather than strictly test driving here, because this is very clearly structured we could go ahead and make a model, where likes belong to posts

```
bin/rails g model Like post:belongs_to
```

* we can run rake routes to check out the new routes - probably don't need the new form for this - so let's make a post request to create a likes, so we can adjust _post.html.erb

```html
<%= link_to '♥ 0', post_likes_path(post), method: :post, class 'btn btn-danger' %> 
```

* we should see a link, and clicking we get an error which is or a controller, so let's write aanother test

```ruby
require 'rails_helper'

describe 'liking posts' do
  before do
    alex = User.create(...)
    alex.posts.create(title: 'cool post', description: 'hello world')
  end
  
  it 'is initially at 0 likes' do
    visit '/posts'
    expect(page).to have_content '♥ 0'
  end

  it 'increments the like count of a post' do
    visit '/posts'
    click_link '♥ 0'
    expect(page).to have_content '♥ 1'
  end
end
```

* create a new controller:

```
bin/rails g controller likes
```

* see error for absence of create action

* add create action 

* adjust method to actually do the creation using the parent child relationship here i.e. @post.likes.create (alternatives include Like.create(post:@post) OR Like.new.post = @post)

```ruby
def create
  @post = Post.find params[:post_id]
  @post.likes.create
  
  redirect_to '/posts'
end
```

* next test failure should be that there is undefined method likes on post

* fix that by adding `has_many :likes` to the Post model

* and now we need to update the view which is hard coded to   0 likes:

```html
<%= link_to "♥ #{post.likes.count}", post_likes_path(post), method: :post %>
```

* tests should pass, and app should work, but note that we get a refresh each time and independent pages in different browsers do not update each other, and this will require websockets and we'll use the websocket rails gem: https://github.com/websocket-rails/websocket-rails - follow the set up there

* now add [websocket-rails](https://github.com/websocket-rails/websocket-rails) gem - following installation guide

* add to Gemfile, bundle, and run the installation generator:

```
rails g websocket_rails:install
```
* note that one of the things this did is that it added `//= require websocket_rails/main` in application.js

* Let's make sure that in application.js that `//= require_tree .` comes last so that our custom javascript is loaded after the gem related javascript

* can skip creating a controller as we already have a likes controller

* but we will need to config.middleware.delete Rack::Lock to environments/development.rb

* we can't use the default webrick server, and need to switch server and let's use thin

* add gem 'thin' to Gemfile and bundle install

* need to adjust capybara as well - add the following to rails_helper

Capybara.server do |app, port|
  require 'rack/handler/thin' 
  Rack::Handler::Thin.run(app, :Port => port)
end

* now we need to stop clicking on the like button leading to a full page refresh

* in likes.js add

```javascript
$(document).ready(function(){
  $('.like-btn').on('click', function(event){
    event.preventDefault();
    //event.stopPropagation();
    var url = $(this).attr('href')
    $.post(url);
  });
});
```
 
* also remove method: :post from the link_to

* this will communicate back to server, and will see changes after a refresh - fine for the moment as we want to broadcast with websockets - we can split websockets into different channels, so websocket events will have a name, and a chanel name
 
* add the following to the likes_controller:

```ruby
def create
  @post = Post.find params[:post_id]
  @post.likes.create

  WebsocketRails[:likes].trigger 'new'
    
  redirect_to '/posts'
end
```

* in our javascript we'll need to establish the websockets connection in order to be able to receive information 

```javascript
  var connection = new WebSocketRails('localhost:3000/websocket');
```

* can see this as a pending websocket request in the network tab on chrome

* and we want to subcribe to the 'likes' channel and bind to listen to 'new' events

```javascript
  var connection = new WebSocketRails('localhost:3000/websocket');
  channel = connection.subscribe('likes');
  channel.bind('new', function(reap){
    console.log('a new like registered');
  })
```

* can see this incoming on both pages in real time

* now let's send our new like count over the socket by adding the following to the likes_controller:

```ruby
def create
  @post = Post.find params[:post_id]
  @post.likes.create

  WebsocketRails[:likes].trigger 'new', { new_like_count : @posts.likes.count}
    
  redirect_to '/posts'
end
```

* now we can update the count  in the console

```javascript
  var connection = new WebSocketRails('localhost:3000/websocket');
  channel = connection.subscribe('likes');
  channel.bind('new', function(post){
    console.log(post.new_like_count);
  })
```

* now we can update the count 

```javascript
  var connection = new WebSocketRails('localhost:3000/websocket');
  channel = connection.subscribe('likes');
  channel.bind('new', function(post){
    $('.like-btn').text('♥ ' + post.new_like_count);
  })
```

* this is good but it updates all our counts

* let's give each post it's own id



```html
<%= link_to '♥ 0', post_likes_path(post), method: :post, class 'btn btn-danger', data: {'post-id': post.id} %> 
```

* and we'll need to send that post id through our likes controller

```ruby
WebsocketRails[:likes].trigger 'new', {id: @post.id, new_like_count: @post.likes.count}
```
* so then we can adjust likes.js to update only the relevant post

```javascript
  var connection = new WebSocketRails('localhost:3000/websocket');
  channel = connection.subscribe('likes');
  channel.bind('new', function(post){
    var postElem = $('.like-btn[data-id=' + post.id + ']');
    postElem.text('♥ ' + post.new_like_count);
  })
```

* we could do this with ajax, but web sockets gives communication from different browsers - will push this to heroku for testing, but there are some simple alternatives, e.g. ngrok.com good for exposing localhost to the internet for testing purposes

```
brew install ngrok
```

```
ngrok 3000 --subdomain wstest
```

* which would allow anyone to go to http://wstest.ngrok.com and update the likes from other pages

* we'll need to adjust the localhost:3000 hard coding using `window.host.url`

* we also need to fix up our tests (fail with mention of event server not set up), which requires adding the following to rails_helper.rb

Capybara.server do |app, port|
  require 'rack/handler/thin' 
  Rack::Handler::Thin.run(app, :Port => port)
end

* and enable js: true for the relevant tests

* to push up to heroku we will need to enable labs on heroku to turn on web sockets `heroku labs:enable websockets`: https://devcenter.heroku.com/articles/websockets

* web sockets is very new, powerful, but not necessarily supported perfectly across all browsers - there are backwards compatibility plugins for older browsers

* can send files and images - also good for games and collaborations like google docs

* need to be careful about security in terms of showing the errors which display our source code - so don't use things like ngrok as a replacement for heroku

* now run tests - will need to set js:true for the web sockets too and set up poltergeist in rails_helper.rb

```ruby
Capybara.javascript_driver = :poltergeist
```

* also need gem 'poltergeist' in Gemfile and bundle install

* may get some errors here due to broken image links, but could just make poltergeist less sensitive
 

* note that one can have more deeply nested routes, e.g.


```ruby
Rails.applicatons.routes.draw do
  devise_for :users
  resources :posts do
    resources :likes
    resources :comments do
      resources :likes
    end
  end
 
  resources :tags
end
``` 














































![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/websockets.md)
