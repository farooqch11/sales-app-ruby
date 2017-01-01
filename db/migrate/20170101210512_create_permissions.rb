class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :permissions_roles , id: false do |t|
      t.integer :role_id
      t.integer :permission_id
    end
  end
end
