# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validate' do
    subject { described_class.new(params) }

    context 'with minimum required params' do
      let(:params) do
        {
          first_name: 'Tom',
          last_name: 'Thumb',
          email: 'tom.thumb@google.com',
          password: 'newpass',
          password_confirmation: 'newpass'
        }
      end

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'without required params' do
      let(:params) { {} }
      it 'is invalid and errors are accessible' do
        expect(subject).not_to be_valid
        expect(subject.errors[:first_name]).to include("can't be blank")
        expect(subject.errors[:last_name]).to include("can't be blank")
        expect(subject.errors[:email]).to include("can't be blank")
        expect(subject.errors[:password]).to include("can't be blank")
      end
    end
  end
end
