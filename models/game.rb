class Game <
  ActiveRecord:: Base
  has_many :bets
  has_one :game_result
end
