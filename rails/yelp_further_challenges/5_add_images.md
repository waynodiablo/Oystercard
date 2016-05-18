#### Adding images to restaurants

It's all looking a bit plain-text at the moment. Why can't we add an image to our restaurants?

This actually requires quite a lot of magic to happen – user uploads, resizing and compression of images on the server side, storing the images somewhere – so we'll do this in steps.

We're going to 'spike' that part of the walkthrough – that is, do it in one big go without testing – but you'll be expected to write tests for it afterwards (it requires a bit of research to get your testing suite to be able to upload images to the site).

##### Install ImageMagick

ImageMagick is a code library that deals with image compression. Install it using Homebrew:

```shell
$ brew install imagemagick
```

This might take a little while.

##### Getting started with Paperclip

Paperclip is a gem that makes file uploads to Ruby apps a bit simpler.

Add the Paperclip gem to your Gemfile—

`gem 'paperclip'`

—and run `bundle install`.

Have a look at the boilerplate text from the [Paperclip repo](https://github.com/thoughtbot/paperclip) below:

```ruby
class User < ActiveRecord::Base
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
```

This looks pretty good. Add this into your Restaurant model, but change `:avatar` to `:image` so you get something like this:

```ruby
...
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
...
```

Now, we need a migration to add this image to our restaurant model – each restaurant item in the database needs to know what image is associated with it, so we need an image column. Generate it using

```shell
$ rails generate paperclip restaurant image
```

and then run `rake db:migrate` to add the new column to your database.

##### Adding file uploads

Have a look at `app/views/restaurant/_form.html.(erb/haml)`. Change the form tag to the following – this lets you send files to the server using your HTML form:

```erb
<%= form_for @restaurant, html: {multipart: true} do |f| %>
```

```haml
= form_for @restaurant, html: {multipart: true} do |f|
```
and then add

```erb
<%= f.file_field :image %>
```

```haml
= f.file_field :image
```
to your form, which will add a file picker for users to select an image from their local machine and upload it.

Go to your restaurants controller and add `:image` to your `permit` statement, to tell Rails that it's okay that users are submitting forms with images.

Now, when a user creates a restaurant and includes an image, it gets saved to the `/public` directory.

In `views/restaurants/index.html.(erb/haml)`, you now want to include a photo.

```erb
<%= image_tag restaurant.image.url(:thumb) %>
```

```haml
= image_tag restaurant.image.url(:thumb)
```
**Exercise – work out how to test this with Capybara!** Then commit and :twisted_rightwards_arrows:.
