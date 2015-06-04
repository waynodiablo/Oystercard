  * replace = with :
  * use .not_to change instead of .to change by 0

### Password confirmation

Now a user can register on our website but it would be nice to ask for password confirmation on registration to make sure there's no mistake in the password. Let's start by creating a test for this within ```user_management_spec.rb```:

```ruby
scenario 'with a password that does not match' do
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

The test passes a different value for ```password``` and ```password_confirmation``` and then expects the user registration to be rejected because of the differing password values.

You'll need to update the new user form.  Can you work out what you should add based on the error message you get from running the above test?

Assuming you can change the form correctly you should now see the following error:

```
Failures:

  1) User signs up when being a new user visiting the site
     Failure/Error: expect { sign_up }.to change(User, :count).by(1)
       expected #count to have changed by 1, but was changed by 0
     # ./spec/features/user_management_spec.rb:9:in `block (2 levels) in <top (required)>'
```

So now our form is working, we just need to implement our functionality:

```ruby
  attr_reader :password
  attr_accessor :password_confirmation

  # this is datamapper's method of validating the model.
  # The model will not be saved unless both password
  # and password_confirmation are the same
  # read more about it in the documentation
  # http://datamapper.org/docs/validations.html
  validates_confirmation_of :password
```

The reason we need the reader for :password and :password_confirmation is that datamapper should have access to both values to make sure they are the same. Note that :password_confirmation is deliberately named differently to :password_digest, ensuring that we are not overwriting the DataMapper methods.

The reason we need the writer for :password_confirmation is that we're now passing the password confirmation to the model in the controller.

```ruby
  post '/users' do
    user = User.create(email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    redirect to('/links')
  end
```

However, you may wonder what happens to :password since we wrote a custom writer for this property.

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

Now the test passes.

Current state is on Github
https://github.com/makersacademy/bookmark_manager/tree/f41a3a2b35451eadd0773e0abbc8e85aba481e90

[ [Next Stage](bookmark_manager_stage_4.md) ]

[ [Return to outline](bookmark_manager.md) ]
