### Data Validation: 3 Levels.

Right now our validations are ensuring only that the user doesn't make a typo when entering their password. However, we also shouldn't be registering a user if they do not provide an email.

Write a feature test to ensure a user can't sign up without entering an email.  Ensure this test is failing correctly before proceeding.


In general, there are three levels at which you can and should validate data in a well-designed application:

1 You could check it in the browser before the form is submitted (this is done using Javascript, which we haven't covered yet so let's postpone that for now). However, you can't rely exclusively on this validation because a post request can be submitted directly without a page ever being rendered; or javascript may be disabled.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1380107708596_Screen%20Shot%202013-09-25%20at%2012.13.52.png "bookmark manager")

2 You should validate it on the server using model validations. This will help you to display meaningful error messages.   Also, it ensures data integrity issues can't be introduced at the model level.  So, for our required email validation:

```ruby
validates_presence_of :email
```

This DataMapper validation will prevent the model from saving if the email is blank.

3 You must introduce database-level constraints. This ensure data integrity in the database in case data is written directly, bypassing the model. For example, if you need to batch import 10,000 new users from a text file, you may not want to initialize your User model for every record for performance reasons. Instead, you'll write to the database directly. To account for any cases when you may want to write to the database bypassing your models, you need to have database-level constraints.

```ruby
# /app/models/user.rb
property :email, String, required: true
```

This will generate a `NOT NULL` constraint on the `users` table.
```sql
CREATE TABLE "users" ("id" SERIAL NOT NULL, "email" VARCHAR(50) NOT NULL, "password_digest" VARCHAR(60), PRIMARY KEY("id"))
```

Interestingly, in DataMapper's case, creating a `required` property implies the necessity of the validation, so this code...

```ruby
validates_presence_of :email
```

...becomes unnecessary. When using other ORMs, double check if creating a unique index implies a model-level validation.

The model should validate that the email is present.  However, beware that unless you ran `auto_migrate!` instead of `auto_upgrade!`, the `NOT NULL` constraint will not have been created on the database!

If you are having trouble working out how to display a different error message from the previous stage, head on over to the next stage, where all will be revealed...

[ [Next Stage](bookmark_manager_stage_6.md) ]

[ [Return to outline](bookmark_manager.md) ]
