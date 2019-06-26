require 'rails_helper'

RSpec.describe "positions/show", type: :view do
  let(:location) {create(:location)}
  before(:each) do
    @position = assign(:position, Position.create!(
      :location => location,
      :name => "Name",
      :min_staff => 2,
      :max_staff => 3,
      :min_shift_duration_hrs => 4.5,
      :max_shift_duration_hrs => 5.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
  end
end
