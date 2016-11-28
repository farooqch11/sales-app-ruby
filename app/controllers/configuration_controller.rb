class ConfigurationController < ApplicationController

  def edit
    add_breadcrumb current_company.company_name.titleize, '#', options: { title: current_company.company_name.titleize }
    add_breadcrumb "EDIT", '#', options: { title: "COMPANY EDIT" }
  end

  def update
    if current_company.update(company_params)
      flash[:success] = 'Configurations have been successfully updated.'
      redirect_to configuration_path
    else
      flash[:errors] = current_company.errors.full_messages
      render 'edit'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:company_name ,:email,:currency ,:currency_code , :currency_name , :phone ,:low_stock_alert , :company_description ,:logo ,:city , :address , :tax_rate , :state , :zip)
    # :store_description,
    # :sub_domain,
    # :address,
    # :city,
    # :state,
    # :zip,
    # :currency,
    # :tax_rate)

    #  id                  :integer          not null, primary key
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
  end
end
