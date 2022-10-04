require 'rails_helper'

RSpec.describe "purchases/edit", type: :view do
  before(:each) do
    @purchase = assign(:purchase, Purchase.create!(
      country_of_purchase: "MyString",
      amount: "9.99"
    ))
  end

  it "renders the edit purchase form" do
    render

    assert_select "form[action=?][method=?]", purchase_path(@purchase), "post" do

      assert_select "input[name=?]", "purchase[country_of_purchase]"

      assert_select "input[name=?]", "purchase[amount]"
    end
  end
end
