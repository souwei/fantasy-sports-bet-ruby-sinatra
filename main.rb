require 'sinatra'
require 'httparty'
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

  def logged_in?
    !!current_user
  end

end


after do
  ActiveRecord::Base.connection.close
end

get '/' do
  @foxnews_articles = HTTParty.get("https://newsapi.org/v1/articles?source=fox-sports&sortBy=top&apiKey=5a930224a8c94611abcea95b01e7cab7")
  erb :index
end

get '/bets' do
  erb :account
end

get '/bets/:id/delete' do
  @bet = Bet.all.find_by(id:params[:id].to_i)
  erb :delete_confirm
end

delete '/bets/:id/delete' do
  if Bet.find_by(id:params[:id].to_i)
    Bet.find_by(id:params[:id].to_i).delete
    @message = "Successful Deletion"
    redirect '/bets'
  else
    @message = "Unsuccesul Deletion"
    redirect '/bets'
  end
end

post '/bets' do
 bet = Bet.new

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

 bet.amount = params[:stake_amount]
 bet.save
 redirect '/bets'
end

get '/bets/edit/:id' do
  erb :editbet
end

put '/bets/edit/:id' do
  bet = Bet.all.find_by(id:params[:bet_id].to_i)
  game = Game.all.find_by(id:bet.game_id)
  bet.amount = params[:stake_amount].to_d

  if bet.picked_team != params[:picked_team]
    if params[:picked_team] == game.home_team
      bet.picked_team = game.home_team
      bet.pay_rate = game.home_odds
    else
      bet.picked_team = game.away_team
      bet.pay_rate = game.away_odds
    end
  end
  bet.save


  redirect '/bets'
end

get '/games' do
  erb  :games
end

get '/games/:id' do
  if !logged_in?
    erb :newuser
  else
  erb :newbet
  end
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

get '/user/new' do
  if logged_in?
    redirect '/'
  else
  erb :newuser
  end
end

post '/user/new' do
  new_user = User.new
  new_user.email_address = params[:email]
  new_user.password = params[:password]
  if new_user.save
    @email = params[:email]
    @message = "Registration was Successful!"
    erb :user_register_success
  else
    @message = "Registration Unsuccessful, Please register again."
    erb :user_register_success
  end
end

get '/user/edit' do
  erb :user_edit
end
