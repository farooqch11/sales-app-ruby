# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  company_id             :integer
#  username               :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  photo                  :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  salary                 :float
#  skills                 :string
#  role_id                :integer
#  location_id            :integer
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email_and_company_id  (email,company_id) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable , :confirmable, :lockable

  validates :username, presence: true , if: Proc.new{ |user| !user.company.present?}

  belongs_to :company
  belongs_to :active_location , class_name: 'Location' , foreign_key: 'location_id'
  has_and_belongs_to_many :locations
  has_and_belongs_to_many :roles
  has_many :sales

  after_create :set_active_location , if: Proc.new{ |user| user.company.present?}

  def is_owner?
    self.company.owner_id == self.id ? true : false
  end

  def has_access?(role)
    return true if self.is_owner?
    self.role.permissions.map(&:name).include?(role)
  end
  # def set_user_role
  #
  #   self.can_update_sale_discount = false
  #   self.can_update_users         = false
  #   self.can_update_items         = false
  #   self.can_update_configuration = false
  #   self.can_view_reports         = false
  #   self.can_remove_sales         = false
  #
  #   if self.is_general_manager?
  #     self.can_update_sale_discount = true
  #     self.can_update_users         = true
  #     self.can_update_items         = true # D
  #     self.can_update_configuration = true
  #     self.can_view_reports         = true
  #     self.can_remove_sales         = true
  #   elsif self.is_store_manager?
  #     self.can_update_users         = true # E
  #     self.can_update_items         = true # D
  #     self.can_remove_sales         = true # I
  #   elsif self.is_cashier?
  #     self.can_remove_sales         = true # I
  #   elsif self.is_inventory_manager?
  #     self.can_update_items         = true # D
  #   elsif self.is_warehouse_manager?
  #     self.can_update_items         = true # D
  #   end
  # end

  def is_general_manager?
    self.roles.map(&:name).include?("General Manager")
  end

  def is_cashier?
    self.roles.map(&:name).include?("Cashier")
  end

  def is_inventory_manager?
    self.roles.map(&:name).include?("Inventory Manager")
  end

  def is_store_manager?
    self.roles.map(&:name).include?("Store Manager/ Supervisor")
  end

  def is_warehouse_manager?
    self.roles.map(&:name).include?("Warehouse manager")
  end

  def is_customer_service_manager?
    self.roles.map(&:name).include?("Customer Service Manager")
  end


  def company_name
    self.company.company_name.blank? ? "Managehub360 Point of Sale" : self.company.company_name
  end


  def company_description
    self.company.company_description.blank? ? "Managehub360 Point of Sale" : self.company.company_description
  end

  def photo
    super.present? ?  super : "gravatar/gravatar_#{(1..15).to_a.sample(1).first}.png"
  end

  def tend360_url
    Rails.env.development? ? "localhost:3000" : "managehub360.com"
  end

  def base_url
    Rails.env.development? ? "localhost:3000" : "managehub360.com"
  end

  def set_username
    self.username = self.email
  end


  private

    def set_active_location
      self.update_attribute!(:location_id, self.locations.published.first.id)
    end
end
