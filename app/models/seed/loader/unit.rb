class Seed::Loader::Unit
  attr_reader :seed, :final_class
  delegate :attributes, :id, to: :seed

  def initialize(seed, final_class)
    @seed = seed
    @final_class = final_class
  end

  def create
    unit.update(attributes)
  end

  def unit
    @unit ||= fetch_unit
  end

  def fetch_unit
    final_class.find_by(id: id) || final_class.create(id: id)
  end
end

