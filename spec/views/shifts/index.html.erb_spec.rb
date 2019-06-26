# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'shifts/index', type: :view do
  let(:shift) { create(:shift) }
  before(:each) do
    assign(:shifts, [shift])
  end

  it 'renders a list of shifts' do
    render
    assert_select 'tr>td', text: shift.user.name.to_s
    assert_select 'tr>td', text: shift.position.name.to_s
  end
end
