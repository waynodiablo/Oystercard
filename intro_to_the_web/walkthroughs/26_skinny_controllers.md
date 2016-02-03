# Walkthrough – Skinny Controllers

[Back to the Challenge](../26_skinny_controllers.md)

We want to make our controllers skinnier. Let's access our `Player` instances through `Game` to help us do that. First, we need `Game` to accept two `Player` instances at instantiation (in other words, we'd like to be able to do `Game.new(player_1, player_2)`). So, let's update our tests (and make sure we can access those players from `Game`'s public interface):

```ruby
# in spec/game_spec.rb

describe Game do
  subject(:game) { described_class.new(player_1, player_2) }
   let(:player_1) { double :player }
   let(:player_2) { double :player }
 
  describe '#player_1' do
    it 'retrieves the first player' do
      expect(game.player_1).to eq player_1
    end
  end

  describe '#player_2' do
    it 'retrieves the second player' do
      expect(game.player_2).to eq player_2
    end
  end
  
  # other tests omitted for brevity
```

To make that pass, let's update `Game` itself:

```ruby
# in lib/game.rb

class Game
  def initialize(player_1, player_2)
    @players = [player_1, player_2]
  end

  def player_1
    @players.first
  end

  def player_2
    @players.last
  end

  # other methods omitted for brevity
```

Now we can tidy up our controller:

```diff
# in app.rb

 require 'sinatra/base'
+require './lib/game'
+require './lib/player'
 
 class Battle < Sinatra::Base
   enable :sessions
 
   post '/names' do
-    $game = Game.new
-    $player_1 = Player.new(params[:player_1_name])
-    $player_2 = Player.new(params[:player_2_name])
+    player_1 = Player.new(params[:player_1_name])
+    player_2 = Player.new(params[:player_2_name])
+    $game = Game.new(player_1, player_2)
     redirect '/play'
   end
 
   get '/play' do
-    @player_1 = $player_1
-    @player_2 = $player_2
+    @game = $game
     erb :play
   end
 
   get '/attack' do
-    @player_1 = $player_1
-    @player_2 = $player_2
-    $game.attack(@player_2)
+    @game = $game
+    @game.attack(@game.player_2)
     erb :attack
   end
```

And finally, our `attack.erb` view:

```diff
<!-- in views/attack.erb -->
-<%= @player_1.name %> attacked <%= @player_2.name %>
+<%= @game.player_1.name %> attacked <%= @game.player_2.name %>
 
<a href="/play">OK</a> 
```

And the `play.erb` view:

```diff
<!-- in views/play.erb -->

-<%= @player_1.name %> vs. <%= @player_2.name %>
+<%= @game.player_1.name %> vs. <%= @game.player_2.name %>
 
-<%= @player_2.name %>: <%= @player_2.hit_points %>HP
+<%= @game.player_2.name %>: <%= @game.player_2.hit_points %>HP
```

> I'm not happy about the violation of the [Law of Demeter](http://devblog.avdi.org/2011/07/05/demeter-its-not-just-a-good-idea-its-the-law/) when we call `@game.player.name`. We could open the public interface of `Game` further to add a `#player_1_name` method in addition to `#player_1`, or we could include the `Forwardable` module in the `Game` class. It's up to you if you live with this code smell :poo:, or you try to eliminate it.

OK, our controller is much skinnier now! Refactoring complexity into the model is hugely advantageous. You'll see that we can now implement many User Stories in rapid succession without worrying too much about controller difficulties. Let's move on!

[Forward to the Challenge Map](../00_challenge_map.md)