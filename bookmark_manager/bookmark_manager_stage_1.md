* mention that they should add a new feature file - adding tags
* tags first error is wrong - should be no field tags. This error shows up later in the tutorial - swap it round.
* add a link to datamapper docs 'through resource'
* helper 'tags' should be extracted to module and tested

# Tagging links

## Adding tags to links

By now we have a web application that allows us to add new links to the database and show the entire list on the front page. We have feature tests that give us comfort that if something breaks, we'll know about it straight away.

Let's implement a new feature: allowing links to have a single tag associated with them. As usual, let's start with a test.

```ruby
feature 'User adds a link' do

  scenario 'with a single tag' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    # our tags will be space separated
    fill_in 'tags',  with: 'education' # for now, let's input a single tag value. Later on we can go for multiple tags.
    click_button 'Add link'
    link = Link.first
    expect(link.tags).to include('education')
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

So, let's create the Tag model. Check out this pill and familiarise yourself with the flavours of database relationships: :pill:[Database Relations](../pills/database_relations)

```ruby
class Tag
  include DataMapper::Resource

  property :id, Serial
end
```
and remember to require the file within ```data_mapper_setup.rb```.
Let's move over to the next error.

Next error:
```
Failure/Error: expect(link.tags).to include('education')
       expected [] to include "education"
```
Though we might think `[]` denotes an array, it is actually a [DataMapper collection](http://www.rubydoc.info/github/datamapper/dm-core/master/DataMapper/Collection) (which is much like an array). We're in a similar situation to before: we're POST'ing a value from an input field, namely 'tags', but nothing is happening with that data. Let's update the relevant route:

```ruby
post '/links' do
  link = Link.new(url: params[:url],
                title: params[:title])
  tag  = Tag.create(text: params[:text])
  link.tags << tag
  link.save
  redirect to('/links')
end
```
So what we're doing here is the following:
1. Creating our link
2. Creating the tag for that link.
3. Shoveling the tag into the link's tags DataMapper Collection.
4. Saving the link.

Our tests still fail. This is a good opportunity to go through a debugging process. What step have we missed?

* Debug to the point of getting the following error:

```
1) User adds a link with a tag
    Failure/Error: expect(link.tags).to include('education')
      expected [#<Tag @id=2 @text="education">] to include "education"
      Diff:
      @@ -1,2 +1,2 @@
      -["education"]
      +[#<Tag @id=2 @text="education">]
```

It turns out we made a mistake in our test. Instead of expecting the link.tags array to contain a string, we should expect it to contain instances of Tag object. Let's fix the test by extracting out the value we want to checkout within our expectation

```ruby

expect(link.tags.map(&:text)).to include 'education'

```
Now all our tests pass! =)

## Filtering by a tag

Adding tags to links is useful but it'd be even more useful to be able to filter links by a tag. Let's write a test for filtering links by the term "bubbles".
Within ```listing_all_links_spec.rb```:
```ruby
scenario 'filtered by a tag' do
  visit '/tags/bubbles'
  expect(page).not_to have_content('Makers Academy')
  expect(page).not_to have_content('Code.org')
  expect(page).to have_content('This is Zombocom')
  expect(page).to have_content('Bubble Bobble')
end
```

Let's also define a before(:each) block to create some test data.

```ruby
  before(:each) do
    Link.create(url: 'http://www.makersacademy.com',
                title: 'Makers Academy',
                tags: [Tag.first_or_create(text: 'education')])
    Link.create(url: 'http://www.google.com',
                title: 'Google',
                tags: [Tag.first_or_create(text: 'search')])
    Link.create(url: 'http://www.zombo.com',
                title: 'This is Zombocom',
                tags: [Tag.first_or_create(text: 'bubbles')])
    Link.create(url: 'http://www.bubble-bobble.com',
                title: 'Bubble Bobble',
                tags: [Tag.first_or_create(text: 'bubbles')])
  end
```

Sure enough, the test fails because Sinatra returns a "404 Not Found" page for the route that doesn't exist yet. Let's add the route.

```ruby
get '/tags/:text' do
  tag = Tag.first(text: params[:text])
  @links = tag ? tag.links : []
  erb :'links/index'
end
```

First we find the tag that we need (note the use of a named parameter in the route). Then, if the tag exists, we get associated links. Otherwise, we just return an empty array.

Run your tests. You should get an epic error message, but if you scroll to the top you'll find the important part:

```ruby
Failure/Error: expect(page).not_to have_content('Makers Academy')
  expected not to find text "Makers Academy" in "NoMethodError at /tags/bubbles undefined method `links' for #<Tag @id=8 @text=\'bubbles\'"
```
Whereas `link.tags` returns an array-like DataMapper Collection, it seems that `tag.links` blows up with a NoMethodError. Looking at the Tag class, it should be relatively clear why: we haven't declared the many-to-many relationship. Let's do that:
```ruby
# within the body of the Tag class (./app/models/tag.rb)
has n, :links, through: Resource
```
Run your tests again and you should get a whole series of messages referencing SQL errors. Examine the errors, though don't worry about understanding them. Think about what change a 'many-to-many' relationship should make to a database.

The problem is that our declaration in Tag above is proposing a structural change to the database. But in our data_mapper_setup.rb, the command `DataMapper.auto_upgrade!` only makes non-destructive changes. What we need to do is change this to `DataMapper.auto_migrate!`. Doing so should make your tests go green. For safety's sake, switch back to `auto_upgrade!` (see extra activity below for implementing the best practice for this).


## Extra Activities:

* We chose to implement the most simple form of tagging: single tags. We probably want users to be able to give links many tags, however. Get to work on this new feature! Here's a test to get you started:
```ruby
scenario 'with multiple tags' do
  visit '/links/new'
  fill_in 'url',   with: 'http://www.makersacademy.com/'
  fill_in 'title', with: 'Makers Academy'
  # our tags will be space separated
  fill_in 'tags',  with: 'education ruby'
  click_button 'Add link'
  link = Link.first
  expect(link.tags.map(&:text)).to include('education', 'ruby')
end
```
* What happens if the user submits no value within the tag field? Is a tag still being created? Do you think this a problem? If it is, fix it!

* Setup Rake task for migration.

[ [Next Stage](bookmark_manager_stage_2.md) ]

[ [Return to outline](bookmark_manager.md) ]
