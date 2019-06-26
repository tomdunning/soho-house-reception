# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'locations/new', type: :view do
  before(:each) do
    assign(:location, Location.new(
                        name: 'MyString',
                        address_line_1: 'MyString',
                        address_line_2: 'MyString',
                        postcode: 'MyString',
                        country_code: 'MyString'
                      ))
  end

  it 'renders new location form' do
    render

    assert_select 'form[action=?][method=?]', locations_path, 'post' do
      assert_select 'input[name=?]', 'location[name]'

      assert_select 'input[name=?]', 'location[address_line_1]'

      assert_select 'input[name=?]', 'location[address_line_2]'

      assert_select 'input[name=?]', 'location[postcode]'

      assert_select 'input[name=?]', 'location[country_code]'
    end
  end
end
