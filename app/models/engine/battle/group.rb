class Engine::Battle::Group
  attr_reader :participants, :unit
  delegate :armor, :dexterity, :attacks, :power, :precision, to: :unit
  delegate :size, to: :members

  def initialize(participants, unit)
    @participants = participants
    @unit = unit
  end

  def members
    Game::Squadron.where(division_id: division_ids, unit: unit)
  end

  def quantity
    members.sum(:quantity)
  end

  def damage(value)
    applied = []

    members.each do |member|
      dam = value * member.quantity / quantity
      applied << dam
      member.apply_damage(dam)
    end

    lasting = value - applied.sum
    array = members.to_a
    while lasting > 0 && array.present? do
      squadron = array.random!
      dam = (lasting * squadron.quantity * 1.0 / quantity).ceil
      squadron.apply_damage(dam)
      lasting -= dam
    end
  end

  private

  def division_ids
    participants.pluck(:division_id)
  end
end
