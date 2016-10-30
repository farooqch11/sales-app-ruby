# == Schema Information
#
# Table name: payments
#
#  id           :integer          not null, primary key
#  sale_id      :integer
#  amount       :decimal(8, 2)
#  payment_type :string
#  created_at   :datetime
#  updated_at   :datetime
#

class Payment < ActiveRecord::Base
  belongs_to :sale
  belongs_to :company

  def amount_after_change
    value = self.sale.total_amount - self.amount

    if value >= 0
      return self.amount
    else
      return self.sale.total_amount
    end
  end
end
