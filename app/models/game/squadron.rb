class Game::Squadron < ActiveRecord::Base
  belongs_to :division
  belongs_to :unit, class_name: Definition::Unit

  def apply_damage(value)
    update(damage: damage + value)
  end
end
