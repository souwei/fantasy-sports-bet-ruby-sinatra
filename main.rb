require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'database_config'
require_relative 'models/user'
require_relative 'models/bet'
require_relative 'models/bet_outcome'
require_relative 'models/game'
require_relative 'models/game_result'
enable :sessions

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in? #Should return a boolean
    !!current_user
  end

end


after do
  ActiveRecord::Base.connection.close
end

get '/' do
  erb :index
end

get '/bets' do
  erb :account
end


post '/bets' do
 bet = Bet.new
binding.pry
 bet.user_id = current_user.id
 bet.game_type = "Head to Head"
 bet.game_id = params[:game_id]
 game_bet = Game.all.find_by(id:params[:game_id])
 bet.picked_team = params[:picked_team]
 picked_team = params[:picked_team]

 if picked_team == game_bet.away_team
  bet.pay_rate = game_bet.away_odds
 else
  bet.pay_rate = game_bet.home_odds
 end

 bet.amount = params[:stake_amount].to_d.round(2)
 bet.save
 redirect '/games'
end

get '/games' do
  erb  :games
end

get '/games/:id' do
  erb :newbet
end

post '/session' do
  user = User.find_by(email_address:params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    #incorrect login
    redirect '/'
  end
end


delete '/session' do
  session[:user_id] = nil
  redirect '/'
end
