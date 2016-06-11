class Seed::Creator
  attr_reader :seed_class, :final_class

  def initialize(seed_class, final_class)
    @seed_class = seed_class
    @final_class = final_class
  end

  def create
    seed_class.all.each do |seed|
      final_class.create(seed.attributes)
    end
  end
end

