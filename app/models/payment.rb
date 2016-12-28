# == Schema Information
#
# Table name: payments
#
#  id           :integer          not null, primary key
#  sale_id      :integer
#  amount       :decimal(8, 2)
#  created_at   :datetime
#  updated_at   :datetime
#  payment_term :integer
#  payment_type :integer
#

class Payment < ActiveRecord::Base

  enum payment_type: [:cash , :credit_card , :cash_and_card , :payment_term ]

  attr_accessor :sent_customer_email
  attr_accessor :print_invoice
  before_validation :parse_payment_term
  before_save   :set_amount_value

  belongs_to :sale
  belongs_to :company
  has_one    :customer , through: :sale

  validates :payment_type ,:amount , presence: :true
  # validates :amount, numericality: { only_integer: true }
  validates :payment_term, allow_nil: true , numericality: { only_integer: true }

  def amount_after_change
    (self.sale.total_amount - self.amount) >= 0 ? self.amount : self.sale.total_amount
  end

  private

  def parse_payment_term
    self.payment_term = self.payment_term.to_i
  end

  def set_amount_value
    self.amount = 0.0 if self.amount.blank?
  end

end
