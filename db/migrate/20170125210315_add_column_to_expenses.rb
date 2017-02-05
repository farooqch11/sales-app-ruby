class AddColumnToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :payment_method, :integer , default: 0
    add_column :expenses, :ref_no, :string
    add_column :expenses, :slug, :string , index: true , unique: true
    add_column :locations, :slug, :string , index: true , unique: true
    add_column :locations, :status, :integer , default: 0
  end
end
