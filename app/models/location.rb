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
#  slug       :string
#  status     :integer          default(0)
#

class Location < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :company
  belongs_to :address
  has_many   :items , dependent: :destroy
  has_many   :sales
  has_many   :customers
  has_many   :active_users , class_name: 'User' , foreign_key: 'location_id'
  has_and_belongs_to_many :users

  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :address , allow_destroy: true , reject_if: :all_blank

  default_scope {order(created_at: :asc)}
  scope :published , -> {where(published: true)}

  def full_address
    return name + address.full_address
  end

  def name
    self.new_record? ? super : self.company.company_name
  end

  #
  # def is_main_location?
  #   company.locations.first == self || company.locations.blank?
  # end

  private

  def should_generate_new_friendly_id?
    name_changed? || super
  end

end
