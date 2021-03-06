class CompaniesController < BaseController
  layout :set_layout , only: [:show]
  before_action :set_new_company , only: [:new]

  before_filter :authenticate_user! , only: [:show]

  def new
  end

  def show

   end

  def create

    @company = Company.new(store_params)
    if verify_recaptcha(model: @company) && @company.valid? && @company.owner.valid? && @company.save
      # @company.time_zone = cookies["browser.timezone"] if cookies["browser.timezone"].present?
      flash[:success] =  "Registration Successfull. Please confirm your email In order to access your account."
      redirect_to root_path
    else
      flash.now[:errors] = @company.errors.full_messages + @company.owner.errors.full_messages
      return render 'new'
    end
  end
  def index
    # @configuration = StoreConfiguration.last
    # @configuration = @configuration.new
    # authorize! :read, @configuration
  end

  def update
    # authorize! :read, current_user


  end

  private

  def set_new_company
    @company = Company.new
    @company.build_owner(role_id: Role.general_manager.id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_configuration
    @configuration = current_company
  end

  def set_layout
     'application'
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def store_params
    params.require(:company).permit(:company_name,:business_type_id , :country , owner_attributes:[:id, :email, :password, :role_id ,:username,:password_confirmation])
                                                # :store_description
                                                # :sub_domain,
                                                # :address,
                                                # :city,
                                                # :state,
                                                # :zip,
                                                # :currency,
                                                # :tax_rate)
  end
end
