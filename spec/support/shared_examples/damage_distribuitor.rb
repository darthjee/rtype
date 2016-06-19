shared_examples 'a damage distribuitor' do
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
      expect(squadrons.reload.pluck(:damage).max).to be >= 99
    end

    it 'damages the largest with the most damage' do
      subject.damage(damage)
      expect(biggest.reload.damage).to be >= 99
    end

    context 'when randomic damage gives damage to first squadron' do
      before do
        allow_any_instance_of(Array).to receive(:random!) do |array|
          array.shift
        end
      end

      it 'damages the first more' do
        subject.damage(damage)
        expect(squadrons.reload.pluck(:damage)).to eq([ 0, 100 ])
      end
    end

    context 'when randomic damage gives damage to first squadron' do
      before do
        allow_any_instance_of(Array).to receive(:random!) do |array|
          array.pop
        end
      end

      it 'damages the first more' do
        subject.damage(damage)
        expect(squadrons.reload.pluck(:damage)).to eq([ 1, 99 ])
      end
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

