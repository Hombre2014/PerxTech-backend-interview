require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before do
    @user = assign(:user, User.create!(
                            first_name: 'First Name',
                            last_name: 'Last Name',
                            country_of_origin: 'Country Of Origin',
                            level: 2,
                            points: 3,
                            tier: 'Tier'
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Country Of Origin/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Tier/)
  end
end
