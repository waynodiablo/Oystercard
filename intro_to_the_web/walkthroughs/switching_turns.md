# Walkthrough – Switching Turns

[Back to the Challenge](../switching_turns.md)

Let's check our User Story:

```
As two Players,
So we can continue our game of Battle,
We want to switch turns
```

As an ultra-minimal implementation, let's get a turn indicator up on screen. This indicator will show whose turn it currently is.

> You might decide to skip this step: the User Story doesn't really require that you implement a visual turn indicator. Or does it?

When writing Capybara feature tests, you shouldn't be testing the 'state' of the model. It might be tempting to do something like this:

```ruby
scenario 'switching turns' do
  sign_in_and_play
  expect($game.current_turn.name).to eq "Dave"
end
```

But that's a bad idea for several reasons: chiefly, that it ties our Model code to the interface layer. Capybara is for browser testing, so that's how we'll use it: like a user would.

> It's also bad code for several other reasons. Pick it to pieces with your pair partner.

Let's write some feature tests using this visual turn indicator:

```ruby
# in spec/features/switch_turns_spec.rb

describe 'Switch turns' do
  context 'seeing the current turn' do
    scenario 'at the start of the game' do
      sign_in_and_play
      expect(page).to have_content "Dave's turn"
    end

    scenario 'after player 1 attacks' do
      sign_in_and_play
      click_button 'Attack'
      click_link 'OK'
      expect(page).not_to have_content "Dave's turn"
      expect(page).to have_content "Mittens's turn"
    end
  end
end
```

We're going to need some way of storing the current turn - let's do that on `Game` for now (we might refactor it out to a separate class and inject it in to `Game` later on):

```ruby
# in spec/game_spec.rb

describe '#current_turn' do
  it 'starts as player 1' do
    expect(game.current_turn).to eq player_1
  end
end
```

Let's start by setting the current turn as a simple instance variable on `Game`:

```ruby
# in lib/game.rb

attr_reader :current_turn

def initialize(player_1, player_2)
  @players = [player_1, player_2]
  @current_turn = player_1
end
```

We can access this new method in our `play.erb` view:

```erb
<!-- in views/play.erb -->

<%= @game.current_turn.name %>'s turn
```

This passes our first test. Now we need a way to switch turns. Let's go back to `game_spec.rb` again:

```ruby
# in spec/game_spec.rb

describe '#switch_turns' do
  it 'switches the turn' do
    game.switch_turns
    expect(game.current_turn).to eq player_2
  end
end
```

Implementing this functionality (with a little refactoring to a private method):

```ruby
# in lib/game.rb

def switch_turns
  @current_turn = opponent_of(current_turn)
end

private

def opponent_of(the_player)
  @players.select { |player| player != the_player }.first
end
```

Now for the actual turn-switching. In our controller:

```ruby
# in app.rb

get '/attack' do
  @game = $game
  @game.attack(@game.player_2)
  @game.switch_turns
  erb :attack
end
```

Let's check our feature tests - everything passes. Nice, we can switch turns! Now let's ensure the other player can join in our game.

[Forward to the Challenge Map](../README.md)
