# == Schema Information
#
# Table name: item_categories
#
#  id          :integer          not null, primary key
#  company_id  :integer
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class ItemCategory < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_many :items
	belongs_to :company

end
