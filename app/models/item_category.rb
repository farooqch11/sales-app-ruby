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
#  slug        :string
#
# Indexes
#
#  index_item_categories_on_company_id  (company_id)
#  index_item_categories_on_slug        (slug) UNIQUE
#

class ItemCategory < ActiveRecord::Base

	extend FriendlyId
	friendly_id :name, use: :slugged

	#Validations
	validates :name, presence: true
	validates_uniqueness_of :name, scope: [:company_id , :name]

	#Associations
	has_many :items
	belongs_to :company

	default_scope {order(name: :asc)}

	private

	def should_generate_new_friendly_id?
		name_changed? || super
	end

end
