require 'rails_helper'

RSpec.describe "purchases/index", type: :view do
  before(:each) do
    assign(:purchases, [
      Purchase.create!(
        country_of_purchase: "Country Of Purchase",
        amount: "9.99"
      ),
      Purchase.create!(
        country_of_purchase: "Country Of Purchase",
        amount: "9.99"
      )
    ])
  end

  it "renders a list of purchases" do
    render
    assert_select "tr>td", text: "Country Of Purchase".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
  end
end
