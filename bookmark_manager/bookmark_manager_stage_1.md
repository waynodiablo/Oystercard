# Tagging links

## Adding tags to links

By now we have a web application that allows us to add new links to the database and show the entire list on the front page. We have feature tests that give us comfort that if something breaks, we'll know about it straight away.

Let's implement a new feature: allowing links to have a single tag associated with them.

* :white_check_mark: As usual, let's start with a test:

```ruby
# /spec/features/adding_tags_spec.rb
feature 'Adding tags' do

  scenario 'I can add a single tag to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'

    fill_in 'tag',  with: 'education' # for now, let's input a single tag value.
    #later on we can go for multiple tags.

    click_button 'Create link'
    link = Link.first
    expect(link.tags).to include('education')
  end

end
```
You should get a Capybara error: `cannot find field "tag"`.

* :white_check_mark: Amend the new link form to accept an input with the name 'tag'.

Moving on...

```
1) Adding tags I can add a single tag to a new link
     Failure/Error: expect(link.tags).to include("education")
     NoMethodError:
       undefined method `tags' for #<Link:0x007fe22c3a95b0>
     # ./spec/features/adding_links_spec.rb:19:in `block (2 levels) in <top (required)>'
```

So, the test tells us that the method "tags" is undefined.   But what do we want our `tags` method to be?  Ideally, it would be some clever method that allows us to access all the tags associated with this link automatically.  Well, with DataMapper, that's exactly what we can do by defining a relationship.  In this case, it's a **many-to-many** relationship (why?), which we can model like this in `link.rb`:

```ruby
has n, :tags, through: Resource
```

The details of how datamapper works with many-to-many relationships (through: Resource) are well described in its [documentation](http://datamapper.org/docs/associations.html). At some point you may wish to check out this pill and familiarize yourself with the types of database relationships: :pill:[Database Relations](../pills/database_relations)

Let's go back and run the test. We get another error:

```
Cannot find the child_model Tag for Link in tags (NameError)
```

The error occurs because we haven't defined the associated `Tag` model, which the Link model now expects to exist.

Before adding the Tag model, let's review the process we're going through.  
1. We have written a test that describes the functionality we want to see.  
2. We then ran the test and it highlighted a problem - no tags associated to a link. We then fixed that problem specifically. As we didn't create the Tag class straight away, we ran the test again and it told us that we didn't have the Tag model. We then know we need to create a Tag model to overcome the error.

We'll be repeating this process several times over, taking baby-steps forward.

### The Tag Model

Let's create the Tag model.

```ruby
class Tag
  include DataMapper::Resource

  property :id, Serial
  property :name, Serial
end
```
Remember to require the file within `data_mapper_setup.rb`.
Let's move over to the next error.

Next error:
```
Failure/Error: expect(link.tags).to include('education')
       expected [] to include "education"
```
Though we might think `[]` denotes an array, what we see here is just the string representation of an object.  It may be an `Array` - it may be any other type of object whose string representation is `[]`.  In this case, it is actually a [DataMapper collection](http://www.rubydoc.info/github/datamapper/dm-core/master/DataMapper/Collection) (which is much like an array). We're in a similar situation to before: we're POST'ing a value from an input field, namely 'tag', but nothing is happening with that data. Let's update the relevant route:

```ruby
post '/links' do
  link = Link.new(url: params[:url],     # 1. Create a link
                title: params[:title])
  tag  = Tag.create(name: params[:tag]) # 2. Create a tag for the link
  link.tags << tag                       # 3. Adding the tag to the link's DataMapper collection.
  link.save                              # 4. Saving the link.
  redirect to('/links')
end
```
You might want to spend some time understanding exactly what's going on in this action.  There are some common patterns presented here.

Our tests still fail. This is a good opportunity to go through a debugging process and also to consider whether to refactor our tests.

* See if you can reach the point of getting the following error:

```
1) Adding tags I can add a single tag to a new link
    Failure/Error: expect(link.tags).to include('education')
      expected [#<Tag @id=2 @text="education">] to include "education"
      Diff:
      @@ -1,2 +1,2 @@
      -["education"]
      +[#<Tag @id=2 @text="education">]
```

It turns out we made a mistake in our test. The array-like collection returned by `link.tags` contains Tag objects, not tag names (such as 'education').  We could fix the test by extracting tag names.

```ruby
expect(link.tags.map(&:text)).to include 'education'
```
Now all our tests pass!  However, on reflection, we may be mixing up our tests a little.  We began by setting up the UI, then finished by testing the models.  It can be difficult sometimes to separate the responsibilities of tests and you may find yourself writing tests like this one to _drive the code you want to write_.  This is often an indication that we are missing a test layer.  As you become more experienced, you will learn when to introduce new testing layers.  For now, just think of this as a conversation point and discuss with you pair partner how you might have written different tests.


## Filtering by a tag

Adding tags to links is useful but it'd be even more useful to be able to filter links by a tag. Let's write a test for filtering links by the term "bubbles".
Within `viewing_links_spec.rb`:
```ruby
scenario 'I can filter links by tag' do
  visit '/tags/bubbles'
  expect(page).not_to have_content('Makers Academy')
  expect(page).not_to have_content('Code.org')
  expect(page).to have_content('This is Zombocom')
  expect(page).to have_content('Bubble Bobble')
end
```

Let's also define a `before(:each)` block to create some test data.  How will this `before` block affect our existing test?

```ruby
  before(:each) do
    Link.create(url: 'http://www.makersacademy.com',
                title: 'Makers Academy',
                tags: [Tag.first_or_create(name: 'education')])
    Link.create(url: 'http://www.google.com',
                title: 'Google',
                tags: [Tag.first_or_create(name: 'search')])
    Link.create(url: 'http://www.zombo.com',
                title: 'This is Zombocom',
                tags: [Tag.first_or_create(name: 'bubbles')])
    Link.create(url: 'http://www.bubble-bobble.com',
                title: 'Bubble Bobble',
                tags: [Tag.first_or_create(name: 'bubbles')])
  end
```

Sure enough, the test fails because Sinatra returns a "404 Not Found" page for the route that doesn't exist yet. Let's add the route.

```ruby
get '/tags/:name' do
  tag = Tag.first(name: params[:name])
  @links = tag ? tag.links : []
  erb :'links/index'
end
```

First we find the tag that we need (note the use of the parameter `:name` in the route). Then, if the tag exists, we get associated links. Otherwise, we just return an empty array.

Run your tests. You might get an epic error message, but if you scroll to the top you'll find the important part:

```
Failure/Error: expect(page).not_to have_content('Makers Academy')
  expected not to find text "Makers Academy" in "NoMethodError at /tags/bubbles undefined method `links' for #<Tag @id=8 @text=\'bubbles\'"
```
Whereas `link.tags` returns an array-like DataMapper Collection, it seems that `tag.links` blows up with a NoMethodError. Looking at the Tag class, it should be relatively clear why: we haven't declared the many-to-many relationship there yet. **Both partners in a many-to-many relationship need to know about each other**. Let's do that:
```ruby
# within the body of the Tag class (./app/models/tag.rb)
has n, :links, through: Resource
```
Run your tests again and you should get a whole series of messages referencing SQL errors. Examine the errors, though don't worry about understanding them. Think about what change a 'many-to-many' relationship should make to a database.

The problem is that our declaration in Tag above requires a structural change to the database. But in our data_mapper_setup.rb, the command `DataMapper.auto_upgrade!` only makes non-destructive changes.
* :white_check_mark: Change `DataMapper.auto_upgrade!` to `DataMapper.auto_migrate!`.

Doing so should make your tests go green. For safety's sake, immediately switch back to `auto_upgrade!` (see further activities below for implementing the best practice for this).


## Further Activities:

* :white_check_mark: We chose to implement the most simple form of tagging: single tags. We probably want users to be able to give links many tags, however. Get to work on this new feature! Here's a test to get you started:
```ruby
scenario 'I can add multiple tags to a new link' do
  visit '/links/new'
  fill_in 'url',   with: 'http://www.makersacademy.com/'
  fill_in 'title', with: 'Makers Academy'
  # our tags will be space separated
  fill_in 'tags',  with: 'education ruby'
  click_button 'Create link'
  link = Link.first
  expect(link.tags.map(&:name)).to include('education', 'ruby')
end
```
Note: This test is not compatible with the first.  As your design emerges, you will often need to update existing tests to fit in.

* :white_check_mark: What happens if the user submits no value within the tag field? Is a tag still being created? Do you think this a problem? If it is, fix it!

* :white_check_mark: Setup a rake task for performing migrations.

[ [Next Stage](bookmark_manager_stage_2.md) ]

[ [Return to outline](bookmark_manager.md) ]
