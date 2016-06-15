class Game::Battle::Participant < ActiveRecord::Base
  belongs_to :event
  belongs_to :division
end
