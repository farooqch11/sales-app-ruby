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
#  refund_by        :integer
#  status           :integer          default(0)
#

class Sale < ActiveRecord::Base

  #Callbacks
  # validates :discount, numericality: { message: "%{value} seems wrong" } , on: :update
  # validates :tax, numericality: { message: "%{value} seems wrong" } , on: :update
  # validates :remaining_amount, numericality: { message: "%{value} seems wrong" }, on: :update
  # validates :total_amount, numericality: { message: "%{value} seems wrong" }, on: :update
  # validates :amount, numericality: { message: "%{value} seems wrong" }, on: :update

  enum status: [:paid , :refund]

  validates :status , inclusion: {in: statuses.keys}

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
  # after_create  :send_sales_report_to_customer

  default_scope -> {where(status: 'paid')}
  # scope :by_year, lambda { |year| where("cast(strftime('%Y', sales.created_at) as int) = ?", year).joins(:line_items , :payments).includes(:line_items , :payments).distinct }
  scope :by_year, lambda { |year| where('extract(year from sales.created_at) = ?', year).joins(:line_items , :payments).includes(:line_items , :payments).distinct }
  # scope :less_than_year, lambda { |year| where("cast(strftime('%Y', sales.created_at) as int) < ?", year).joins(:line_items , :payments).includes(:line_items , :payments).distinct  }
  scope :less_than_year, lambda { |year| where('extract(year from sales.created_at) < ?', year).joins(:line_items , :payments).includes(:line_items , :payments).distinct  }
  scope :by_month, lambda { |month| where("sales.created_at > ? AND sales.created_at < ?",month.beginning_of_month, month.end_of_month).joins(:line_items , :payments).includes(:line_items , :payments).distinct }
  scope :less_than_month, lambda { |month| where("sales.created_at < ? ",month.beginning_of_month).joins(:line_items , :payments).includes(:line_items , :payments).distinct }




  def remaining_balance
    balance = self.total_amount.blank? ? 0.00 : (self.total_amount - paid_total)
    return balance < 0 ? 0 : balance.round(2)
  end

  def get_discounted_amount
    # self.total_amount * self.discount
    (self.amount + self.tax)  * self.discount
  end

  def paid_total
    paid_total = self.payments.sum(:amount)
    # paid_total = 0.00
    # unless self.payments.blank?
    #   for payment in self.payments
    #     paid_total += payment.amount.blank? ? 0.00 : payment.amount
    #   end
    # end
    return paid_total
  end

  def total_payment
    total_payment = 0.0
    self.payments.each do |payment|
      total_payment += payment.amount.blank? ? 0.00 : payment.amount_after_change
    end
    return total_payment
  end

  def paid?
    self.change_due == 0.0
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

  def total_profit
    # profit = 0.0
    # line_items = self.line_items || []
    # line_items.each do |line_item|
    #   profit += line_item.profit
    # end
    # return profit
    paid_total - self.line_items.sum(:total_cost_price)

  end

  def final_amount
    self.amount + self.tax - self.get_discounted_amount

  end

  private
    def set_company_id
      self.company = self.user.company
    end
end
