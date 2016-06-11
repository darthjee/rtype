require 'rails_helper'

RSpec.describe Seed::Creator do
  let(:seed_class) { Seed::Race }
  let(:final_class) { Definition::Race }
  let(:subject) { described_class.new(seed_class, final_class) }

  describe '#create' do
    it do
      expect do
        subject.create
      end.to change(final_class, :count).by(seed_class.count)
    end
  end
end

