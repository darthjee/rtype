class Game::Battle::Participant < ActiveRecord::Base
  scope :attackers, -> { where(role: :attacker) }
  scope :defenders, -> { where(role: :defender) }

  belongs_to :event
  belongs_to :division
end
