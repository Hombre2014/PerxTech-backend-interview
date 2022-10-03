require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      first_name: "MyString",
      last_name: "MyString",
      country_of_origin: "MyString",
      level: 1,
      points: 1,
      tier: "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "input[name=?]", "user[country_of_origin]"

      assert_select "input[name=?]", "user[level]"

      assert_select "input[name=?]", "user[points]"

      assert_select "input[name=?]", "user[tier]"
    end
  end
end
