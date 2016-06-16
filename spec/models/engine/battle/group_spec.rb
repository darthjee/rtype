require 'rails_helper'

RSpec.describe Engine::Battle::Group do
  let(:event) { create :event }
  let(:attackers) { event.attackers }
  let(:attackers_number) { 3 }
  let(:unit) { definition_units(:ranger) }
  let(:subject) { described_class.new(attackers, unit) }
  let(:quantity) { 100 }
  let(:units)  { Definition::Unit.all }

  before do
    attackers_number.times do
      attackers.create(division: create(:division)).tap do |participant|
        units.each do |unit|
          participant.division.squadrons.create(unit: unit, quantity: quantity)
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
    let(:units)  { Definition::Unit.where(id: unit.id) }
    let(:squadrons) { subject.members }

    context 'when damaging each squadron evenly' do
      let(:damage) { attackers_number }

      it 'split doamage among the squadrons' do
        subject.damage(damage)
        expect(squadrons.reload.map(&:damage)).to eq(Array.new(attackers_number, 1))
      end
    end

    context 'when damaging each squadron evenly' do
      let(:damage) { attackers_number + 2 }


      it 'split doamage among the squadrons' do
        subject.damage(damage)
        expect(squadrons.reload.map(&:damage).sum).to eq(damage)
      end
      
      it 'split doamage among the squadrons' do
        subject.damage(damage)
        expect(squadrons.reload.map(&:damage).max).to eq(2)
      end
    end
  end
end
