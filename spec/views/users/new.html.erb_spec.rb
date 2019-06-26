require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, build(:user))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[first_name]"
      assert_select "input[name=?]", "user[last_name]"
      assert_select "input[name=?][type='email']", "user[email]"
      assert_select "input[name=?][type='password']", "user[password]"
      assert_select "input[name=?][type='password']", "user[password_confirmation]"
    end
  end
end
