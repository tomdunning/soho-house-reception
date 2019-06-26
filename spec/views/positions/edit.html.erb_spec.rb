# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'positions/edit', type: :view do
  let(:location) { create(:location) }
  before(:each) do
    @position = assign(:position, Position.create!(
                                    location: location,
                                    name: 'MyString',
                                    min_staff: 1,
                                    max_staff: 1,
                                    min_shift_duration_hrs: 1.5,
                                    max_shift_duration_hrs: 1.5
                                  ))
    @locations = assign(:locations, create_list(:location, 2).map { |i| [i[:name], i[:id]] })
  end

  it 'renders the edit position form' do
    render

    assert_select 'form[action=?][method=?]', position_path(@position), 'post' do
      assert_select 'select[name=?]', 'position[location_id]'

      assert_select 'input[name=?]', 'position[name]'

      assert_select 'input[name=?]', 'position[min_staff]'

      assert_select 'input[name=?]', 'position[max_staff]'

      assert_select 'input[name=?]', 'position[min_shift_duration_hrs]'

      assert_select 'input[name=?]', 'position[max_shift_duration_hrs]'
    end
  end
end
