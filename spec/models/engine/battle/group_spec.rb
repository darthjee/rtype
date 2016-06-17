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
    let(:units)  { Definition::Unit.where(id: unit.id) }
    let(:squadrons) { subject.members }

    context 'when damaging each squadron evenly' do
      let(:damage) { attackers_number }

      it 'split doamage among the squadrons' do
        subject.damage(damage)
        expect(squadrons.reload.pluck(:damage)).to eq(Array.new(attackers_number, 1))
      end
    end

    context 'when damaging each squadron evenly' do
      let(:damage) { attackers_number + 2 }

      it 'split doamage among the squadrons' do
        subject.damage(damage)
        expect(squadrons.reload.pluck(:damage).sum).to eq(damage)
      end
      
      it 'split doamage evenly and randomly among the squadrons' do
        subject.damage(damage)
        expect(squadrons.reload.pluck(:damage).max).to eq(2)
      end
    end

    context 'when squadrons have huge size differency' do
      let(:attackers_number) { 2 }
      let(:damage) { 100 }
      let(:biggest) { squadrons.find_by(quantity: 100) }
      before do
        attackers.first.division.squadrons.first.update(quantity: 1)
      end

      it 'split doamage among the squadrons' do
        subject.damage(damage)
        expect(squadrons.reload.pluck(:damage).sum).to eq(damage)
      end

      it 'splits damage according to the unit quantity giving the lesser value to the lesser squadron' do
        subject.damage(damage)
        expect(squadrons.reload.pluck(:damage).min).to be <= 1
      end

      it 'splits damage according to the unit quantity giving the greater value to the greater squadron' do
        subject.damage(damage)
        expect(squadrons.reload.pluck(:damage).max).to be >= 97
      end

      it 'damages the largest with the most damage' do
        subject.damage(damage)
        expect(biggest.reload.damage).to be >= 97
      end
    end

    context 'when squadrons already have damage' do
      let(:start_damage) { 30 }
      let(:attackers_number) { 1 }
      let(:squadron) { squadrons.first }
      let(:damage) { 10 }

      it 'adds damage' do
        expect do
          subject.damage(damage)
        end.to change { squadron.reload.damage }.by(damage)
      end
    end
  end
end
