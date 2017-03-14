class Bet <
  ActiveRecord:: Base
  belongs_to :game
  has_one :bet_outcome
end
