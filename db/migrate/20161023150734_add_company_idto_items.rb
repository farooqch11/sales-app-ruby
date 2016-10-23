class AddCompanyIdtoItems < ActiveRecord::Migration
  def change
    add_column :items , :company_id , :integer
  end
end
