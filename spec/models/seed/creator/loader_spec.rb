require 'rails_helper'

RSpec.describe Seed::Creator::Loader do
  it_behaves_like 'a class seed loader', :race, Seed::Race, Definition::Race
  it_behaves_like 'a class seed loader', :unit_class, Seed::UnitClass, Definition::UnitClass
  it_behaves_like 'a class seed loader', :unit, Seed::Unit, Definition::Unit
end

