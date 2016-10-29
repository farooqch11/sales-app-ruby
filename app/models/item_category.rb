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
# Indexes
#
#  index_item_categories_on_company_id  (company_id)
#

class ItemCategory < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_many :items
	belongs_to :company

end
