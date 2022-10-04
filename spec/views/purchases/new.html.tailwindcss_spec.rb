require 'rails_helper'

RSpec.describe "purchases/new", type: :view do
  before(:each) do
    assign(:purchase, Purchase.new(
      country_of_purchase: "MyString",
      amount: "9.99"
    ))
  end

  it "renders new purchase form" do
    render

    assert_select "form[action=?][method=?]", purchases_path, "post" do

      assert_select "input[name=?]", "purchase[country_of_purchase]"

      assert_select "input[name=?]", "purchase[amount]"
    end
  end
end
