ActiveAdmin.register Site, as: "Configuration" do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  actions :all, :except => [:destroy]
  permit_params :url,:description,:email, :address ,:tag_line ,:phone, :city ,:state, :zip_code,:name,:country, :logo , :facebook_url , :map_url, :google_url ,:twitter_url

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :logo
    column :created_at
    actions
  end

  show do |site|
    attributes_table do
      row :name
      row :url
      row :logo do |site|
        site.logo.present? ? image_tag(site.logo): "None"
      end
      row :tag_line
      row :description
      row :email
      row :address
      row :city
      row :state
      row :zip_code
      row :country
      row :phone
      row :map_url
      row :facebook_url
      row :google_url
      row :twitter_url


    end
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "Website Information" do

      f.input :url,:hint => "Website URL"
      f.input :name
      f.input :logo,as: :file,:label => "Website Logo",:hint => "Ideal size for logo is : 398 X 162"
      # f.input :cover_page, :as => :file, :hint => image_tag(f.object.cover_page.url(:thumb))
      f.input :logo_cache, :as => :hidden
      f.input :email,:hint => "Website Contact us email"

      f.input :tag_line, :hint => "Website tag-line or slogon"
      f.input :description, :hint => "Description/About Website"

      f.input :phone,:hint => "Website main phone"

      f.inputs "Address" do
        f.input :address
        f.input :country
        f.input :state
        f.input :city
        f.input :zip_code
        f.input :map_url ,:hint => "Google Maps URL Only"
      end

      f.inputs "Social Media" do
        f.input :facebook_url,:hint => "Facebook Page"
        f.input :google_url,  :hint => "Google"
        f.input :twitter_url, :hint => "Twitter"
      end
    end
    f.actions
  end


end
