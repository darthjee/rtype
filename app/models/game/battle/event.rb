class Game::Battle::Event < ActiveRecord::Base
  has_many :participants

  delegate :attackers, to: :participants
  delegate :defenders, to: :participants
end
