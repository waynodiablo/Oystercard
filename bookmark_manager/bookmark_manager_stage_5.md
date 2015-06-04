### Three levels of data checks

Right now we don't do any validations except that the passwords should match. However, we shouldn't be registering the user in the first place if the email is already taken.

In general, there are three levels at which you can and should check for the uniqueness in a well-designed application.

Firstly, you should check it before the form is submitted by sending a request to the server to check if the form is valid. This is done using Javascript that we haven't covered yet, so let's ignore it for now. You can't rely exclusively on this check anyway because the form may be submitted directly without the page being rendered or javascript may be disabled.

You can see an example of it in action on Github if you try to create a new repository with a non-unique name.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1380107708596_Screen%20Shot%202013-09-25%20at%2012.13.52.png "bookmark manager")

Secondly, you should check for the uniqueness of records on the model level by using validations. This will allow you to display meaningful error messages. So, on the model level we want to have a uniqueness validation:

```ruby
validates_uniqueness_of :email
```

This datamapper validation will check if a record with this email exists before trying to create a new one.

Finally, you should introduce database-level constraints. This is a safety check that protects the database in case any data is written directly, bypassing the model. For example, if you need to batch-add 10,000 new users from a text file, you may not want to initialise your User model for every record for performance reasons. Instead, you'll write to the database directly bypassing datamapper. To account for any cases when you may want to write to the database bypassing your models, you need to have database-level contraints.

```ruby
property :email, String, unique: true
```

This will generate SQL that will create a unique index on that field.

```
CREATE TABLE "users" ("id" SERIAL NOT NULL, "email" VARCHAR(50), "password_digest" TEXT, PRIMARY KEY("id"))
CREATE UNIQUE INDEX "unique_users_email" ON "users" ("email")
```
This unique index on users.email will make sure that no records with duplicate emails will ever be saved to the database.

In datamapper's case, creating a unique index automatically implies the necessity of the validation, so this code

```ruby
validates_uniqueness_of :email
```

would be unnecessary. When using other ORMs, double check if creating a unique index implies a model-level validation.

[ [Next Stage](bookmark_manager_stage_6.md) ]

[ [Return to outline](bookmark_manager.md) ]
