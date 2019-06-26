require 'rails_helper'

RSpec.describe Shift, type: :model do

  describe '#validate' do


    let(:tomorrow) { Time.now.utc.tomorrow.beginning_of_day }
    let(:user){ create(:user)}
    let(:position) { create(:position) }

    subject { described_class.new(params)}

    context 'with valid params' do
      let(:params) { { position: position, user: user, start_at: tomorrow + 7.hours, end_at: tomorrow + 11.hours } }
      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'without a user' do
      let(:params) { { position: position, user: nil, start_at: tomorrow + 7.hours, end_at: tomorrow + 11.hours } }
      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:user]).to include("must exist")
      end
    end

    context 'without a position' do
      let(:params) { { position: nil, user: user, start_at: tomorrow + 7.hours, end_at: tomorrow + 11.hours } }
      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:position]).to include("must exist")
      end
    end

    context 'with a duration longer than the max' do
      let(:params) { { position: position, user: user, start_at: tomorrow + 7.hours, end_at: tomorrow + 19.hours } }
      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:end_at]).to include("can't be longer than the maximum shift duration: 8.0 hrs")
      end
    end

    context 'with a duration shorter than the min' do
      let(:params) { { position: position, user: user, start_at: tomorrow + 7.hours, end_at: tomorrow + (7.1).hours } }
      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:end_at]).to include("can't be shorter than the minimum shift duration: 1.0 hrs")
      end
    end


    context 'with more than the max number of hours per week (40)' do
      let!(:shift_1) { create(:shift, user: user, start_at: tomorrow.beginning_of_week + 7.hours, end_at: tomorrow.beginning_of_week + 15.hours ) }
      let!(:shift_2) { create(:shift, user: user, start_at: tomorrow.beginning_of_week + 16.hours, end_at: tomorrow.beginning_of_week + 24.hours ) }
      let!(:shift_3) { create(:shift, user: user, start_at: tomorrow.beginning_of_week  + 1.day + 7.hours, end_at: tomorrow.beginning_of_week + 1.day + 15.hours ) }
      let!(:shift_4) { create(:shift, user: user, start_at: tomorrow.beginning_of_week  + 1.day + 16.hours, end_at: tomorrow.beginning_of_week + 1.day + 24.hours ) }
      let!(:shift_5) { create(:shift, user: user, start_at: tomorrow.beginning_of_week  + 2.day + 7.hours, end_at: tomorrow.beginning_of_week + 2.day + 15.hours ) }

      let(:params) { { position: position, user: user, start_at: tomorrow + 3.days + 7.hours, end_at: tomorrow + 3.days + 15.hours } }
      it 'raises an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:end_at]).to include("can't be more than the weekly 40.0 hour maximum")
      end
    end

    context 'with an overlapping shift' do
      let!(:shift_1) { create(:shift, start_at: tomorrow + 7.hours, end_at: tomorrow + 15.hours ) }
      let(:params) { { position: position, user: user, start_at: tomorrow + 14.hours, end_at: tomorrow + 20.hours } }

      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:end_at]).to include("can't overlap shifts. Too many shifts for the given period")
      end
    end


    context 'starting during closing hours' do
      let(:params) { { position: position, user: user, start_at: tomorrow + 4.hours, end_at: tomorrow + 10.hours } }

      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:start_at]).to include("can't be during closing hours")
      end
    end


    context 'ending during closing hours' do
      let(:params) { { position: position, user: user, start_at: tomorrow + 20.hours, end_at: tomorrow + 28.hours } }

      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:end_at]).to include("can't be during closing hours")
      end
    end

  context 'spanning closing hours' do
      let(:params) { { position: position, user: user, start_at: tomorrow + 2.hours, end_at: tomorrow + 8.hours } }

      it 'is invalid and returns an error' do
        expect(subject).not_to be_valid
        expect(subject.errors[:end_at]).to include("can't be during closing hours")
      end
    end



  end

end
