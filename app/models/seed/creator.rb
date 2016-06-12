class Seed::Creator
  attr_reader :classes

  def initialize(*classes)
    @classes = classes
  end

  def create
    classes.each do |clazz|
      Loader.new(clazz).create
    end
  end
end

