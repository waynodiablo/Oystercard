Tags
====

Illustrating many to many relationships in Rails

* make a tagging_feature_spec

```ruby
describe 'tagging posts' do
  before do
    alex = create :user
    login_as alex
  end
  it 'displayed the tags on the posts page' do
    visit 'posts/new'
    fill_in 'Title', with: 'My new post'
    fill_in 'Description', with: 'Lorem ipsum'
    attach_file 'Picture', Rails.root.join('spec/images/old-man1.jpg')
    fill_in 'Tags', with: 'yolo, swag'
    click_button 'Post it!'

    expect(page).to have_link '#yolo'
    expect(page).to have_link '#swag'
  end
end
```

* Check test is failing - unable to find field for tags

* adjust form to include tags

<%= f.label :tag_names, 'Tags' %>
<%= f.text_field :tag_names %>

* Check test is failing - undefined method tag_names

* add tag_names method to model

```ruby
def tag_names
  ''
end

```

* update controller to allow tag_names to be assigned

* add tag_names setter to model

```ruby
def tag_names=(tag_names)
  raise tag_names
end

```

* note that this doesn't raise an error when posting a new post so adjust the controller to permit

```ruby
def create
  @post = Post.new(params[:post].permit(:title, :description, :image, :tag_names))
  @post.user = current_user
  @post.save!

  redirect_to posts_path
end
```

* now write unit tests in rspec

```ruby
describe Post do
  let(:post){Post.new}
  describe '#tag_names=' do
    describe 'no tags' do
      it 'does nothing' do
        post.tag_names = ''
        expect(post.tags).to be_empty
      end
    end
  end
end

```

* add another test for one tag

```ruby
describe Post do
  describe '#tag_names=' do
    describe 'one tag' do
      it 'adds a single tag to the post' do
        post.tag_names = 'yolo'
        expect(post.tags.count).to eq 1
      end
    end
  end
end
```

* check that that fails 

* now we need to generate model tag

`bin/rails g model Tag name:string`

* add 'has_and_belongs_to_many' to both tag.rb and post.rb

* run migrations

* test will error since we don't have join table

bin/rails g migration CreateJoinTablePostsTags post tag

* run migration and check that tests fail in correct fashion
 
* adjust the post.rb model

```ruby
def tag_names=(tag_names)
  self.tags.create(name:tag_names)
end

```
* check tests

* add another test for prepending a #

```ruby
describe Post do
  describe '#tag_names=' do
    describe 'one tag' do
      it 'prepends a tag with #' do
        post.tag_names = 'yolo'
        tag = post.tags.last
        expect(tag.name).to eq '#yolo'
      end
    end
  end
end
```

* check that this fails

* adjust model

```ruby
def tag_names=(tag_names)
  return nil if tag_names == ''
  self.tags.create(name:'#'+tag_names)
end

```

* add another test

```ruby
describe Post do
  describe '#tag_names=' do
    describe 'one tag' do
      it 'does not double up #s' do
        post.tag_names = '#yolo'
        tag = post.tags.last
        expect(tag.name).to eq '#yolo'
      end
    end
  end
end

```

* adjust model

```ruby
def tag_names=(tag_names)
  return nil if tag_names == ''
  self.tags.create(name:'#'+tag_names.delete('#'))
end

```

* add a test for comma separated tags


```ruby
describe Post do
  describe '#tag_names=' do
    describe 'multiple tag' do
      it 'adds a single tag to the post' do
        post.tag_names = 'yolo, swag'
        expect(post.tags.count).to eq 2
      end
    end
  end
end

```

* adjust model

```ruby
def tag_names=(tag_names)
  return nil if tag_names == ''
  tag_names.split(', ').each do |tag_name|
    self.tags.create(name:'#'+tag_name.delete('#'))
  end
end

```

* add test for reusing tags


```ruby
describe Post do
  describe '#tag_names=' do
    describe 're-using tags' do
      let!(:tag){ Tag.create(name: '#yolo')}

      it 'reuses tags if they exist' do
        post.tag_names = 'yolo'
        expect(Tag.count).to eq 1

        expect(tag.posts).to include post
      end
    end
  end
end

```

* check failure

* adjust model

```ruby
def tag_names=(tag_names)
  return nil if tag_names == ''
  tag_names.split(', ').each do |tag_name|
    formatted_name = '#'+tag_name.delete('#')
    tag = Tag.find_or_create_by(name: formatted_name)
    tags << tag
    #self.tags.create(name:'#'+tag_name.delete('#'))
  end
end

```

* add test for Tag being unique

```ruby
describe Tag do
  it 'should be unique' do
    Tag.create(name: '#yolo')
    duplicate = Tag.new(name: '#yolo')

    expect(duplicate).to have(1).error_on(:name)
  end
end
```

* add validation to Tag

```ruby
class Tag
  validates :name, :uniqueness
end
```

* add test for multiple duplicate tags

```ruby
describe Post do
  describe '#tag_names=' do
    describe 'multiple duplicate tags' do
      it 'uses only unique tags' do
        post.tag_names = 'yolo, swag, yolo'
        expect(post.tags.count).to eq 2
      end
    end
  end
end

```

* adjust model to ensure tags are uniq


```ruby
def tag_names=(tag_names)
  return nil if tag_names == ''
  tag_names.split(', ').uniq.each do |tag_name|
    formatted_name = '#'+tag_name.delete('#')

    tag = Tag.find_or_create_by(name: formatted_name)
    tags << tag
  end
end

```

* run all tests - should see failing as tags are not displayed

* add to view

```
<% post.tags.each do |tag|%>
  <%= link_to tag.name, '#' %>
<% end %>
```

Challenges
------

* handle more than one space dividing tags











![Tracking pixel](https://githubanalytics.herokuapp.com/course/walkthroughs/tags.md)
