# == Schema Information
#
# Table name: sites
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  logo         :string
#  url          :string
#  facebook_url :string
#  google_url   :string
#  twitter_url  :string
#  map_url      :string
#  description  :text
#  email        :string
#  phone        :string
#  tag_line     :string
#  city         :string
#  state        :string
#  zip_code     :string
#  country      :string
#  address      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Site < ActiveRecord::Base

  mount_uploader :logo, AttachmentUploader

  #Validations
  # validates :there_can_only_be_one_site
  validates :name, :logo , presence: true

  private

  def there_can_only_be_one_site
    errors.add('There can only be one Site Configuration ') if Site.count > 0
  end


end
