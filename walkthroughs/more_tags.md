More Tags (Filtering)
=========

Giving a many to many relationship, how can we filter what we see based on tags?

* let's say we want to handle the situation where tags are entered without spaces:

```ruby
describe 'multiple comma-separated tags' do
  context 'without spaces' do
    it 'adds each tag to the post' do 
      post.tag_names = 'yolo,swag'
      expect(post.tags.count).to eq 2
    end
  end
end
```

* check that this fails - treated as single tag

* fix with regex

```ruby
def tag_names=(tag_names)
  return nil if tag_names == ''
  tag_names.split(/,\s?/).uniq.each do |tag_name|
    formatted_name = '#'+tag_name.delete('#')

    tag = Tag.find_or_create_by(name: formatted_name)
    tags << tag
  end
end

```

* let's add [bootstrap tag styling](http://timschlechter.github.io/bootstrap-tagsinput/examples/), or [inputosaurus](http://sproutsocial.github.io/inputosaurus-text/) - need to download bootstrap-tagsinput.js and put that in vendor/assets/javascript and bootstrap-tagsinput.css and put that in vendor/assets/stylesheets

* then in application.js add //= require bootstrap-tagsinput
* and in application.css add @import "bootstrap-tagsinput";

* then update form in new.html.erb

```
<%= f.label :tag_names, 'Tags' %>
<%= f.text_field :tag_names, data: {role: 'tagsinput'} %>
```

* add minimum width to text field in posts.css.scss

```
.bootstrap-tagsinput {
  min-width: 300px;
}
```

* let's have click through on the tags to see all posts filtered by tag

```ruby
it 'can filter posts by tag' do
  Post.create title: 'Pic1', tag_names: 'yolo'
  Post.create title: 'Pic2', tag_names: 'swag'

  visit '/posts' 
  click_link '#yolo'
  expect(page).to have_css 'h1', text: 'Posts tagged with #yolo'
  expect(page).to have_content 'Pic1'
  expect(page).not_to have_content 'Pic2'
end
```

* check that fails

* how do we update index.html.erb ?

`<%= link_to tag.name, '#'%>`

* first we need to update routes.rb

`resources :tags`

* update index.html.erb 

`<%= link_to tag.name, tag_path(tag) %>`

* check fails on controller

* create tags controller

`bin/rails g controller Tags`

* check fails on lack of show method

* add show to tags controller

```
def show
  raise 'hello'
end
```

* see the id in the exception

* so update to find tag in show action

```
def show
  @tag = Tag.find params[:id]
end
```

* check for view error

* create show.html.erb

```
<h1>Posts tagged with <%= @tag.name %></h1>

<% @tag.posts.each do |post| %>
  <%= post.title %>
<% end %>
```

* check that this works and that all tests pass

* can copy and paste from index page, but that's bad because not DRY ..

* create a partial called _post.html.erb on index can have <%= render @posts %> and update posts show.html.erb

```
<div class='container'>
  <h1>Posts tagged with <%= @tag.name %></h1>
  <%= render @tag.posts %>
</div>
```

* check working as expected

* let's fix the url so that we have the name of the tag rather than the id of the tag

* let's write a test

```
describe 'filter posts by tag' do
  before do
    create(:post, title: 'Pic1', tag_names: 'yolo')
    create(:post, title: 'Pic2', tag_names: 'swag')
    visit '/posts'
  end

  it 'uses the tag name in the url' do
    click_link '#yolo'
    expect(current_path).to eq '/tags/yolo'
  end
  
  it 'only shows posts with the selected tag' do
    click_link '#yolo'

    expect(page).to have_css 'h1', text: 'Posts tagged with #yolo'
    expect(page).to have_content 'Pic1'
    expect(page).not_to have_content 'Pic2'
  end
end

```

* let's make it pass

```
class Tag < ActiveRecord::Base
  has_and_belongs_to_many :post
  validates :name, uniqueness: true
  
  def to_param
    name.delete '#'
  end
end

```

* now need to fix up so that show will work again

```
def show
  @tag = Tag.find_by_name params[:id]
end
```




