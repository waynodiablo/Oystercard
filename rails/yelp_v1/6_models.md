# Section 6: Models & Migrations

#### The second test – creating a restaurant on the backend

Add the following inside the 'restaurants' feature block in `spec/features/restaurants_feature_spec.rb`:

```ruby
...

context 'restaurants have been added' do
  before do
    Restaurant.create(name: 'KFC')
  end

  scenario 'display restaurants' do
    visit '/restaurants'
    expect(page).to have_content('KFC')
    expect(page).not_to have_content('No restaurants yet')
  end
end
...
```

Note that the creation of the object here is similar to DataMapper using the term Restaurant.create, although in this case we are using the Rails gem ActiveRecord to create an object that will be stored in the database.

Running the tests here should give us the error 'Uninitialized constant Restaurant' which indicates that we need a Restaurant model to satisfy our failing test.

##### Creating Models

Models contain all the logic behind the 'nouns' that make up your app. In our case, these are going to be restaurants, reviews, etc. They add constraints to on how these objects can behave and tell the app how they should be represented in the database.

`$ bin/rails g model restaurant name:string rating:integer`

Which should generate terminal output something like the following:

```sh
invoke  active_record
create    db/migrate/20141215193023_create_restaurants.rb
create    app/models/restaurant.rb
```

Note that we can abbreviate generate to g (just as server was abbreviated to s) and that we can remove anything we generate using the same command but replacing 'generate' with 'destroy' (or d).

This command does a couple of things:

* it creates a new model, which tells the app what a 'restaurant' is and what properties it has.
* it creates a **migration** which contains instructions for Rake ('Ruby `make`') to update the database.

Specifically, we've added 'name' and rating properties for each restaurant. Each item gets an ID automatically.

**Vitally**, in the model 'restaurant' is singular, but the controller refers to 'restaurants'. Rails makes lots of assumptions based on how you pluralise things, so be very careful of this!

Unlike in Datamapper where we might add a property :name, String in the model file, in Rails active record the properties are all specified in migrations, so that we have a precise record of the changes that the database goes through as we evolve our models over time, and they can all be stored in our version control system.

Looking at db/migrate/20141215193023_create_restaurants.rb we see the following file has been created:

```ruby
class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :rating

      t.timestamps
    end
  end
end
```



Note that as well as the string name property that we specified in the generator, two timestamp columns are automatically added so we know when a given record was created or last updated. The migration itself is timestamped based on when we ran the generate command.

##### Migrations

* We can run our tests now, but we'll get a reminder that we need to actually run these migrations in order to support the Restaurant model that we want to work with:

```sh
bin/rake db:migrate
```

* Depending on our setup we might also have to run this migration (which creates the restaurant table in the database) on the test database like so:

```sh
bin/rake db:migrate RAILS_ENV=test
```

(Here, **string** and **integer** are types of data that your database can store. Rails will interpret these terms differently depending on what type of database you use, but in principle *string* has a length limit of 255 characters while integer is a number.)

It's easy to make a mistake during generation.  You can quickly erase your work using the above command but using instead `rails d` – for destroy – to remove the migration.

Then:

`$ bin/rake db:migrate`

which will run all of your database migrations.

(A word on migrations – if you need to change something, **don't edit the schema file**. If you want to remove database tables or change the schema in any way, instead write another migration that does that).

### [Next Section - Displaying Restaurants](7_displaying_restaurants.md)
