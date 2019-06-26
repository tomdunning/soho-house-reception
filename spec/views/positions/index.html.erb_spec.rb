# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'positions/index', type: :view do
  let(:location) { create(:location) }
  before(:each) do
    assign(:positions, [
             Position.create!(
               location: location,
               name: 'Name',
               min_staff: 2,
               max_staff: 3,
               min_shift_duration_hrs: 4.5,
               max_shift_duration_hrs: 5.5
             ),
             Position.create!(
               location: location,
               name: 'Name',
               min_staff: 2,
               max_staff: 3,
               min_shift_duration_hrs: 4.5,
               max_shift_duration_hrs: 5.5
             )
           ])
  end

  it 'renders a list of positions' do
    render
    assert_select 'tr>td', text: location.name.to_s, count: 2
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: 4.5.to_s, count: 2
    assert_select 'tr>td', text: 5.5.to_s, count: 2
  end
end
