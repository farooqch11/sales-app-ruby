class AddColumnToSale < ActiveRecord::Migration
  def change
    add_column :sales, :refund_by, :integer
    add_column :sales, :status, :integer , default: 0
  end
end
