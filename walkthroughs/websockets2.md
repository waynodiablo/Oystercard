More WebSockets
=============

* how can we test whether a user can only create a single like?

* let's add a migration

```
bin/rails g migration AddUserIdToLikes user:belongs_to
```

* then migrate

```
bin/rake db:migrate
```

* add a uniqueness constraint

```
validates :user_id, uniqueness: {scope: :post_id}
```

* adjust the controller

```ruby
  def create
    @post = Post.find params[:post_id]

    @post.likes.create!
    WebsocketRails[:likes].trigger 'new', { id: @post.id, new_like_count: @post.likes.count }

    redirect_to '/posts'
  rescue 
    render json: { message: 'Cannot like twice' }
  end
```

* adjust the javascript

```javascript
$(document).ready(function(){
  $('.like-btn').on('click', function(event) {
    event.preventDefault();

    var url = $(this).attr('href')
    $.post(url, function(error) {
      alert(error.message);
    })
  })

  var connection = new WebSocketRails(window.location.host + '/websocket');

  var likesChannel = connection.subscribe('likes');
  likesChannel.bind('new', function(post){
    $('.like-btn[data-post-id=' + post.id + ']').text('❤ ' + post.new_like_count);
  })
})
```

* Might well need to get javascript tests to work:

http://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara
