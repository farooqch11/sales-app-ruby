class AddEmailToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :email, :string
    add_column :companies, :phone, :string
    add_column :companies, :is_activated, :boolean , default: true
  end
end
