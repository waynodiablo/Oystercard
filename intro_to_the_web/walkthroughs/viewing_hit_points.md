# Walkthrough – Viewing hit points

[Back to the Challenge](../viewing_hit_points.md)

Let's consider our User Story:

```
As Player 1,
So I can see how close I am to winning
I want to see Player 2's Hit Points
```

For a user to do this, they would have to:

- Visit the home page ('/')
- Fill in a text field with a name
- Fill in a second text field with a name
- Click a Submit button

They would expect to see (assuming 60 hit points):

- A page containing the words '(name two): 60HP'

So, a feature test for this:

```ruby
# in spec/features/hit_points_spec.rb

feature 'View hit points' do
  scenario 'see Player 2 hit points' do
    visit('/')
    fill_in :player_1_name, with: 'Dave'
    fill_in :player_2_name, with: 'Mittens'
    click_button 'Submit'
    expect(page).to have_content 'Mittens: 60HP'
  end
end
```

Running `rspec`, our error essentially says 'Where are my hit points!? I don't see any!'. We can solve that very simply. In our `play.erb` view:

```erb
<!-- in views/play.erb -->
<%= @player_1_name %> vs. <%= @player_2_name %>

<%= @player_2_name %>: 60HP
```

Ta-da! Our test passes. But our tests are starting to duplicate the same user actions again and again: visiting the home page, entering names, and signing in. In the next challenge, we will DRY up our tests using a **helper**.

[Forward to the Challenge Map](../README.md)
