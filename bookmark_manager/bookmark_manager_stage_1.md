# Managing links and tags

## Browsing links

Let's write our first integration test using Capybara. First, add capybara to your Gemfile and install it. Then, require and configure it in spec_helper as instructed on the capybara github page.

```ruby
require 'capybara/rspec'

Capybara.app = BookmarkManager
```

Then, create ```spec/features``` folder where our integration(Capybara) tests will be. Create the first test ```listing_all_links_spec.rb``` that visits the homepage and checks that the link we put in the database is there.

```ruby
feature 'User browses the list of links' do

  before(:each) do
    Link.create(url: 'http://www.makersacademy.com',
                title: 'Makers Academy')
  end

  scenario 'when opening the home page' do
    visit '/'
    expect(page).to have_content('Makers Academy')
  end
end
```

So, this test creates one link, goes to the homepage and expects to see it there (well, not exactly, it just looks for "Makers Academy" words somewhere on the page). If you run the test, it should fail.
```
Failures:

  1) User browses the list of links when opening the home page
     Failure/Error: expect(page).to have_content("Makers Academy")
       expected to find text "Makers Academy" in "Welcome to the "
     # ./spec/features/listing_all_links_spec.rb:11:in `block (2 levels) in <top (required)>'
```

This is because we haven't written any code to show the links on the homepage. Let's add it.

Current links:

```html
<ul>
  <% @links.each do |link| %>
    <li><a href='<%= link.url %>'><%= link.title %></a></li>
  <% end %>
</ul>
```

```ruby
get '/' do
  @links = Link.all
  erb :index
end
```

Now our tests pass.
```

Finished in 0.03551 seconds
2 examples, 0 failures
```

Current state is on Github.
https://github.com/makersacademy/bookmark_manager/tree/7d35ba70c772421e64999eac68a2e28f0501780b


## Submitting a new link

So, let's add a few basic features to the website. First, we need to somehow submit new links. Let's add a new test for it, ```adding_links_spec.rb```.

```ruby
feature 'User adds a new link' do
  scenario 'when browsing the homepage' do
    expect(Link.count).to eq(0)
    visit '/'
    add_link('http://www.makersacademy.com/', 'Makers Academy')
    expect(Link.count).to eq(1)
    link = Link.first
    expect(link.url).to eq('http://www.makersacademy.com/')
    expect(link.title).to eq('Makers Academy')
  end

  def add_link(url, title)
    within('#new-link') do
      fill_in 'url', with: url
      fill_in 'title', with: title
      click_button 'Add link'
    end
  end
end
```

The code should be self-explanatory. We expect to have no links until we go to the homepage and fill out the form inside #new-link element and submit it. Afterwards, we'll have one link in the database with the properties that we specified when creating it.

This test fails, so let's make it pass. First, we'll need to create the form in question.

```html
<div id='new-link'>
  <form action='/links' method='post'>
    Url: <input type='text' name='url'>
    Title: <input type='text' name='title'>
    <input type='submit' value='Add link'>
  </form>
</div>
```

Then we'll need to add a new route that will handle the form submission.

```ruby
post '/links' do
  url = params['url']
  title = params['title']
  Link.create(url: url, title: title)
  redirect to('/')
end
```

Current state is on Github.
https://github.com/makersacademy/bookmark_manager/tree/8844773e81ba888327a1bef46737c6cf5c36597f

## Adding tags to links

By now we have a web application that allows us to add new links to the database and show the entire list on the front page. We have integration tests that give us comfort that if something breaks, we'll know about it straight away.

Let's implement a new feature: allowing links to have tags associated with them. As usual, let's start with a test.

```ruby
  scenario 'with a few tags' do
    visit '/'
    add_link('http://www.makersacademy.com/',
             'Makers Academy',
             %w(education ruby))
    link = Link.first
    expect(link.tags).to include('education')
    expect(link.tags).to include('ruby')
  end

  def add_link(url, title, tags = [])
    within('#new-link') do
      fill_in 'url', with: url
      fill_in 'title', with: title
      # our tags will be space separated
      fill_in 'tags', with: tags.join(' ')
      click_button 'Add link'
    end
  end
```

Note that we modified add_link() method to have the third parameter with a default value to make sure it's still compatible with the other test we wrote earlier. Of course, our test fails. Our test wants to fill out a field that doesn't exist. Let's fix it.

```html
Tags: <input type='text' name='tags'>
```
Next error:

```

1) User adds a new link with a few tags
     Failure/Error: expect(link.tags).to include("education")
     NoMethodError:
       undefined method `tags' for #<Link:0x007fe22c3a95b0>
     # ./spec/features/adding_links_spec.rb:19:in `block (2 levels) in <top (required)>'
```

So, the test tells us that the method "tags" is undefined. This is because our Link model doesn't have any tags associated with it. Let's add a many-to-many relationship to our Link model.

```ruby
has n, :tags, through: Resource
```

The details of how datamapper works with many-to-many relationships (through: Resource) are well described in its documentation.

Let's go back and run the test. We get another error:

```sh
Cannot find the child_model Tag for Link in tags (NameError)
```

The error occurs because we haven't defined a Tag model, which the Link model now expects to exist.

Before adding the Tag model, let's review the process we're going through. We have written a test that describes the functionality we want to see. We then ran the test and it highlighted a problem - no tags associated to a link. We then fixed that problem specifically. As we didn't create the Tag class straight away, we ran the test again and it told us that we didn't have the Tag model. We then know we need to create a Tag model to overcome the error.

We'll be repeating this process several times over.

This is the fundamental concept of test-driven and behaviour-driven development. You shouldn't merely have tests, instead they should actually drive the coding process. On many occasions you'll be able to predict the next error and you'll be tempted to fix a few things in one go. For example if there were no tags linked to the Link model, it was obvious that we should have created a many-to-many relationship and created the Tag model as well. However, be careful not to jump too far: the more code you write without the tests guiding you, the more likely you are to make an error. Some developers prefer to follow test messages very closely, doing the absolute minimum of work required to make them pass. Some move a few error messages at a time (like we've done before when we wrote our first test and wrote a dozen lines of code in one go.

There isn't a one rule fits all approach. If you're unsure, follow the tests closely: they will guide you towards writing only the necessary amount of good code to get the job done.

So, let's create the Tag model that also has a many-to-many relationship to Link.

```ruby
class Tag

  include DataMapper::Resource

  has n, :links, through: Resource

  property :id, Serial
  property :text, String

end
```
and remember to require the file within ```server.rb```:

```ruby
require 'tag'
```

Note that we're doing a few things other than creating an empty datamapper model without letting the tests tell us that we need to do it (add the relationship with Link, add the text property). Use your best judgement when choosing how fast to go.

Let's move over to the next error.
```

2) User adds a new link with a few tags
     Failure/Error: fill_in 'tags', with: tags.join(' ')
     Capybara::ElementNotFound:
       Unable to find field "tags"
```

Next error:
```

Failure/Error: expect(link.tags).to include('education')
       expected [] to include "education"
```

So, the test is filling out the form correctly since we added a new input fields but the data doesn't end up in the database. Time to fix it in server.rb.
```ruby

tags = params['tags'].split(' ').map do |tag|
  # this will either find this tag or create
  # it if it doesn't exist already
  Tag.first_or_create(text: tag)
end
Link.create(url: url, title: title, tags: tags)
```

Note that we're searching for a tag record in the database (or creating an instance of the Tag class if it doesn't exist) and then passing an array of instances to Link, as opposed to passing just the text. This is because a Tag is not simply a string, it's a database record that has text and id but may have other properties in the future (user_id of the user who created it, created_at timestamp, etc).

However, if we run the test, we'll still get an error.

```
Failure/Error: expect(link.tags).to include('education')
       expected [#<Tag @id=1 @text="education" @link_id=4>, #<Tag @id=2 @text="ruby" @link_id=4>] to include "education"
       Diff:
       @@ -1,2 +1,2 @@
       -["education"]
       +[#<Tag @id=1 @text="education" @link_id=4>, #<Tag @id=2 @text="ruby" @link_id=4>]
```

It turns out we made a mistake in our test. Instead of expecting the link.tags array to contain strings, we should expect it to contain instances of Tag object. Let's fix the test by mapping the Tag instances to the text they contain.

```ruby

expect(link.tags.map(&:text)).to include 'education', 'ruby'

```
Now all our tests pass.

```
Finished in 0.12076 seconds
4 examples, 0 failures
```
Current state is on Github.
https://github.com/makersacademy/bookmark_manager/tree/88dd9bc90041fc02dd5f335ad4ddfc0eab430c4e

## Filtering by tag

Adding tags to links is useful but it'd be even more useful to be able to filter links by a tag. Let's write a test for this in ```listing_all_links_spec.rb``` first.

```ruby
scenario 'filtered by a tag' do
  visit '/tags/search'
  expect(page).not_to have_content('Makers Academy')
  expect(page).not_to have_content('Code.org')
  expect(page).to have_content('Google')
  expect(page).to have_content('Bing')
end
```

Let's also update the before(:each) block to create some test data.

```ruby
  before(:each) {
    Link.create(url: 'http://www.makersacademy.com',
                title: 'Makers Academy',
                tags: [Tag.first_or_create(text: 'education')])
    Link.create(url: 'http://www.google.com',
                title: 'Google',
                tags: [Tag.first_or_create(text: 'search')])
    Link.create(url: 'http://www.bing.com',
                title: 'Bing',
                tags: [Tag.first_or_create(text: 'search')])
    Link.create(url: 'http://www.code.org',
                title: 'Code.org',
                tags: [Tag.first_or_create(text: 'education')])
  }
  ```

Sure enough, the test fails because Sinatra returns a "404 Not Found" page for the route that doesn't exist yet. Let's add the route.

```ruby
get '/tags/:text' do
  tag = Tag.first(text: params[:text])
  @links = tag ? tag.links : []
  erb :index
end
```

First we find the tag that we need (note the use of a named parameter in the route). Then, if the tag exists, we get associated links. Otherwise, we just return an empty array.

Current state is on Github
https://github.com/makersacademy/bookmark_manager/tree/e45ed5d9c3289c8320632e6aadcc56c3d624fbcc

[ [Next Stage](bookmark_manager_stage_2.md) ]

[ [Return to outline](bookmark_manager.md) ]
