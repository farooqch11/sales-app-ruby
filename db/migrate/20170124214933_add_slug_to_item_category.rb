class AddSlugToItemCategory < ActiveRecord::Migration
  def change
    add_column :item_categories, :slug, :string
    add_index :item_categories, :slug, unique: true
  end
end
