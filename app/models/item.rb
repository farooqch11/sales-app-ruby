# == Schema Information
#
# Table name: items
#
#  id               :integer          not null, primary key
#  sku              :string
#  name             :string
#  description      :text
#  price            :decimal(8, 2)
#  stock_amount     :integer
#  amount_sold      :integer          default(0)
#  cost_price       :decimal(8, 2)
#  published        :boolean          default(TRUE)
#  created_at       :datetime
#  updated_at       :datetime
#  item_category_id :integer
#

class Item < ActiveRecord::Base
	has_many :line_items
	belongs_to :item_category

	validates :sku, presence: true, uniqueness: true
	validates :name, presence: true, uniqueness: true
	validates :price, presence: true
	validates :stock_amount, presence: true
end
