require 'rails_helper'

RSpec.describe "purchases/show", type: :view do
  before(:each) do
    @purchase = assign(:purchase, Purchase.create!(
      country_of_purchase: "Country Of Purchase",
      amount: "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Country Of Purchase/)
    expect(rendered).to match(/9.99/)
  end
end
