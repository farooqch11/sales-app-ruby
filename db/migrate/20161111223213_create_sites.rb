class CreateSites < ActiveRecord::Migration

  # def migrate(direction)
  #   super
  #   # Create a default Site Setting
  #   #  Site.create!(name: 'ManageHub360', email: 'info@managehub360.com', logo: 'logo-white.png') if direction == :up
  # end

  def change
    create_table :sites do |t|

      t.string :name , null: false
      t.string :logo
      t.string :url
      t.string :facebook_url
      t.string :google_url
      t.string :twitter_url
      t.string :map_url
      t.text   :description
      t.string :email
      t.string :phone
      t.string :tag_line
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country
      t.string :address


      t.timestamps null: false
    end
  end
end
