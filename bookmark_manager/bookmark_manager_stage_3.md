# Password Confirmation

Now a user can register on our website but it would be nice to ask for password confirmation on registration to make sure there's no mistake in the password. Let's start by creating a test for this within `user_management_spec.rb`:

```ruby
scenario 'requires a matching confirmation password' do
  # again it's questionable whether we should be testing the model at this
  # level.  We are mixing integration tests with feature tests.
  # However, it's convenient for our purposes.
  expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
end

def sign_up(email: 'alice@example.com',
            password: '12345678',
            password_confirmation: '12345678')
  visit '/users/new'
  fill_in :email, with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end
```

The test passes a different value for `password` and `password_confirmation` and then expects the user registration to be rejected because of the differing password values.

* :white_check_mark: You'll need to update the new user form.  Can you work out what you should add based on the error message you get from running the above test?

Assuming you change the form correctly you now get the following error:

```
Failures:

1) User sign up requires a matching confirmation password
   Failure/Error: expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
     expected #count not to have changed, but did change from 0 to 1
   # ./spec/features/user_management_spec.rb:19:in `block (2 levels) in <top (required)>'
```

So now our form is working and we need to implement the password confirmation functionality at a lower level in `user.rb`:

```ruby
attr_reader :password
attr_accessor :password_confirmation

# validates_confirmation_of is a DataMapper method
# provided especially for validating confirmation passwords!
# The model will not save unless both password
# and password_confirmation are the same
# read more about it in the documentation
# http://datamapper.org/docs/validations.html
validates_confirmation_of :password
```

To enable `validates_confirmation_of` in DataMapper, you may need to include `require 'dm-validations'` in your `data_mapper_setup` file.

What is the relationship between `password`, `password_confirmation` and `password_digest`?  Discuss this with your pair partner.  Consider the reasons for each being defined differently with `attr_reader`, `attr_accessor` and `property` respectively.  Discuss how `validates_confirmation_of :password` might work.

Try running your tests.  Is anything missing?

```ruby
post '/users' do
  user = User.create(email: params[:email],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])
  session[:user_id] = user.id
  redirect to('/links')
end
```

Is this working yet?  It turns out the validation only works if a password is provided.  But we are providing a password aren't we?  We have an `attr_reader :password`, but we aren't setting `@password` at any point, so that attribute is always `nil`:

```ruby
def password=(password)
  self.password_digest = BCrypt::Password.create(password)
end
```

Because we have a custom writer for this property, we'll never be storing the plain text password in an instance variable and datamapper will be unable to compare it to the password confirmation. Let's fix it by modifying our writer.

```ruby
def password=(password)
  @password = password
  self.password_digest = BCrypt::Password.create(password)
end
```

Tests should now pass.

[ [Next Stage](bookmark_manager_stage_4.md) ]

[ [Return to outline](bookmark_manager.md) ]
