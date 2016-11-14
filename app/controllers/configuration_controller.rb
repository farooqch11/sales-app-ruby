class ConfigurationController < ApplicationController
  def index

  end

  def update
    if current_company.update(company_params)
      flash[:success] = 'Configurations have been successfully updated.'
      redirect_to configuration_index_path
    else
      flash[:errors] = current_company.errors.full_messages
      render 'index'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:company_description ,:logo ,:city , :address , :tax_rate , :state , :zip)
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
