require 'rails_helper'

RSpec.describe "shifts/show", type: :view do
  let(:shift) { create(:shift) }
  before(:each) do
    @shift = assign(:shift, shift)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(shift.user.name)
    expect(rendered).to match(shift.position.name)
    expect(rendered).to match(shift.start_at.to_s)
    expect(rendered).to match(shift.end_at.to_s)
  end
end
