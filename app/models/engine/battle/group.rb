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
    DamageDistribuitor.new(members, value).apply
  end

  private

  def division_ids
    participants.pluck(:division_id)
  end
end
