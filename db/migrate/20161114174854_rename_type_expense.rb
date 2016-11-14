class RenameTypeExpense < ActiveRecord::Migration
  def change
    rename_column :expenses , :type , :expense_type
  end
end
