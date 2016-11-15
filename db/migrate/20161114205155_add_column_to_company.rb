class AddColumnToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :low_stock_alert, :integer
    add_column :expenses, :amount, :float
  end
end
