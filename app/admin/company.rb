ActiveAdmin.register Company do

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

  permit_params :company_name , :country , :company_description , :company_name , :logo , :business_type_id

  index do
    selectable_column
    column :company_name
    column :owner
    column :country
    column :logo
    column :created_at
    actions
  end

  show do |company|
    attributes_table do
      row :company_name
      row :owner
      row :business_type
      row :logo do |company|
        company.logo.present? ? image_tag(company.logo): "None"
      end
      # row :tag_line
      row :company_description
      # row :email
      row :address
      row :city
      row :state
      row :zip_code
      row :country
      # row :phone
      row :tax_rate


    end
  end

  form do |f|
    f.inputs "Conpany Information" do

      # f.input :url,:hint => "Website URL"
      f.input :company_name
      f.input :logo,:label => "Website Logo",:hint => "Ideal size for logo is : 398 X 162"
      # f.input :email,:hint => "Website Contact us email"

      # f.input :tag_line, :hint => "Website tag-line or slogon"
      f.input :company_description, :hint => "Description/About Website"

      # f.input :phone,:hint => "Website main phone"

      f.inputs "Address" do
        f.input :address
        f.input :country
        f.input :state
        f.input :city
        # f.input :zip_code
        # f.input :map_url ,:hint => "Google Maps URL Only"
      end
    end
    f.actions
  end



end
