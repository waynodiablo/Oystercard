# Solution – Implementing Hit Points

[Back to the Challenge](../23_extracting_logic_to_the_model.md)

Our User Story:

```
As Player 1,
So I can start to win a game of Battle,
I want my attack to reduce Player 2's HP
```

Let's write a feature test for that (we can use an existing feature spec file, `attack_spec.rb`):

```ruby
# in spec/features/attack_spec.rb

feature 'Attacking' do
  # 'attack Player 2' scenario omitted

  scenario 'reduce Player 2 HP by 10' do
    sign_in_and_play
    click_button 'Attack'
    click_link 'OK'
    expect(page).not_to have_content 'Mittens: 60HP'
    expect(page).to have_content 'Mittens: 50HP'
  end
end
```

> Why do you think I'm using two `expect` clauses here?

To resolve this, we need to implement:

1) Some way of accessing `Player` instance hit points
2) Some way of attacking `Player` instances
3) Some way of damaging `Player` instances

Since we have a `Player` model, let's move those responsibilities into `Player` for now. Our tests for these things:

```ruby
# in spec/player_spec.rb

describe Player do
  subject(:dave) { Player.new('Dave') }
  subject(:mittens) { Player.new('Mittens') }
 
  describe '#name' do
    it 'returns the name' do
      expect(dave.name).to eq 'Dave'
    end
  end

  describe '#hit_points' do
    it 'returns the hit points' do
      expect(dave.hit_points).to eq described_class::DEFAULT_HIT_POINTS
    end
  end

  describe '#attack' do
    it 'damages the player' do
      expect(mittens).to receive(:receive_damage)
      dave.attack(mittens)
    end
  end

  describe '#receive_damage' do
    it 'reduces the player hit points' do
      expect { dave.receive_damage }.to change { dave.hit_points }.by(-10)
    end
  end
 end
```

> Obviously, you would write these tests one-by-one, and implement the methods in a similar fashion. Hopefully you get the idea of TDDing code by now, so we're moving forward faster!

And our `Player` class with those abilities implemented (and after some refactoring):

```ruby
# in lib/player.rb

 class Player
  DEFAULT_HIT_POINTS = 60
  attr_reader :name, :hit_points

  def initialize(name, hit_points = DEFAULT_HIT_POINTS)
     @name = name
    @hit_points = hit_points
  end

  def attack(player)
    player.receive_damage
  end

  def receive_damage
    @hit_points -= 10
   end
 end 
```

OK. Now we need to make a tiny addition to our controller, inside the `get '/attack'` route:

```ruby
get '/attack' do
  @player_1 = $player_1
  @player_2 = $player_2
  @player_1.attack(@player_2)
  erb :attack
end
```

And update our view to show the results:

```erb
<!-- in views/play.erb -->

<%= @player_1.name %> vs. <%= @player_2.name %>
 
<%= @player_2.name %>: <%= @player_2.hit_points %>HP
```

> We'll also need to update the view that renders our attack confirmation.

Amazing - we implemented a User Story, all virtually without having to touch controller or view code! It's like building Object-Oriented Programs in Ruby again. Which, in a way, is the point of using a Model layer.

Since we're now firmly back in the land of OOD, let's refactor our code so far to take advantage of some OOD principles.

[Forward to the Challenge Map](../00_challenge_map.md)