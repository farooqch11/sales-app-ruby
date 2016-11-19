# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  company_id :integer
#  name       :string
#  address_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base

  #Association
  belongs_to :company
  belongs_to :address
end
