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
#  low_stock_alert     :integer
#  email               :string
#  phone               :string
#  is_activated        :boolean          default(TRUE)
#  currency_name       :string
#  currency_code       :string
#

class Company < ActiveRecord::Base

  # validates :store_name , :sub_domain , presence: true, uniqueness: true

  #Image Uploading
  mount_uploader :logo , AttachmentUploader

  # Assiciations
  has_many :users , dependent: :destroy
  has_many :customers , -> { order(created_at: :desc) }  , dependent: :destroy
  has_many :item_categories , dependent: :destroy
  has_many :items , dependent: :destroy
  has_many :sales
  has_many :expenses, dependent: :destroy
  has_many :payments, :through => :sales
  has_many :line_items, :through => :sales
  has_many :locations , -> { order(created_at: :desc) } ,dependent: :destroy

  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :business_type

  #Validations
  validates :company_name,presence: true,uniqueness: {case_sensitive: false}
  validates_length_of :company_name, :minimum => 3,:message => "must be atleat 3 characters"
  validates_length_of :company_name, :maximum => 50,:message => "can have maximum of 50 characters"
  validates :sub_domain , uniqueness: true

  accepts_nested_attributes_for :owner
  accepts_nested_attributes_for :locations

  after_create :set_owner_company_id
  before_create :set_company_domian
  before_create :set_currency
  after_create  :set_head_office_location

  # def logo
  #   super.present? ? super : 'logo.png'
  # end

  def low_stock_items
    low_stock = self.low_stock_alert.present? ? self.low_stock_alert : 10
    self.items.published.where('items.stock_amount <= ?' , low_stock) || []
  end

  def name
    self.company_name.humanize
  end

  def get_report_month_list
    (self.created_at.to_date..Time.zone.now.to_date).map{ |m| [m.strftime('01/%m/%Y') , m.strftime('%b %Y')] }.uniq
  end

  def get_report_year_list
    (self.created_at.to_date..Time.zone.now.to_date).map{ |m| m.strftime('%Y') }.uniq.map{ |m| m }.reverse
  end

  def get_report_quater_list
    (self.created_at.to_date..Time.zone.now.to_date).map{ |m| m.strftime('%Y') }.uniq.map{ |m| m }.reverse
  end

  def get_country
    ISO3166::Country.find_country_by_alpha2(self.country.upcase)
  end

  # def tax_rate
  #   self.tax_rate.blank? ? 'not configured' : self.tax_rate
  # end

  # def tax_rate
  #   self.tax_rate.blank? ? 0.00 : self.tax_rate.to_f * 0.01
  # end

  def currency_code
    super.present? ? super.upcase : ISO3166::Country.find_country_by_alpha2(self.country.upcase).currency.code.upcase
  end

  private

  def set_owner_company_id
    self.owner.update_columns({company_id: id ,role_id: Role.general_manager.id, can_update_users: true , can_update_items: true , can_update_configuration: true , can_view_reports: true , can_update_sale_discount: true , can_remove_sales: true})
  end

  def set_company_domian
    self.sub_domain = self.company_name.parameterize("").gsub("_","-")
  end

  def set_currency
    c = ISO3166::Country.find_country_by_alpha2(country.upcase)
    self.currency      = c.currency.symbol
    self.currency_name = c.currency.name
    self.currency_code = c.currency.code
  end


  def set_head_office_location
    address              = Address.create!({country: self.country })
    location             = self.locations.new
    location.name        = self.company_name.titleize + " Head Office"
    location.address_id  = address.id
    location.save
    self.owner.update_attributes({location_id: location.id})
  end

end
