class Definition::Unit < ActiveRecord::Base
  belongs_to :race
  belongs_to :unit_class
end
