class AddBarcodeToItems < ActiveRecord::Migration
  def change
    add_column :items, :barcode, :string
    add_column :items, :shelf, :string
  end
end
