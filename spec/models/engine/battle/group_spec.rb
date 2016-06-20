require 'rails_helper'

RSpec.describe Engine::Battle::Group do
  let(:event) { create :event }
  let(:attackers) { event.attackers }
  let(:attackers_number) { 3 }
  let(:unit) { definition_units(:ranger) }
  let(:subject) { described_class.new(attackers, unit) }
  let(:quantity) { 100 }
  let(:units)  { Definition::Unit.all }
  let(:start_damage) { 0 }
  let(:squadrons) { subject.members.order(:id) }


  before do
    attackers_number.times do
      attackers.create(division: create(:division)).tap do |participant|
        units.each do |unit|
          participant.division.squadrons.create(unit: unit, quantity: quantity, damage: start_damage)
        end
      end
    end
  end

  describe '#members' do
    it 'returns only the squadrons of the given unit type' do
      expect(subject.members.count).to eq(attackers_number)
    end
    
    it 'returns squadrons for the given unit type' do
      expect(subject.members.map(&:unit).uniq).to eq([ unit ])
    end

    it 'returns a list of squadrons' do
      expect(subject.members.first.class).to eq(Game::Squadron)
    end
  end

  describe '#quantity' do
    it 'sums all squadrons' do
      expect(subject.quantity).to eq(quantity * attackers_number)
    end
  end

  describe '#damage' do
    it_behaves_like 'a damage distribuitor'
  end
end
