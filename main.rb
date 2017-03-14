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

get '/games' do
  erb  :games
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
