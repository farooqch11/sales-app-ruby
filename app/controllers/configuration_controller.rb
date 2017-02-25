class ConfigurationController < ApplicationController

  load_and_authorize_resource

  def edit
    add_breadcrumb current_company.company_name.titleize, '#', options: { title: current_company.company_name.titleize }
    add_breadcrumb "EDIT", '#', options: { title: "COMPANY EDIT" }
  end

  def update
    if current_company.update(company_params)
      flash[:success] = 'Configurations have been successfully updated.'
      redirect_to edit_configuration_path(current_company)
    else
      flash[:errors] = current_company.errors.full_messages
      render 'edit'
    end
  end

  private
    def company_params
      params.require(:company).permit(:company_name ,:email ,:currency_code , :currency_name , :phone ,:low_stock_alert , :company_description ,:logo ,:city , :address , :tax_rate , :state , :zip)
      # :store_description,
      # :sub_domain,
      # :address,
      # :city,
      # :state,
      # :zip,
      # :currency,
      # :tax_rate)
    end
end
