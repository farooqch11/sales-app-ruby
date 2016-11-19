class AddColumnsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :currency_name, :string
    add_column :companies, :currency_code, :string
  end
end
