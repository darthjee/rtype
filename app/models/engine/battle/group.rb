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
    avarage = (value * 1.0 / size).to_i
    members.each do |member|
      member.apply_damage(avarage)
    end

    lasting = value - avarage*size
    array = members.to_a
    while lasting > 0 do
      array.random!.apply_damage(1)
      lasting -= 1
    end
  end

  private

  def division_ids
    participants.pluck(:division_id)
  end
end
