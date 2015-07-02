### Data Validation: 3 Levels.

Right now our validations are ensuring only that the user doesn't make a typo when entering their password. However, we also shouldn't be registering a user if the email is already taken.

Write a feature test to ensure a user can't sign up with an email that is already taken.  Ensure this test is failing correctly before proceeding


In general, there are three levels at which you can and should validate data in a well-designed application:

1 You should check it in the browser before the form is submitted (this is done using Javascript, which we haven't covered yet so let's postpone that for now). However, you can't rely exclusively on this validation because a post request can be submitted directly without a page ever being rendered; or javascript may be disabled.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1380107708596_Screen%20Shot%202013-09-25%20at%2012.13.52.png "bookmark manager")

2 You should validate it on the server using model validations. This will help you to display meaningful error messages.   Also, it ensures data integrity issues can't be introduced at the model level.  So, for our unique email validation:

```ruby
validates_uniqueness_of :email
```

This DataMapper validation will check if a record with this email exists before trying to create a new one.

3 You should introduce database-level constraints. This ensure data integrity in the database in case data is written directly, bypassing the model. For example, if you need to batch inport 10,000 new users from a text file, you may not want to initialize your User model for every record for performance reasons. Instead, you'll write to the database directly. To account for any cases when you may want to write to the database bypassing your models, you need to have database-level constraints.

```ruby
# /app/models/user.rb
property :email, String, unique: true
```

This will generate SQL that will create a unique index on that field.

```sql
CREATE TABLE "users" ("id" SERIAL NOT NULL, "email" VARCHAR(50), "password_digest" TEXT, PRIMARY KEY("id"))
CREATE UNIQUE INDEX "unique_users_email" ON "users" ("email")
```
This unique index on the email column of the users table will make sure that no records with duplicate emails will ever be saved to the database.

In DataMapper's case, creating a unique index automatically implies the necessity of the validation, so this code...

```ruby
validates_uniqueness_of :email
```

...would be unnecessary. When using other ORMs, double check if creating a unique index implies a model-level validation.

Adding a unique constraint to a column through DataMapper may require an `auto_migrate!` instead of an `auto_upgrade!`

[ [Next Stage](bookmark_manager_stage_6.md) ]

[ [Return to outline](bookmark_manager.md) ]
