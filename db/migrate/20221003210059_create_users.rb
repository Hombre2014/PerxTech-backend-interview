class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :country_of_origin
      t.integer :level
      t.integer :points
      t.string :tier

      t.timestamps
    end
  end
end
