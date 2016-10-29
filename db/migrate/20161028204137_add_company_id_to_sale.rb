class AddCompanyIdToSale < ActiveRecord::Migration
  def change
    add_column :sales, :company_id, :integer
  end
end
