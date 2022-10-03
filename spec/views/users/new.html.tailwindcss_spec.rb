require 'rails_helper'

RSpec.describe 'users/new', type: :view do
  before do
    assign(:user, User.new(
                    first_name: 'MyString',
                    last_name: 'MyString',
                    country_of_origin: 'MyString',
                    level: 1,
                    points: 1,
                    tier: 'MyString'
                  ))
  end

  it 'renders new user form' do
    render

    assert_select 'form[action=?][method=?]', users_path, 'post' do
      assert_select 'input[name=?]', 'user[first_name]'

      assert_select 'input[name=?]', 'user[last_name]'

      assert_select 'input[name=?]', 'user[country_of_origin]'

      assert_select 'input[name=?]', 'user[level]'

      assert_select 'input[name=?]', 'user[points]'

      assert_select 'input[name=?]', 'user[tier]'
    end
  end
end
