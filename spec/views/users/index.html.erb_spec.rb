require 'rails_helper'

RSpec.describe "users/index", type: :view do
  let(:users) { [create(:user), create(:user)] } # create_list isn't triggering sequence properly
  before(:each) do
    assign(:users, users)
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => users[0].first_name
    assert_select "tr>td", :text => users[0].last_name
    assert_select "tr>td", :text => users[1].first_name
    assert_select "tr>td", :text => users[1].last_name
  end
end
