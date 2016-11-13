# == Schema Information
#
# Table name: line_items
#
#  id          :integer          not null, primary key
#  item_id     :integer
#  quantity    :integer          default(1)
#  price       :decimal(8, 2)
#  total_price :decimal(8, 2)
#  sale_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class LineItem < ActiveRecord::Base
  belongs_to :sale
  belongs_to :item
  belongs_to :company

  #Validations
  validates :quantity, numericality: { only_integer: true , greater_than: 0 }

  
end
