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
#
# Indexes
#
#  index_expenses_on_company_id  (company_id)
#

class Expense < ActiveRecord::Base

  #Image Uploading
  # mount_uploader :attachment, AttachmentUploader
  belongs_to :company

  # User Avatar Validation
  # validates_integrity_of  :attachment
  # validate :image_size_validation
  validates :amount, numericality: { message: "%{value} seems wrong" }
  validates :expense_type , presence: true

  # scope :by_year, lambda { |year| where("cast(strftime('%Y', expenses.created_at) as int) = ?", year) }
  scope :by_year, lambda { |year| where("extract(year from expenses.created_at) = ?", year) }
  # scope :less_than_year, lambda { |year| where("cast(strftime('%Y', expenses.created_at) as int) < ?", year) }
  scope :less_than_year, lambda { |year| where("extract(year from expenses.created_at) < ?", year) }
  scope :by_month, lambda { |month| where("expenses.created_at > ? AND expenses.created_at < ?",month.beginning_of_month, month.end_of_month) }
  scope :less_than_month, lambda { |month| where("expenses.created_at < ?",month.beginning_of_month) }

  def self.total_on(strat_date , end_date)
    where("date(expenses.created_at) >= ? and date(expenses.created_at) <= ?" , strat_date , end_date).sum("expenses.amount")
  end



  private
  def image_size_validation
    errors[:attachment] << "should be less than 500KB" if attachment.size > 0.5.megabytes
  end


end
