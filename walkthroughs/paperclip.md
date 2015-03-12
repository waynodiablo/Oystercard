Paperclip
=====

Paperclip is a gem that makes it easy to do image upload with rails activerecord models

* in 'spec/features/posts_feature_spec.rb' --> in `describe 'creating posts' do it 'adds the post to the homepage' do` add 

```ruby
attach_file 'Picture', Rails.root.join('spec/images/old-man1.jpg')
```

* and associated expectation after posting

```ruby
expect(page).to have_css 'img.uploaded-pic'
```

* check that it fails

* add ```gem 'paperclip', github: 'thoughtbot/paperclip'``` to gem file (because gem is broken, see https://github.com/thoughtbot/paperclip/issues/1495 )

* need to follow [paperclip instructions](https://github.com/thoughtbot/paperclip), i.e. `brew install imagemagick`

* might also need `brew link --overwrite imagemagick` if fails to link (try `brew link imagemagick` first)

* now we need to add some lines in model 'app/models/post.rb'

```ruby
has_attached_file :picture
validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\z/
```

* next generate some migrations

```
bin/rails g paperclip post picture
bin/rake db:migrate
```

* note we are not storing file in the database - instead store a reference to the image on the file system, or in a 3rd party hosting service

* update post form 'app/views/posts/new.html.erb'

```
<%= f.label :picture %>
<%= f.file_field :picture %>
```

* adjust controller code 'app/controller/posts_controller.rb'

`permit(:title, :description, :picture)`

* add to view 'app/views/posts/index.html.erb'

`<%= image_tag post.picture.url, class: 'uploaded-pic' %>`

* need form_for adjustment to support file sizes about 4MB in 'app/views/posts/new.html.erb':

`<%= form_for @post, html: {multipart: true} do |f| %>`



* potentially file is very large so can adjust that in css although file will still be big

```
.uploaded-pic {
  max-width: 20px;
}
```

* do on server side - first in 'app/models/post.rb' adjust to 

```ruby
has_attached_file :picture, styles: { medium: '20x20'}
```
* then delete existing post by running bin/rails c from the command line and executing

```
Post.delete_all
```

* re-post and we see that image is actually small and can delete css resizing, and only reference stored in db
