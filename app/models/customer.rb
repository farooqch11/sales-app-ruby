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

  #Nested Attributes
  accepts_nested_attributes_for :address, allow_destroy: true

  #scopes
  default_scope {order(first_name: :asc)}


  def full_name
    (first_name + " " + last_name).titleize
  end

  def email
    email_address
  end

end
