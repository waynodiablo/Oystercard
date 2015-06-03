* mention that they should add a new feature file - adding tags
* tags first error is wrong - should be no field tags. This error shows up later in the tutorial - swap it round.
* add a link to datamapper docs 'through resource'
* helper 'tags' should be extracted to module and tested

# Tagging links

## Adding tags to links

By now we have a web application that allows us to add new links to the database and show the entire list on the front page. We have feature tests that give us comfort that if something breaks, we'll know about it straight away.

Let's implement a new feature: allowing links to have tags associated with them. As usual, let's start with a test.

```ruby
feature 'User adds a link' do

  scenario 'with a few tags' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    # our tags will be space separated
    fill_in 'tags',  with: 'education ruby'
    click_button 'Add link'
    link = Link.first
    expect(link.tags).to include('education')
    expect(link.tags).to include('ruby')
  end

end
```
You should get a Capybara error: cannot find field "tags".

* Amend the new link form to accept an input with the name 'tags'.

Moving on...

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

The details of how datamapper works with many-to-many relationships (through: Resource) are well described in its [documentation](http://datamapper.org/docs/associations.html).

Let's go back and run the test. We get another error:

```
Cannot find the child_model Tag for Link in tags (NameError)
```

The error occurs because we haven't defined a Tag model, which the Link model now expects to exist.

Before adding the Tag model, let's review the process we're going through.  
1. We have written a test that describes the functionality we want to see.  
2. We then ran the test and it highlighted a problem - no tags associated to a link. We then fixed that problem specifically. As we didn't create the Tag class straight away, we ran the test again and it told us that we didn't have the Tag model. We then know we need to create a Tag model to overcome the error.

We'll be repeating this process several times over.

This is the fundamental concept of test-driven and behaviour-driven development. You shouldn't merely have tests, instead they should actually drive the coding process. On many occasions you'll be able to predict the next error and you'll be tempted to fix a few things in one go. For example if there were no tags linked to the Link model, it was obvious that we should have created a many-to-many relationship and created the Tag model as well. However, be careful not to jump too far: the more code you write without the tests guiding you, the more likely you are to make an error. Some developers prefer to follow test messages very closely, doing the absolute minimum of work required to make them pass. Some move a few error messages at a time (like we've done before when we wrote our first test and wrote a dozen lines of code in one go.

There isn't a one rule fits all approach. If you're unsure, follow the tests closely: they will guide you towards writing only the necessary amount of good code to get the job done.

So, let's create the Tag model that also has a many-to-many relationship to Link. Check out this pill and familiarise yourself with the flavours of database relationships: :pill:[Database Relations](../pills/database_relations)

```ruby
class Tag
  include DataMapper::Resource

  has n, :links, through: Resource

  property :id, Serial
  property :text, String
end
```
and remember to require the file within ```app.rb```:

```ruby
require 'tag'
```

Note that we're doing a few things other than creating an empty datamapper model without letting the tests tell us that we need to do it (add the relationship with Link, add the text property). Use your best judgement when choosing how fast to go.
###### WE'RE HERE - Ptolemy.
Let's move over to the next error.
```

2) User adds a new link with a few tags
     Failure/Error: fill_in 'tags', with: tags.join(' ')
     Capybara::ElementNotFound:
       Unable to find field "tags"
```

Our test wants to fill out a field that doesn't exist. Let's fix it.

```html
Tags: <input type='text' name='tags'>
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
