require 'rails_helper'

RSpec.describe "shifts/edit", type: :view do
  let(:shift){ create(:shift) }
  before(:each) do
    @shift = assign(:shift, shift)
  end

  it "renders the edit shift form" do
    render

    assert_select "form[action=?][method=?]", shift_path(@shift), "post" do

      assert_select "input[name=?]", "shift[position_id]"

      assert_select "input[name=?]", "shift[user_id]"
    end
  end
end
