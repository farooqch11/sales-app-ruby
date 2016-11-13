# == Schema Information
#
# Table name: expenses
#
#  id         :integer          not null, primary key
#  company_id :integer
#  attachment :string
#  start_date :date
#  end_date   :date
#  purpose    :text
#  paid_time  :datetime
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_expenses_on_company_id  (company_id)
#

class Expense < ActiveRecord::Base
  belongs_to :company
end
