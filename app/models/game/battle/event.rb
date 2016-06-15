class Game::Battle::Event < ActiveRecord::Base
  has_many :participants
end
