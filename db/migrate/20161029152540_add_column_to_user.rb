class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :salary, :float
    add_column :users, :skills, :string
  end
end
