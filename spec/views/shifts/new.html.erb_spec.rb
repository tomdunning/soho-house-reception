require 'rails_helper'

RSpec.describe "shifts/new", type: :view do
  before(:each) do
    assign(:shift, Shift.new(
      :position => nil,
      :user => nil
    ))
  end

  it "renders new shift form" do
    render

    assert_select "form[action=?][method=?]", shifts_path, "post" do

      assert_select "input[name=?]", "shift[position_id]"

      assert_select "input[name=?]", "shift[user_id]"
    end
  end
end
