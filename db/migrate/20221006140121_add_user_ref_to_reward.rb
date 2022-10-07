class AddUserRefToReward < ActiveRecord::Migration[7.0]
  def change
    add_reference :rewards, :user, null: false, foreign_key: true
  end
end
