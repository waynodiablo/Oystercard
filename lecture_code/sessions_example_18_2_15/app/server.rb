require 'sinatra/base'
require_relative './lib/player'

class SessionsExample < Sinatra::Base

  game = Game.new

  enable :sessions

  get '/' do
    erb :index
  end

  get '/hello' do
    obj_id = session[:me]
    player = game.find_player_by_object_id(obj_id)
    @name = player.name
    puts game.inspect
    puts session.inspect
    erb :index
  end

  post '/new_player' do
    player = Player.new(params[:user_name])
    game.add_player player
    session[:me] = player.object_id
    erb :index
  end

  get '/grid' do
    @seed_data = [[:e, :q, :O], [:q, :O, :O], [:e, :x, :o]]
    erb :grid
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
