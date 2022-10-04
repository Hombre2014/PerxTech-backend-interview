class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.date :date
      t.string :country_of_purchase
      t.decimal :amount

      t.timestamps
    end
  end
end
