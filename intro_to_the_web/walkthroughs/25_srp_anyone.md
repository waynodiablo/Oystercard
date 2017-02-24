# Walkthrough – Single Responsibility Principle, anyone?

[Back to the Challenge](../25_srp_anyone.md)

Let's extract the responsibility for attacking players from the `Player` class into a `Game` class.

We can essentially copy-paste the test for `#attack` from `player_spec.rb` into a `game_spec.rb`:

```ruby
# in spec/game_spec.rb

describe Game do
  subject(:game) { described_class.new }
  let(:player_1) { double :player }
  let(:player_2) { double :player }

  describe '#attack' do
    it 'damages the player' do
      expect(player_2).to receive(:receive_damage)
      game.attack(player_2)
    end
  end
end 
```

Let's make a class that solves our failure:

```ruby
# in lib/game.rb

class Game
  def attack(player)
    player.receive_damage
  end
end 
```

Finally, we need to change up our controller route to use our new `Game.new.attack(player)` instead of asking player to do the job:

```diff
# in app.rb

get '/attack' do
    @player_1 = $player_1
    @player_2 = $player_2
-   @player_1.attack(@player_2)
+   Game.new.attack(@player_2)
    erb :attack
end
```

Our `Player` class has one less responsibility. Great! Now let's minimise those pesky global variables using our new `Game` class.

[Forward to the Challenge Map](../README.md)
