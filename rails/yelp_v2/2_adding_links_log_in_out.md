#### Adding links to log in and out

So we've got routes that let our users sign-in/-out/-up, but they have no way of getting to them. Time to update our view logic!

As always, let's test first. **There's no real need to test Devise's internals** – the user model and so on – because we can probably assume that they work pretty well. Instead, let's write a feature test.

`spec/features/users_feature_spec.rb`:

```ruby
require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
end
```

Now we need to add these links to the view logic. Specifically, we need to tell the app to show certain links dependent on whether or not a user is logged in. We can use Devise's built-in `user_signed_in?` helper to do this.

In `views/layouts/application.(erb/haml)`, add a sign out link:

```erb
<% if user_signed_in? %>
  <%= link_to "Sign out", destroy_user_session_path, method: :delete %>
...
```

```haml
- if user_signed_in?
  = link_to "Sign out", destroy_user_session_path, method: :delete
...
```

And now we need sign in and sign up links, so add this to the above:

```erb
...
<% else %>
  <%= link_to "Sign in", new_user_session_path %>
  <%= link_to "Sign up", new_user_registration_path %>
<% end %>
```

```haml
...
- else
  = link_to "Sign in", new_user_session_path
  = link_to "Sign up", new_user_registration_path
```

And now we should be green. A good time to  commit our latest code to git, and switch Driver/Navigator Roles&nbsp;:twisted_rightwards_arrows:.
