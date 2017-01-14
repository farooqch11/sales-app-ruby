# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  company_id :integer
#  name       :string
#  address_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  published  :boolean          default(TRUE)
#

class Location < ActiveRecord::Base

  #Association
  belongs_to :company
  belongs_to :address
  has_many   :items , dependent: :destroy
  has_many   :sales , dependent: :destroy
  has_many   :active_users , class_name: 'User' , foreign_key: 'location_id'
  has_and_belongs_to_many :users
  has_many   :customers

  #Validations
  validates_presence_of :name

  #Nested Attributes
  accepts_nested_attributes_for :address , allow_destroy: true , reject_if: :all_blank

  #Scopes
  default_scope {order(name: :asc)}
  scope :published , -> {where(published: true)}

  #Public Methods
  def full_address
    return "#{name} " + address.full_address
  end
  #
  # def is_main_location?
  #   company.locations.first == self || company.locations.blank?
  # end
end
