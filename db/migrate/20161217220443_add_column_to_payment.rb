class AddColumnToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :payment_term, :integer
    change_column :payments, :payment_type, :integer
  end
end
