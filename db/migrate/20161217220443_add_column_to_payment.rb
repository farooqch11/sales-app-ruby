class AddColumnToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :payment_term, :integer
    remove_column :payments, :payment_type
    add_column :payments, :payment_type, :integer
  end
end
