# == Schema Information
#
# Table name: companies
#
#  id                  :integer          not null, primary key
#  company_name        :string
#  business_type_id    :integer
#  company_description :text
#  logo                :string
#  sub_domain          :string
#  country             :string
#  address             :string
#  city                :string
#  state               :string
#  zip                 :string
#  currency            :string
#  tax_rate            :decimal(8, 2)
#  owner_id            :integer
#  integer             :integer
#  status              :boolean          default(FALSE)
#  created_at          :datetime
#  updated_at          :datetime
#

class Company < ActiveRecord::Base

  # validates :store_name , :sub_domain , presence: true, uniqueness: true

  has_many :users , dependent: :destroy
  has_many :customers , dependent: :destroy
  has_many :item_categories , dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :business_type

  validates :company_name,presence: true,uniqueness: {case_sensitive: false}
  validates_length_of :company_name, :minimum => 3,:message => "must be atleat 3 characters"
  validates_length_of :company_name, :maximum => 50,:message => "can have maximum of 50 characters"
  validates :sub_domain ,:uniqueness => true

  accepts_nested_attributes_for :owner

  after_create :set_owner_company_id

  before_create :set_company_domian

  def logo
    super.present? ? super : 'logo.png'
  end

  private

  def set_owner_company_id
    self.owner.update_columns({company_id: id , can_update_users: true , can_update_items: true , can_update_configuration: true , can_view_reports: true , can_update_sale_discount: true , can_remove_sales: true})
  end

  def set_company_domian
    self.sub_domain = self.company_name.parameterize("").gsub("_","-")
  end
end
