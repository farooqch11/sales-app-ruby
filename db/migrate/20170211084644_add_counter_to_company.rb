class AddCounterToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :customers_count, :integer, :default => 0
    add_column :sales, :invoice_key, :string

    # add_column :customers, :deleted_at, :datetime , index: true

    remove_index :users, :email
    remove_index :users, :username
    add_index :users, [:email,:company_id] ,                :unique => true

    # add_column :locations, :customers_count, :integer, :default => 0

    Company.reset_column_information
    Company.all.each do |c|
      Company.update_counters c.id, customers_count: c.customers.length
    end
  end

  # def self.down
  #   remove_column :companies, :customers_count
  #   remove_column :sales, :invoice_key
  #   # remove_column :locations, :customers_count
  # end
end
