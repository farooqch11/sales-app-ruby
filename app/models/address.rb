# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  address_1  :string
#  address_2  :string
#  city       :string
#  state      :string
#  country    :string
#  zip        :string
#  status     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Address < ActiveRecord::Base

  has_one :customer
  has_one :location

  def full_address
    return "#{address_1}, #{city}, #{country}" if self.address_1 && city && country
    return "#{city}, #{country}" if city && country
    return "#{state}, #{country}" if state && country
    return "#{country}" if country
  end
end
