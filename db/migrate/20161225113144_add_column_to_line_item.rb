class AddColumnToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :cost_price, :decimal , default: 0.0
    add_column :line_items, :total_cost_price, :decimal , default: 0.0
  end
end
