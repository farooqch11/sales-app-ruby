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


  # validates :username, :presence => true, :uniqueness => true
  belongs_to :company

  before_create :set_confirm_password

  before_create :set_username

  def is_owner?
    self.company.owner_id == self.id ? true : false
  end

  def company_name
    self.company.company_name.blank? ? "Tend360 Point of Sale" : self.company.company_name
  end

  def company_description
    self.company.company_description.blank? ? "Tend360 Point of Sale" : self.company.company_description
  end

  def photo
    super.present? ?  super : "gravatar/gravatar_#{(1..15).to_a.sample(1).first}.png"
  end

  def tend360_url
    Rails.env.development? ? self.company.sub_domain + ".lvh.me:3000" : "tend360.herokuapp.com"
  end

  def set_username
    self.username = self.email
  end


  private
    def set_confirm_password
    end
end
