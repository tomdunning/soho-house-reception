require 'rails_helper'

RSpec.describe "locations/show", type: :view do
  before(:each) do
    @location = assign(:location, Location.create!(
      :name => "Name",
      :address_line_1 => "Address Line 1",
      :address_line_2 => "Address Line 2",
      :postcode => "Postcode",
      :country_code => "Country Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address Line 1/)
    expect(rendered).to match(/Address Line 2/)
    expect(rendered).to match(/Postcode/)
    expect(rendered).to match(/Country Code/)
  end
end
