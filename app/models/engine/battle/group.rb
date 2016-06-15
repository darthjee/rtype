class Engine::Battle::Group
  attr_reader :participants, :unit

  def initialize(participants, unit)
    @participants = participants
    @unit = unit
  end

  def members
    Game::Squadron.where(division_id: division_ids, unit: unit)
  end

  private

  def division_ids
    participants.pluck(:division_id)
  end
end
