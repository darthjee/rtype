require 'rails_helper'

RSpec.describe Game::Battle::Event do
  let(:subject) { game_battle_events(:first_blood) }
  let(:attacker) { game_battle_participants(:first_attacker) }
  let(:defender) { game_battle_participants(:first_defender) }

  describe '#attackers' do
    context 'when event has one attacker and one defender' do
      it 'returns only the attackers' do
        expect(subject.attackers).to eq([ attacker ])
      end
    end
  end

  describe '#defenders' do
    context 'when event has one attacker and one defender' do
      it 'returns only the defenders' do
        expect(subject.defenders).to eq([ defender ])
      end
    end
  end
end

