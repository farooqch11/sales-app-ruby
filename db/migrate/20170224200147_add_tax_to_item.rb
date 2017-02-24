class AddTaxToItem < ActiveRecord::Migration
  def change
    add_column :items, :tax, :float , default: 0.0
  end
end
