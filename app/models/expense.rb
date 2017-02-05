# == Schema Information
#
# Table name: expenses
#
#  id              :integer          not null, primary key
#  company_id      :integer
#  attachment      :string
#  start_date      :date
#  end_date        :date
#  purpose         :text
#  paid_time       :datetime
#  expense_type    :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  low_stock_alert :float
#  amount          :float
#  payment_method  :integer          default(0)
#  ref_no          :string
#  slug            :string
#
# Indexes
#
#  index_expenses_on_company_id  (company_id)
#

class Expense < ActiveRecord::Base

  extend FriendlyId
  friendly_id :expense_type, :use => :slugged

  enum payment_method: ['cash' , 'check' , 'credit_card' , 'debit' , 'electronic_transfer' , 'paypal','ATM_withdrawals']
  belongs_to :company

  # User Avatar Validation
  # validates_integrity_of  :attachment
  # validate :image_size_validation
  validates :amount, numericality: { message: "%{value} seems wrong" }
  validates :expense_type , :attachment , presence: true

  # scope :by_year, lambda { |year| where("cast(strftime('%Y', expenses.created_at) as int) = ?", year) }
  scope :by_year, lambda { |year| where("extract(year from expenses.created_at) = ?", year) }
  # scope :less_than_year, lambda { |year| where("cast(strftime('%Y', expenses.created_at) as int) < ?", year) }
  scope :less_than_year, lambda { |year| where("extract(year from expenses.created_at) < ?", year) }
  scope :by_month, lambda { |month| where("expenses.created_at > ? AND expenses.created_at < ?",month.beginning_of_month, month.end_of_month) }
  scope :less_than_month, lambda { |month| where("expenses.created_at < ?",month.beginning_of_month) }

  acts_as_taggable

  def self.total_on(strat_date , end_date)
    where("date(expenses.created_at) >= ? and date(expenses.created_at) <= ?" , strat_date , end_date).sum("expenses.amount")
  end

  private

  def should_generate_new_friendly_id?
    expense_type_changed? || super
  end

end
