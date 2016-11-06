# == Schema Information
#
# Table name: sales
#
#  id               :integer          not null, primary key
#  amount           :decimal(8, 2)
#  total_amount     :decimal(8, 2)
#  remaining_amount :decimal(, )
#  discount         :decimal(8, 2)
#  tax              :decimal(8, 2)
#  customer_id      :integer
#  comments         :text
#  created_at       :datetime
#  updated_at       :datetime
#  company_id       :integer
#  user_id          :integer
#

class Sale < ActiveRecord::Base
  belongs_to :customer
  has_many :line_items, dependent: :destroy
  has_many :items, through: :line_items
  has_many :connections, through: :customer
  has_many :payments, dependent: :destroy
  belongs_to :company
  belongs_to :user

  accepts_nested_attributes_for :line_items, allow_destroy: true
  accepts_nested_attributes_for :items, allow_destroy: true
  accepts_nested_attributes_for :payments, allow_destroy: true

  before_create :set_company_id



  def remaining_balance
    balance = self.total_amount.blank? ? 0.00 : (self.total_amount - paid_total)
    return balance < 0 ? 0 : balance.round(2)
  end

  def get_discounted_amount
    # self.total_amount * self.discount
    (self.amount + self.tax)  * self.discount
  end

  def paid_total
    paid_total = 0.00
    unless self.payments.blank?
      for payment in self.payments
        paid_total += payment.amount.blank? ? 0.00 : payment.amount
      end
    end
    return paid_total
  end

  def change_due
    if self.total_amount.blank?
      return 0.00
    else
      if paid_total > self.total_amount
        return paid_total - self.total_amount
      else
        return 0.00
      end
    end
  end

  def add_customer(customer_id)
    self.customer_id = customer_id
    self.save
  end

  def final_amount
    self.amount + self.tax - self.get_discounted_amount

  end

  private
    def set_company_id
      self.company = self.user.company
    end
end
