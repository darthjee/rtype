class Seed::Creator
  class Loader
    attr_reader :class_name

    def initialize(class_name)
      @class_name = class_name
    end

    def create
      Seed::Loader.new(seed_class, final_class).create
    end

    private

    def seed_class
      [ Seed, class_name ].map(&:to_s).map(&:camelize).join('::').constantize
    end

    def final_class
      [ Definition, class_name ].map(&:to_s).map(&:camelize).join('::').constantize
    end
  end
end
