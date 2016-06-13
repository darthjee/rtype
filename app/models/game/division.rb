class Game::Division < ActiveRecord::Base
  belongs_to :plannet
  has_many :squadrons
end
