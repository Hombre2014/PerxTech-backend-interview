require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before do
    assign(:users, [
             User.create!(
               first_name: 'First Name',
               last_name: 'Last Name',
               country_of_origin: 'Country Of Origin',
               level: 2,
               points: 3,
               tier: 'Tier'
             ),
             User.create!(
               first_name: 'First Name',
               last_name: 'Last Name',
               country_of_origin: 'Country Of Origin',
               level: 2,
               points: 3,
               tier: 'Tier'
             )
           ])
  end

  it 'renders a list of users' do
    render
    assert_select 'tr>td', text: 'First Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Last Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Country Of Origin'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: 'Tier'.to_s, count: 2
  end
end
