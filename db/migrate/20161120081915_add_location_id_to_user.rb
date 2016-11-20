class AddLocationIdToUser < ActiveRecord::Migration
  def change
    create_table :locations_users , id: false do |t|
      t.integer :user_id, index: true , foreign_key: true
      t.integer :location_id,index: true , foreign_key: true
    end
    add_column :locations, :published, :boolean , default: true
  end
end
