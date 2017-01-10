class AddDiscountTypeToSale < ActiveRecord::Migration
  def change
    add_column :sales, :discount_type, :integer , default: 0
  end
end
