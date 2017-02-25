class AddTaxToItem < ActiveRecord::Migration
  def change
    add_column :items, :tax, :float , default: 0.0
    remove_column :users , :can_update_users, :boolean
    remove_column :users ,  :can_update_items, :boolean
    remove_column :users ,  :can_update_configuration, :boolean
    remove_column :users ,  :can_view_reports, :boolean
    remove_column :users ,  :can_update_sale_discount, :boolean
    remove_column :users ,  :can_remove_sales, :boolean

    create_table :roles_users , id: false do |t|
      t.integer :role_id , index: true
      t.integer :user_id , index: true
    end
  end

end
