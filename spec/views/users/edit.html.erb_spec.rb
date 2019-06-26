# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  before(:each) do
    @user = assign(:user, create(:user))
  end

  it 'renders the edit user form' do
    render

    assert_select 'form[action=?][method=?]', user_path(@user), 'post' do
      assert_select 'input[name=?]', 'user[first_name]'
      assert_select 'input[name=?]', 'user[last_name]'
      assert_select "input[name=?][type='email']", 'user[email]'
      assert_select "input[name=?][type='password']", 'user[password]'
      assert_select "input[name=?][type='password']", 'user[password_confirmation]'
    end
  end
end
