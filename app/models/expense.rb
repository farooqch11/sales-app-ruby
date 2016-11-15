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
  mount_uploader :attachment, AttachmentUploader
  belongs_to :company

  # User Avatar Validation
  validates_integrity_of  :attachment
  validate :image_size_validation

  private
  def image_size_validation
    errors[:attachment] << "should be less than 500KB" if image.size > 0.5.megabytes
  end


end
