class CustomersController < ApplicationController

  #CallBacks
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # BreadCrumbs
  add_breadcrumb "CUSTOMERS", '#' , options: { title: 'CUSTOMERS' }

  def index
    @customers = current_company.customers.paginate(page: params[:page], per_page: 20).where(published: true)
    @customer = current_company.customers.new
    @customer.build_address
  end

  def new
    add_breadcrumb "NEW", new_customer_path , options: { title: "CUSTOMER NEW" }
    @customer = current_company.customers.new
    @customer.build_address
  end

  def show
  end

  def edit
    @customer = current_company.customers.find(params[:id])
    add_breadcrumb "EDIT", edit_customer_path(@customer) , options: { title: "CUSTOMER EDIT" }
  end

  def create
    @customer = current_company.customers.new(customer_params)
    if @customer.save
      flash[:success] = 'Customer was successfully created.'
      redirect_to :back
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
    @customer = current_company.customers.find_by_id(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit([:published ,:first_name,
                                     :company_id,
                                     :last_name,
                                     :phone_number,
                                     :email_address,
                                     address_attributes: [
                                     :id,
                                     :address_1,
                                     :country,
                                     :city,
                                     :state,
                                     :zip , :_destroy]]).merge!(location_id: current_location.id)
  end
end
