* errors image does not match reality

### Refactor
Before proceeding, let's refactor our helper methods. Lengthy argument lists such as we have in our #sign_up method are a sign of poor code quality. Have a look at [this gist](https://gist.github.com/ptolemybarnes/2dfda607b85d01e113b0) with suggestions on how.

### Preventing duplicate registrations


Let's write a test first, as usual, checking that we can't register the same user twice.

```ruby
scenario 'with an email that is already registered' do
  expect { sign_up_as }.to change(User, :count).by(1)
  expect { sign_up_as }.to change(User, :count).by(0)
  expect(page).to have_content('This email is already taken')
end
```

We need to do two things. Firstly, we need to put constrains on the email field.

```ruby
property :email, String, unique: true, message: 'This email is already taken'
```

We're setting the error message datamapper is going to return explicitely even though a very similar message would be used by default if we didn't specify it.

Secondly, we need to refactor our controller code. Right now it looks like this.

```ruby
if @user.save
  session[:user_id] = @user.id
  redirect to('/')
else
  flash[:notice] = 'Sorry, your passwords do not match'
  erb :'users/new'
end
```

The problem is that the only error message that this controller can show is the one about passwords not being the same. However, we need to show various error messages and even several messages at the same time, if necessary. Let's take the list of messages from datamapper.

```ruby
if @user.save
  session[:user_id] = @user.id
  redirect to('/')
else
  flash.now[:errors] = @user.errors.full_messages
  erb :'users/new'
end
```

Note that we're switching to using flash[:errors] instead of flash[:notice]. Given that these errors prevent us from proceeding further, it's more appropriate to call them errors.

We're also using flash.now instead of just flash. By default, a flash message is available for both the current request and the next request. This is very convenient if we're doing a redirect. However, since we are just re-rendering the page, we just want to show the flash for the current request, not for the next one. If we use flash[:errors], then after the user fixes the mistakes, we'll be redirected to the homepage where we'll see our message again.

The @user.errors object contains all validation errors. It can be used to get errors for a given field (if you want to display the error next to a specific field). The full_messages method just returns an array of all errors as strings. Let's display them in our layout file.

```html
<% if flash[:errors] && !flash[:errors].empty? %>
  Sorry, there were the following problems with the form.
  <ul id='errors'>
    <% flash[:errors].each do |error| %>
      <li><%= error %></li>
    <% end %>
  </ul>
<% end %>
```

Note that we'll also have to update our password mismatch test since the automated message generated is slightly different from our earlier custom one.

Now we get a list of errors if the user is trying to both register with the same email and mistypes the password.

![alt text](https://dchtm6r471mui.cloudfront.net/hackpad.com_jubMxdBrjni_p.52567_1380116432734_Screen%20Shot%202013-09-25%20at%2014.39.55.png "bookmark manager")

We have all the code we need to make our tests pass. (If your tests fail, the chances are the database is in an inconsistent state, see the next section).

Current state is on Github
https://github.com/makersacademy/bookmark_manager/tree/44a6f6d79ab74d5da01487c14ac5929349e74651

[ [Next Stage](bookmark_manager_stage_7.md) ]

[ [Return to outline](bookmark_manager.md) ]
