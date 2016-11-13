class CreateStoreConfigurations < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name  , unique: true
      t.integer :business_type_id
      t.text   :company_description
      t.string :logo
      t.string :sub_domain , unique: true
      t.string :country
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :currency
      t.decimal :tax_rate, :precision => 8, :scale => 2
      t.integer :owner_id, :integer
      t.integer :status , default: false
      t.timestamps
    end

  end
end
