class AddLocationIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :location_id, :integer , index: true
  end
end
