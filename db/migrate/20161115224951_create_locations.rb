class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :company_id
      t.string :name
      t.integer :address_id
      t.timestamps null: false
    end
  end
end
