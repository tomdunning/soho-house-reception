require 'rails_helper'

RSpec.describe Position, type: :model do
  subject { described_class.new(params)}

  describe '#validate' do
    let(:location) { create(:location) }


    context 'with valid params' do
      let(:params) { { location_id: location.id, name: 'Receptionist' } }
      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'without a location' do
      let(:params) { { location_id: nil, name: 'Receptionist' } }
      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:location]).to include("can't be blank")
      end
    end

    context 'without a name' do
      let(:params) { { location_id: location.id, name: '' } }
      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to include("can't be blank")
      end
    end

  end
end
