class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :country_of_origin
      t.integer :level
      t.integer :points
      t.string :tier
      t.boolean :birthday_reward
      t.decimal :total_amount_spent
      t.decimal :total_amount_spent_foreign
      t.decimal :unused_amount
      t.decimal :unused_amount_foreign
      

      t.timestamps
    end
  end
end
