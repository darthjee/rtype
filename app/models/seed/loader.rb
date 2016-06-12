class Seed::Loader
  attr_reader :seed_class, :final_class

  def initialize(seed_class, final_class)
    @seed_class = seed_class
    @final_class = final_class
  end

  def create
    seed_class.all.each do |seed|
      Unit.new(seed, final_class).create
    end
  end
end

