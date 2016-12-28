# == Schema Information
#
# Table name: line_items
#
#  id               :integer          not null, primary key
#  item_id          :integer
#  quantity         :integer          default(1)
#  price            :decimal(8, 2)
#  total_price      :decimal(8, 2)
#  sale_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  cost_price       :decimal(, )      default(0.0)
#  total_cost_price :decimal(, )      default(0.0)
#

class LineItem < ActiveRecord::Base
  belongs_to :sale
  belongs_to :item
  has_one :company , through: :sale
  before_create :set_cost_price
  before_save :set_total_cost_price

  validates :cost_price , :total_price , presence: true
  validates :quantity, numericality: { only_integer: true , greater_than: 0 }

  private

  def set_cost_price
    self.cost_price = self.item.cost_price
  end

  def set_total_cost_price
    self.total_cost_price = self.cost_price * self.quantity
  end


  
end
