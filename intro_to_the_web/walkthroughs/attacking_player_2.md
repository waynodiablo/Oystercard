# Walkthrough – Entering Players

[Back to the Challenge](../attacking_player_2.md)

Our User Story:

```
As Player 1,
So I can win a game of Battle,
I want to attack Player 2, and I want to get a confirmation
```

> You might start to ask some questions at this point. Do we want to see this confirmation on a new page? On the same page? What should the confirmation look like? These questions don't matter right now. Our feature test should simply require the user to see a message when they take a set of actions. It's up to our future selves how we solve that.

Let's create a new feature test:

```ruby
# in spec/features/attack_spec.rb

feature 'Attacking' do
  scenario 'attack Player 2' do
    sign_in_and_play
    click_link 'Attack'
    expect(page).to have_content 'Dave attacked Mittens'
  end
end
```

There are many routes we could take to solve this. Personally, I felt you should show this attack confirmation on a new page. You might disagree, and that's absolutely fine: so long as we pass the feature test, our preferences are a matter of taste.

Let's create a view that contains the expected text:

```erb
<!-- in views/attack.erb -->

<%= @player_1_name %> attacked <%= @player_2_name %>
```

Now we need a route to serve that. Let's implement that in `app.rb`:

```ruby
# in app.rb

get '/attack' do
  @player_1_name = session[:player_1_name]
  @player_2_name = session[:player_2_name]
  erb :attack
end
```

> I'm using a GET request with the `/attack` path because I'm not changing the state of the program.

To link the result of the `get '/play'` route with this new route, we need some way to communicate. I used a link in the view:

```erb
<!-- in play.erb -->

<a href="/attack">Attack</a>
```

But you could just as well use a `form` element (so long as I changed my feature test to use `click_button` instead of `click_link`):

```erb
<!-- alternative play.erb -->
<form action="/attack">
  <input type="submit" value="Attack">
</form>
```

Let's run `rspec` - everything passes. On to the next User Story!

[Forward to the Challenge Map](../README.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/intro_to_the_web/walkthroughs/attacking_player_2.md)
