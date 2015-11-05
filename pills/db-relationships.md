# Relationships between database tables

There're three main types of relationships between tables in the database:

- One to one
- One to many
- Many to many

## One to many

![One-to-many](/images/one-to-many.png)

Here post has many comments. At the database level it means that `comments_table` has a **foreign_key** column `post_id`. When we want to retrieve all comments for the first post using DataMapper

```ruby
  Post.get(1).comments
```

it translates to the SQL query like

```sql
SELECT * FROM comments WHERE post_id = 1;
```
The model definitions will look like this:

```ruby
class Post
  has n :comments
  ...
end

class Comment
  belongs_to :post
  ...
end
```

Note the difference - at the DB level `posts` table doesn't have any pointers to `comments` table. However in the `Post` model we call `has n` method. We do that to have access to the `comments` method.

## One to one

![One-to-one](/images/one-to-one.png)

One-to-one relationship is similar to one-to-many except now both tables have foreign keys pointing at each other.

```ruby
class Person
  include DataMapper::Resource

  has 1, :profile
end

class Profile
  include DataMapper::Resource

  belongs_to :person
end
```

There's no difference between `has 1` and `belongs_to` in the database, it's purely a DataMapper construct.

## Many to many

![Many-to-many](/images/many-to-many.png)

In this example an article can have many categories and a category can have many articles, so we need a many-to-many relationship. To implement that we introduce another table containing both `article_id` and `category_id`. Whenever add a category to an article or vice versa we add a row to `article_categories` table with both article and category id.

```ruby
class Article
  has n, :categories, :through => Resource
  end

class Category
  has n, :article, :through => Resource
  end
end
```

Here we have a `:through => Resource` option passed to both `has n`s. `:through` option tells DataMapper what table is used as a "bridge" table. `Resource` means that we use a conventional table named after both tables it links.

### Many to many `:through`

Sometimes "bridge table" has some unconventional name. In that case we pass table name to `:through`

![Many-to-many-through](/images/many-to-many-through.png)

```ruby
class Link
  has n, :tags, :through => :taggings
  end

class Tag
  has n, :links, :through => :taggings
end
```

### Many to many `:through` with `:via`

![Many-to-many-through-via](/images/many-to-many-through-via.png)

In this example a person can have many friends and also be a friend to many people. On the both sides of this relationship is the `people` table. The bridge table `friendships` contain two foreign keys - `source_id` and `target_id`. In the model we have to define the association with the bridge table name and foreign key name.

```ruby
class Person
  has n, :friendships, :child_key => [ :source_id ]
  has n, :friends, self, :through => :friendships, :via => :target
end

class Friendship
  belongs_to :source, 'Person', :key => true
  belongs_to :target, 'Person', :key => true
end
```
