# == Schema Information
#
# Table name: business_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BusinessType < ActiveRecord::Base
  has_many :companies
end
