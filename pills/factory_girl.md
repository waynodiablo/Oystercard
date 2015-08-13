# FactoryGirl

[FactoryGirl](https://github.com/thoughtbot/factory_girl) is a 2006 film starring Sienna Miller and an amazing gem maintained by [Thoughtbot](thoughtbot.com) for setting up test data.

[Recall](https://robots.thoughtbot.com/four-phase-test) that there are 4 stages of a test: **setup**, exercise, verify, and teardown. FactoryGirl is all about refactoring the first stage, **setup**, and doesn't have much to do with the others. So let's look at some examples of test setups that are in need of some re-factory girl treatment:

```ruby
describe 'User management' do

  scenario 'User log in' do
    user = User.create(email: 'foo@bar.com', username: 'foobar_user',
                    password: 'secret1234', password_confirmation: 'secret1234')

    sign_in_as(user)

    expect(page).to have_content "Welcome, #{user.email}!"
  end

  scenario 'User logs out' do
    user = User.create(email: 'foo@bar.com', username: 'foobar_user',
                    password: 'secret1234', password_confirmation: 'secret1234')

    sign_in_as(user)
    sign_out

    expect(page).to have_content "Goodbye, #{user.email}!"
  end

end
```

This is a pretty typical looking spec: we're creating some rows in the "User" table in the database, presumably running some capybara via two helper methods (sign_in_as, sign_out), and expecting relevant messages to be displayed. There are some possible refactors we could immediately implement.

But imagine that as we go forward, this **setup** pattern emerges across multiple files, multiple tests. That unspooled "knowledge" about what attributes a user should have becomes a massive liability. We might, for example, decide that usernames containing underscores are invalid. In that situation, we'd have to comb through our tests, adjusting every underscore'd username. FactoryGirl allows you to keep that knowledge in a single place, called a factory, and whittle our code down to something like the following:

```ruby
describe 'User management' do

  scenario 'User log in' do
    user = create :user

    sign_in_as(user)

    expect(page).to have_content "Welcome, #{user.email}!"
  end

  scenario 'User logs out' do
    user = create :user

    sign_in_as(user)
    sign_out

    expect(page).to have_content "Goodbye, #{user.email}!"
  end

end
```

Let's see how!
* Firstly, add [FactoryGirl](https://github.com/thoughtbot/factory_girl) to the test group of your Gemfile.
* Configure RSpec, in `spec_helper.rb` to include FactoryGirl's DSL:
```ruby
RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods
end
```
* Define your factory. FactoryGirl will look for factories within a `factories` folder within `spec`. The files themselves should be named after the model they contain factories for. For example:  

```ruby
# ./spec/factories/user.rb

FactoryGirl.define do

  factory :user do # FactoryGirl will assume that the parent model of a factory named ":user" is "User".
    email 'foo@bar.com'
    username 'foobar_user'
    password 'secret1234'
    password_confirmation 'secret1234'
  end

end
```
Let's be clear: we're not *defining* the headings of the columns in the User table. That's done within the User class or elsewhere, depending on your ORM. (That said, you can drive the creation of a model by first defining its factory).

What we're actually doing is setting the values of a default user, so that `create :user` will generate a model and corresponding row in the database containing those values.

It's straightforward to override the set defaults. Imagine we need two users with different email and usernames:

```ruby
  scenario 'A user sends a message to another user' do
    # SETUP
    sender   = create :user
    receiver = create(:user, email: 'receiver@email.com', username: 'receiver_user')

    # EXERCISE
    sender.communicate(message: "HI!", to: receiver)
    sign_in_as(receiver)

    # VERIFY
    expect(page).to have_content "HI!"
  end
  # TEARDOWN (handled by DatabaseCleaner)
```
FactoryGirl gives us a lot of options. It allows you to generate models without saving them in the database (`build :user`), grab the attributes for a model as a hash (`attributes_for :user`), get a model with methods stubbed out (`build_stubbed :user`), define associations, and so on.

Check out the [docs](http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md) for getting the most out of FactoryGirl.  

*(by Ptolemy, comments/questions about this pill to: ptolemy@makersacademy.com)*
