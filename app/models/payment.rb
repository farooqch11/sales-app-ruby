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

  after_create :send_sale_invoice_to_customer


  def amount_after_change
    (self.sale.total_amount - self.amount) >= 0 ? self.amount : self.sale.total_amount
  end

  def send_sale_invoice_to_customer
    UserMailer.send_sale_invoice_to_customer(self.sale).deliver
  end
end
