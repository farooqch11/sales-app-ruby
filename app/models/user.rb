# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  company_id               :integer
#  username                 :string           default(""), not null
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  photo                    :string
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string
#  last_sign_in_ip          :string
#  confirmation_token       :string
#  confirmed_at             :datetime
#  confirmation_sent_at     :datetime
#  unconfirmed_email        :string
#  failed_attempts          :integer          default(0), not null
#  unlock_token             :string
#  locked_at                :datetime
#  can_update_users         :boolean          default(FALSE)
#  can_update_items         :boolean          default(TRUE)
#  can_update_configuration :boolean          default(FALSE)
#  can_view_reports         :boolean          default(FALSE)
#  can_update_sale_discount :boolean          default(FALSE)
#  can_remove_sales         :boolean          default(FALSE)
#  created_at               :datetime
#  updated_at               :datetime
#  salary                   :float
#  skills                   :string
#  role_id                  :integer
#
# Indexes
#
#  index_users_on_company_id            (company_id)
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable , :confirmable, :lockable


  validates :username, presence: true

  #Associations
  belongs_to :company
  belongs_to :role
  has_and_belongs_to_many :locations
  has_many :sales


  before_create :set_confirm_password

  before_validation :set_username

  # after_create  :set_user_role

  before_save :set_user_role

  def is_owner?
    self.company.owner_id == self.id ? true : false
  end

  def has_access?(role)
    return true if self.is_owner?
    self.role.permissions.map(&:name).include?(role)
  end
  def set_user_role

    self.can_update_sale_discount = false
    self.can_update_users         = false
    self.can_update_items         = false
    self.can_update_configuration = false
    self.can_view_reports         = false
    self.can_remove_sales         = false

    if self.is_general_manager?
      self.can_update_sale_discount = true
      self.can_update_users         = true
      self.can_update_items         = true # D
      self.can_update_configuration = true
      self.can_view_reports         = true
      self.can_remove_sales         = true
    elsif self.is_store_manager?
      self.can_update_users         = true # E
      self.can_update_items         = true # D
      self.can_remove_sales         = true # I
    elsif self.is_cashier?
      self.can_remove_sales         = true # I
    elsif self.is_inventory_manager?
      self.can_update_items         = true # D
    elsif self.is_warehouse_manager?
      self.can_update_items         = true # D
    end
  end

  def is_general_manager?
    self.role_id == Role.general_manager.id
  end

  def is_cashier?
    self.role_id == Role.cashier.id
  end

  def is_inventory_manager?
    self.role_id == Role.inventory_manager.id
  end

  def is_store_manager?
    self.role_id == Role.store_manager.id
  end

  def is_warehouse_manager?
    self.role_id == Role.warehouse_manager.id
  end

  def is_customer_service_manager?
    self.role_id == Role.customer_service_manager.id
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
    Rails.env.development? ? self.company.sub_domain + ".lvh.me:3000" : "managehub360.herokuapp.com"
  end

  def set_username
    self.username = self.email
  end


  private
    def set_confirm_password
    end
end
