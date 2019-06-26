require 'rails_helper'

RSpec.describe Location, type: :model do

  describe '#validate' do
    subject { described_class.new(params) }

    context 'with required params' do
      let(:params) { attributes_for(:location) }
      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'with required and optional params' do
      let(:params) { attributes_for(:location, :with_address) }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'without minimum params' do
      let(:params) { {} }
      it 'is invalid and returns errors' do
        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to include("can't be blank")
      end
    end


    context 'with a duplicate name' do
      let(:location_1) { create(:location) }
      let(:params) { { name: location_1.name } }

      it 'is invalid and returns errors' do
        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to include("has already been taken")
      end
    end
  end
end
