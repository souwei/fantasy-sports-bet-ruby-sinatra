require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'fantasy_sports_bet'
}

ActiveRecord::Base.establish_connection(options)
