shared_examples 'a seed loader' do |seed_class, final_class|
  let(:subject) { described_class.new(seed_class, final_class) }

  it_behaves_like 'a real seed loader', seed_class, final_class
end

shared_examples 'a class seed loader' do |class_name, seed_class, final_class|
  let(:subject) { described_class.new(class_name) }

  it_behaves_like 'a real seed loader', seed_class, final_class
end

shared_examples 'a real seed loader' do |seed_class, final_class|
  describe '#create' do
    it do
      expect do
        subject.create
      end.to change(final_class, :count).by(seed_class.count)
    end

    describe 'when seed has been run before creating the first element' do
      before do
        final_class.create(seed_class.first.attributes)
      end

      it do
        expect do
          subject.create
        end.to change(final_class, :count).by(seed_class.count - 1)
      end

      describe 'when new seed has different data' do
        before do
          final_class.first.update(name: 'XXXXXXXX')
        end

        it do
          expect do
            subject.create
          end.to change(final_class, :count).by(seed_class.count - 1)
        end

        it do
          expect do
            subject.create
          end.to change { final_class.first.name }
        end
      end
    end
  end
end

