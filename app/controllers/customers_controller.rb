class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = current_company.customers.paginate(page: params[:page], per_page: 20).where(published: true)
  end

  def new
    @customer = current_company.customers.new
  end

  def show
  end

  def edit
    @customer = current_company.customers.find(params[:id])
  end

  def create
    @customer = current_company.customers.new(customer_params)

    if @customer.save
      flash[:success] = 'Customer was successfully created.'
      redirect_to @customer
    else
      flash[:errors] = @customer.errors.full_messages
      render action: 'new'
    end
  end

  def update
    if @customer.update(customer_params)
      flash[:success] = 'Customer was successfully updated.'
      redirect_to @customer
    else
      flash[:errors] = @customer.errors.full_messages
      render action: 'edit'
    end
  end

  def destroy
    @customer.published = false
    @customer.save
    flash[:success] = 'Successfully Deleted.'
    redirect_to customers_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = current_company.customers.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:first_name,
                                     :company_id,
                                     :last_name,
                                     :phone_number,
                                     :email_address,
                                     :address,
                                     :city,
                                     :state,
                                     :zip,
                                     :published)
  end
end
