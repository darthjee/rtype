require 'rails_helper'

RSpec.describe Seed::Creator do
  it_behaves_like 'a bulk class seed loader', [ :race, :unit ], Seed::Race, Definition::Race
  it_behaves_like 'a bulk class seed loader', [ :unit, :race ], Seed::Race, Definition::Race
end

