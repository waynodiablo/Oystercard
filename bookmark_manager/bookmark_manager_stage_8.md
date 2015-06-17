### Forgotten password

If a user forgets the password, we cannot just send it by email for two reasons. Firstly, we don't know the password: we only have the digest. Secondly, that would be insecure because the password would likely be stored in the email archive. If the email archive is compromised, then the attacker would know the password.

Instead of sending the password, we need to send a one-time password recovery token. It's a long random string that can be used only once and only for a limited time to change the password. Let's start with a test:

```ruby
feature 'Password reset' do

 scenario 'requesting a password reset' do
   user = User.create(email: 'test@test.com', password: 'secret1234',
                      password_confirmation: 'secret1234')
   visit '/password_reset'
   fill_in 'Email', with: user.email
   click_button 'Reset password'
   user = User.first(email: user.email)
   expect(user.password_token).not_to be_nil
   expect(page).to have_content 'Check your emails'
 end
end
```

* Let your tests drive you to the point where user.password_token is expected to not be nil - you will need to add `property :password_token, Text` to your user class.
* Find the record of the user that's recovering the password.
* Generate a long, random password recovery token and save it as part of the user record, together with a timestamp.

```ruby
user = User.first(email: email)
# avoid having to memorise ascii codes
user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
user.save
```

* Create a route to reset the password: get "/reset_password/:token"
* Send an email (we'll cover this later) with a link containing this token to the user. For now let's imagine the email is sent and the user has clicked the link.
* When the link is clicked, find the user that has this token in the database. We'll test this as follows:

```ruby
scenario 'resetting password' do
   user = User.first
   user.password_token = 'token'
   user.save

   visit "/users/password_reset/#{user.password_token}"
   expect(page.status_code).to eq 200
   expect(page).to have_content 'Enter a new password'
 end
```
* Make a new form that passes the above test.
* Write a test that drives you to amend the users password. Remember to test that your password token is valid, and reset the password token to nil once the password is changed.

```ruby
user = User.first(password_token: token)
```
* Optional extra:

  - Add a timestamp when you create the password_token, by setting `user.password_token_timestamp = Time.now`. To unit test this, you will need to stub the time - you could do this yourself, or have a look at timecop gem.
  - Check that the token was issued recently (a hour, maybe, or less) and if so, allow the user to set a new password (this will require a new form and a new route to handle it. The token must be a hidden field on the form and it must be checked again after submission. Finally, after the new password is set, remove the token from the database, so that it couldn't be used again.

### Sending the email

To send an email, you will need an external SMTP server. There are several companies providing these services: Mailgun and Sendgrid are among the most popular. They are also available as add-ons on Heroku (the cloud hosting service), making the integration into your application trivial. Let's consider how we could use Mailgun to send emails.

As always, we start with a test. In this case we already have a test for the password reset feature. As feature tests are expensive, let's add an expectation to the test 'requesting a password reset':

```ruby
  expect(SendResetEmail).to receive(:call)
```

We would not normally stub out a feature test - rather, we would want to catch the email, but that is beyond the scope of this tutorial. For now, we have a failing test, so let's get this working. Create a SendEmailClass in `./lib` directory.

Follow the error messages until they are green (basically until we have an empty #call class method). You will need to call SendResetEmail.call(user) from your controller.

Now we need to write some unit tests for the email functionality:

```ruby

require './lib/send_reset_email'

describe SendResetEmail do

 let(:user)   { double :user   }
 let(:client) { double :client }
 subject { SendResetEmail.new(user: user, client: client) }

 it 'passes a message to an email client' do
   expect(client).to receive :send_message
   subject.call(user)
 end
end
```



## Exercises

Once you have completed the walkthrough you should be able to do all of the following (in no particular order).

* Show the list of available tags on the homepage
* Move the form to add a link to its own route
* Add user_id to tags and links. Display who the link was submitted by. Same for a tag
* Allow the user to add a link to favourites (this will be a many-to-many relationship)
* Display how many users favourited the link
* Create a user profile page that will show the links they submitted, tags they created and their favourites.
* Display the link to the user's profile at the top of the page if the user is logged in
* Implement forgotten password functionality
* Redirect the user with a flash message if a logged in user tries to sign up or sign in
* Send a welcome email when the user signs up
* Create validations for all models:
* email must have the correct format (see an example in Datamapper Validations)
* email and password must be present
* link must have a title and a url
* tag must have some text
* Add a description property to the link.
* Add a username to the User model, so that username instead of an email was shown next to the link.

[ [Next Stage](bookmark_manager_style.md) ]

[ [Return to outline](bookmark_manager.md) ]
