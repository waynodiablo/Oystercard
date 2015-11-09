# Spec Helper Methods

What is the problem with a helper method like the following?

```ruby
  def sign_in(email, password)
    visit '/sessions/new'
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign in'
  end
```

- It relies on you remembering the order of arguments.
- It relies on a model existing in the database with the same email / password values that you give it.
- It relies on you not making a typo when you pass that email and password string.

So many things could go wrong! Even worse, what happens if you decide to add some validations such that passwords have to have at least one number? Unless you'd already formatted your examples like that, you'd have to find every call to the `#sign_in` method and correct that password string. So how can we improve on this? Like so:

```ruby
  def sign_in_as(user)
    visit '/sessions/new'
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button 'Sign in'
  end
```
Nice! This means that all we have to remember to do is pass in a user model that presumably exists in the db. We don't have to remember an order of arguments. We're not at risk of opaque errors from having incorrectly typed a password string. So we'd call such a method like:

```ruby
it 'displays a welcome message on sign-in' do
  user = User.first # assuming we have created a user in our setup. Wouldn't it be cool if we could do `create :user`? Hmmm...*

  sign_in_as(user)

  expect(page).to have_content "Welcome, #{user.email}!"
end
```

What about a method like the following?

```ruby
def sign_up(username = 'Big G',
              name = 'Andy Gout',
              email = 'example@test.com',
              password = 'P0tat0M0nkey123!',
              password_confirmation = 'P0tat0M0nkey123!')
    visit '/users/new'

    fill_in :username, with: username
    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end
```

Ouch >_< There are so many ways this could go wrong. Refactor like so:

```ruby
def sign_up_as(user)
    visit '/users/new'

    fill_in :username, with: user.username
    fill_in :name,     with: user.name
    fill_in :email,    with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end
```

But wait, how can we can supply an instance of user with details for a user that hasn't signed up yet? Surely the whole point of a sign up method is that you pass it details that are not yet in the DB. True, but recall that `User.new` would create a model without saving it in the DB. So we could call the above method in the following way:

```ruby
it 'displays a welcome message on sign up' do
  user = User.new(user_params) # Wouldn't it be cool if we could do "build :user"?.*

  sign_up_as(user)

  expect(page).to have_content "Welcome to Chitter, #{user.email}!"
end
```

> Above I'm suggesting another helper method, "user_params", that would allow you to keep the knowledge of what values are needed to create a user in one place. If only there were some nice gem for doing this... <notextile>*</notextile>

<notextile>*</notextile>https://github.com/thoughtbot/factory_girl
