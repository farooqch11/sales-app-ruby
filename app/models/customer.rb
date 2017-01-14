# == Schema Information
#
# Table name: customers
#
#  id            :integer          not null, primary key
#  company_id    :integer
#  first_name    :string
#  last_name     :string
#  email_address :string
#  phone_number  :string
#  address       :string
#  city          :string
#  state         :string
#  zip           :string
#  published     :boolean          default(TRUE)
#  created_at    :datetime
#  updated_at    :datetime
#  address_id    :integer
#  location_id   :integer
#
# Indexes
#
#  index_customers_on_company_id  (company_id)
#

class Customer < ActiveRecord::Base

  #Associations
  has_many    :sales
  belongs_to  :company
  belongs_to  :address
  belongs_to  :location
  has_many    :payments , through: :sales

  #Nested Attributes
  accepts_nested_attributes_for :address, allow_destroy: true

  #scopes
  # default_scope {order(first_name: :asc)}
  scope :published ,-> {where(published: true)}
  scope :search_all , -> value {where('customers.last_name LIKE ? OR customers.first_name LIKE ? OR customers.email_address LIKE ? OR customers.phone_number LIKE ?', "%#{value}%","%#{value}%", "%#{value}%", "%#{value}%")}


  def full_name
    (first_name + " " + last_name).titleize
  end


  def email
    email_address
  end

end
