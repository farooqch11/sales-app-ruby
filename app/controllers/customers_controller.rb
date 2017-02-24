class CustomersController < ApplicationController
  load_and_authorize_resource

  before_action :set_customer, only: [:show, :edit, :update, :destroy ,:create_customer_association]
  before_action :set_sale , only: [:create_customer_association , :add_sale_customer , :create]

  # BreadCrumbs
  add_breadcrumb "CUSTOMERS", '#' , options: { title: 'CUSTOMERS' }

  def index
    @search = current_company.customers.published.search(params[:q])
    @customers = @search.result.includes(:address).paginate(page: params[:page], per_page: 20)
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
    respond_to do |format|
      @customer = current_company.customers.new(customer_params)
      if @customer.save
        @reload = current_company.customers_count == 1

        format.html { redirect_to :back , notice:  'Customer was successfully created.' }
        format.js { flash.now[:success] = 'Customer was successfully created.' }
      else
        format.html { render 'new' , errors:  @customer.errors.full_messages }
        format.js { flash.now[:errors] = @customer.errors.full_messages }
      end
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
    respond_to do |format|
     if @customer.save
       puts @reload = current_company.customers_count == 0
       format.html {redirect_to :back , flash[:success] = 'Successfully Deleted.' }
       format.js {flash.now[:success] = 'Successfully Deleted.' }
     else
       format.html {redirect_to :back , flash[:errors] = @customer.errors.full_messages }
       format.js {flash.now[:errors] = @customer.errors.full_messages }
     end
    end
  end

  def create_customer_association
    respond_to do |format|
      @sale.update_column(:customer_id , @customer.id) if @sale.present? && @customer.present?
      format.js
    end
  end

  def add_sale_customer
    respond_to do |format|
      @available_customers = current_company.customers.published.limit(5) || []
      @customer = current_company.customers.new
      @customer.build_address

      format.js
    end
  end


  private

  def set_customer
    @customer = current_company.customers.find_by_id(params[:id])
  end

  def set_sale
    @sale = params[:sale_id].present? ? current_company.sales.find_by_id(params[:sale_id]) || [] : []
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
