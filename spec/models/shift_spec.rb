require 'rails_helper'

RSpec.describe Shift, type: :model do

  describe '#validate' do


    let(:tomorrow) { Time.now.tomorrow.beginning_of_day }
    let(:user){ create(:user)}
    let(:position) { create(:position) }

    context 'with valid params' do
      let(:params) { { position: position, user: user, start_at: tomorrow + 7.hours, end_at: tomorrow + 11.hours } }
      subject { described_class.new(params)}
      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'without a user' do
      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:user]).to include("must exist")
      end
    end

    context 'without a position' do
      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:position]).to include("must exist")
      end
    end

    context 'with a duration longer than the max' do
      let(:params) { { position: position, user: user, start_at: tomorrow + 7.hours, end_at: tomorrow + 19.hours } }
      subject { described_class.new(params)}
      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:end_at]).to include("can't be longer than the maximum shift duration: 8.0 hrs")
      end
    end

    context 'with a duration shorter than the min' do
      let(:params) { { position: position, user: user, start_at: tomorrow + 7.hours, end_at: tomorrow + (7.1).hours } }
      subject { described_class.new(params)}
      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:end_at]).to include("can't be shorter than the minimum shift duration: 1.0 hrs")
      end
    end
  end

end
