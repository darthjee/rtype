require 'rails_helper'

RSpec.describe Seed::Loader do
  it_behaves_like 'a seed loader', Seed::Race, Definition::Race
  it_behaves_like 'a seed loader', Seed::UnitClass, Definition::UnitClass
  it_behaves_like 'a seed loader', Seed::Unit, Definition::Unit
end
