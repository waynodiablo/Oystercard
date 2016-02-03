# Walkthrough – Losing and Winning

[Back to the Challenge](../29_losing_and_winning.md)

Let's check our User Story:

```
As a Player,
So I can Lose a game of Battle,
I want to see a 'Lose' message if I reach 0HP first
```

This looks pretty trivial, but involves some legwork. [Here's my commit](https://github.com/sjmog/battle/commit/70e1928bc2616b2b04ec1722dde1a35ad745fe4b), if you're interested in seeing the result.

First, we need a feature test (of course):

```ruby
# in spec/features/game_over_spec.rb

feature 'Game over' do
  context 'when Player 1 reaches 0 HP first' do
    before do
      sign_in_and_play
      attack_and_confirm
      allow(Kernel).to receive(:rand).and_return(60)
    end

    scenario 'Player 1 loses' do
      click_button 'Attack'
      expect(page).to have_content 'Dave loses!'
    end
  end
end 
```

Because I was attacking so much, I defined an `attack_and_confirm` method in the `web_helpers.rb` file:

```ruby
# in spec/web_helpers.rb

def attack_and_confirm
  click_button 'Attack'
  click_button 'OK'
end 
```

With this feature test, I recognised that I needed some changes to my `Game` class. Here are the tests for those things:

```diff
# in spec/game_spec.rb

 describe Game do
   subject(:game) { described_class.new(player_1, player_2) }
-  let(:player_1) { double :player }
-  let(:player_2) { double :player }
+  subject(:finished_game) { described_class.new(dead_player, player_2) }
+  let(:player_1) { double :player, hit_points: 60 }
+  let(:player_2) { double :player, hit_points: 60 }
+  let(:dead_player) { double :player, hit_points: 0 }
 
   describe '#player_1' do
     it 'retrieves the first player' do
 @@ -36,4 +38,20 @@
       expect(game.opponent_of(player_2)).to eq player_1
     end
   end
+
+  describe '#game_over?' do
+    it 'returns false if no-one is at 0HP' do
+      expect(game.game_over?).to be false
+    end
+
+    it 'returns true if at least one player is at 0HP' do
+      expect(finished_game.game_over?).to be true
+    end
+  end
+
+  describe '#loser' do
+    it 'returns a player on less than 0HP' do
+      expect(finished_game.loser).to eq dead_player
+    end
+  end
 end 
```

And the implementation:

```ruby
# in lib/game.rb

class Game
  attr_reader :current_turn
  def initialize(player_1, player_2)
    @players = [player_1, player_2]
    @current_turn = player_1
  end

  def player_1
    players.first
  end

  def player_2
    players.last
  end

  def switch_turns
    @current_turn = opponent_of(current_turn)
  end

  def opponent_of(player)
    players_who_are_not(player).first
  end

  def game_over?
    losing_players.any?
  end

  def loser
    losing_players.first
  end

  private
  attr_reader :players

  def losing_players
    players.select { |player| player.hit_points <= 0 }
  end

  def players_who_are_not(the_player)
    players.select { |player| player != the_player }
  end
end
```

I then refactored the 'Attack' button to use a more robust POST method (I also updated the method on the form in `play.erb`:

```diff
# in app.rb

+  post '/attack' do
+    Attack.run($game.opponent_of($game.current_turn))
+    if $game.game_over?
+      redirect '/game-over'
+    else
+      redirect '/attack'
+    end
+  end
+
   get '/attack' do
     @game = $game
-    Attack.run(@game.opponent_of(@game.current_turn))
     erb :attack
   end
```

> Notice that I also changed the arguments of `Attack` to use `$game` instead of `@game`. I did this because I don't worry about setting instance variables in POST requests: they should never render views, so instance variables just aren't needed.

Adding a `get '/game-over'` route to `app.rb`:

```ruby
get '/game-over' do
  @game = $game
  erb :game_over
end
```

And creating a `game_over.erb` view file with a losing message:

```erb
<!-- in views/game_over.erb -->

<%= @game.loser.name %> loses! 
```

Everything passes, and we're done! Now let's move on to some extension exercises.

[Forward to the Challenge Map](../00_challenge_map.md)