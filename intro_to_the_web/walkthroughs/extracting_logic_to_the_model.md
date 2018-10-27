# Walkthrough – Extracting Logic to the Model

[Back to the Challenge](../extracting_logic_to_the_model.md)

Our User Story:

```
As Player 1,
So I can start to win a game of Battle,
I want my attack to reduce Player 2's HP
```

Before we implement this User Story, let's get ready to deal with complexity like Hit Points, and reducing them.

Our controller is starting to grow, and we could refactor our code to **separate our concerns**. Let's extract a `Player` class from our code and pass some responsibilities - currently belonging to the `session` - to this class instead.

We can begin by creating a new spec file for the `Player` class, such that it can return its own name. This will extract the behaviour of the `session[:player_1_name]` and `session[:player_2_name]` to a 'deeper' part of our program. **Abstraction is a good thing to aim for in program design.**

Let's create a `lib` file to store our model layer. Our project directory will look something like this:

```
.
└── battle
    ├── lib
    ├── spec
    │   ├── features
    │   │   ├── enter_names_spec.rb
    │   │   ├── hit_points_spec.rb
    │   │   └── web_helpers.rb
    │   └── spec_helper.rb
    ├── .rspec
    ├── Gemfile
    ├── Gemfile.lock
    ├── app.rb
    └── config.ru
```

Now, let's implement a `Player` class that responds to `#name` in a Test-First manner. Our spec file:

```ruby
# in spec/player_spec.rb

require 'player'

describe Player do
  subject(:dave) { Player.new('Dave') }

  describe '#name' do
    it 'returns the name' do
      expect(dave.name).to eq 'Dave'
    end
  end
end
```

This fails: great. Let's add a simple class file to solve our failing test:

```ruby
# in lib/player.rb

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
```

Now we need to look at our controller file `app.rb` and replace cases where we are using the `session` with cases where we could use a `Player` instance.

> You should use the `session` as far as possible. Only when it becomes untenable (i.e. too many large things, or complex objects) should you refactor to the Model layer. In this case, we are pre-emptively refactoring to avoid running into problems when we try to introduce Hit Points (which you might guess now should probably be a method `#hit_points` on instances of the `Player` class).

Let's update our controller, using global variables to replace the session.

**If you haven't picked this up by now, use of global variables is pretty much Ruby blasphemy, because they can easily crash your program. Since we don't know much about databases, we're allowing this horrible sin in exchange for simplified learning. But don't use them outside of this week. Please.**

> Why not try setting and resetting a global variable 600,000 times from the command line? Save your current code first.

In our controller:

```ruby
# in app.rb

post '/names' do
  $player_1 = Player.new(params[:player_1_name])
  $player_2 = Player.new(params[:player_2_name])
  redirect '/play'
end

get '/play' do
  @player_1_name = $player_1.name
  @player_2_name = $player_2.name
  erb :play
end

get '/attack' do
  @player_1_name = $player_1.name
  @player_2_name = $player_2.name
  erb :attack
end
```

OK! We've extracted a bunch of logic into our Model layer. Now, let's implement the hit points functionality from the User Story we're trying to solve.

[Forward to the Challenge Map](../README.md)


![Tracking pixel](https://githubanalytics.herokuapp.com/course/intro_to_the_web/walkthroughs/extracting_logic_to_the_model.md)
