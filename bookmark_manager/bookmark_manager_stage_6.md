### Refactor
Before proceeding, let's refactor our helper methods. Lengthy argument lists such as we have in our #sign_up method are a sign of poor code quality.
* :white_check_mark: Have a look at [this gist](https://gist.github.com/ptolemybarnes/2dfda607b85d01e113b0) with suggestions on how.
* :white_check_mark: You may also want to checkout [factory girl](https://github.com/thoughtbot/factory_girl), a gem for setting up test data. Pill [here](/pills/factory_girl.md).


# Preventing duplicate registrations

Let's write a test first, as usual, checking that we can't register the same user twice.

```ruby
scenario 'I cannot sign up with an existing email' do
  sign_up_as(user)
  expect { sign_up_as(user) }.to change(User, :count).by(0)
  expect(page).to have_content('Email is already taken')
end
```
We need to introduce a unique constraint on our `email` field.  Research DataMapper to find out how.

Now let's improve our controller code. Right now it looks like this.

```ruby
if @user.save
  session[:user_id] = user.id
  redirect to('/links')
else
  flash.now[:notice] = "Password and confirmation password do not match"
  erb :'users/new'
end
```
The problem is that the only error message that this controller can show is the one about passwords not being the same. However, we need to show various error messages and even several messages at the same time if necessary.  Fortunately, DataMapper models include an `errors` method which returns an object with methods like `full_messages` that tell us what went wrong.  `full messages` returns an array of error messages.

```ruby
if @user.save
  session[:user_id] = @user.id
  redirect to('/')
else
  flash.now[:errors] = @user.errors.full_messages
  erb :'users/new'
end
```

Note that we're switching from using flash `:notice` to flash `:errors`. Given that these errors prevent us from proceeding further, it's more appropriate to call them errors.

The `@user.errors` object can also be used to get errors for a given field, and with some clever erb, you can display error messages next to the relevant field in the html.  However, for now, let's just display a list in the flash:

```html
<% if flash[:errors] && !flash[:errors].empty? %>
  Please refer to the following errors below:
  <ul id='errors'>
    <% flash[:errors].each do |error| %>
      <li><%= error %></li>
    <% end %>
  </ul>
<% end %>
```

Note that we'll have to update our password mismatch test since the generated message is slightly different from our earlier custom one.

Now we get a list of errors if the user is trying to both register with the same email and mistypes the password.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1380116432734_Screen%20Shot%202013-09-25%20at%2014.39.55.png "bookmark manager")

We have all the code we need to make our tests pass. (If your tests fail, the chances are the database is in an inconsistent state, see the next section).

[ [Next Stage](bookmark_manager_stage_7.md) ]

[ [Return to outline](bookmark_manager.md) ]
