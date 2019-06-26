require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        :name => "Name 1",
        :address_line_1 => "Address Line 1",
        :address_line_2 => "Address Line 2",
        :postcode => "Postcode",
        :country_code => "Country Code"
      ),
      Location.create!(
        :name => "Name 2",
        :address_line_1 => "Address Line 1",
        :address_line_2 => "Address Line 2",
        :postcode => "Postcode",
        :country_code => "Country Code"
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select "tr>td", :text => "Name 1".to_s
    assert_select "tr>td", :text => "Name 2".to_s
    assert_select "tr>td", :text => "Address Line 1".to_s, :count => 2
    assert_select "tr>td", :text => "Address Line 2".to_s, :count => 2
    assert_select "tr>td", :text => "Postcode".to_s, :count => 2
    assert_select "tr>td", :text => "Country Code".to_s, :count => 2
  end
end
