class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.date :date
      t.string :country_of_purchase
      t.decimal :amount
      t.boolean :counted
      t.boolean :processed_for_points
      t.boolean :checked_for_5_percent_rewards
      t.boolean :checked_for_free_movie_tickets
      

      t.timestamps
    end
  end
end
