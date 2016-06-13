class Game::Squadron < ActiveRecord::Base
  belongs_to :division
  belongs_to :unit, class_name: Definition::Unit
end
