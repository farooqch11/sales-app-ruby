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
#
# Indexes
#
#  index_customers_on_company_id  (company_id)
#

class Customer < ActiveRecord::Base
  has_many :sales
  belongs_to :company

  def full_name
    (first_name + " " + last_name).titleize
  end

end
