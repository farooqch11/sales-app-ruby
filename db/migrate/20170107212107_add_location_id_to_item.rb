class AddLocationIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :location_id, :integer , index: true , foreign_key: true
    add_column :sales, :location_id, :integer , index: true , foreign_key: true
    add_column :users, :location_id, :integer , index: true , foreign: true
  end
end
