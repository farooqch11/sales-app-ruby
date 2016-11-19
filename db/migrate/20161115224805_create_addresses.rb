class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.integer :status , default: 0

      t.timestamps null: false
    end
  end
end
