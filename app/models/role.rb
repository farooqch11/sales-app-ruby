# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ActiveRecord::Base
  has_many :users

  def self.general_manager
      find_by_name("General Manager")
  end

  def self.store_manager
    find_by_name("Store Manager")
  end


  def self.cashier
    find_by_name("Cashier")
  end

  def self.inventory_manager
    find_by_name("Inventory Manager")
  end

  def self.warehouse_manager
    find_by_name("Warehouse manager")
  end

  def self.customer_service_manager
    find_by_name("Customer Service Manager")
  end
end
