class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = @store.customers.paginate(page: params[:page], per_page: 20).where(published: true)
  end

  def new
    @customer = @store.customers.new
  end

  def show
  end

  def edit
    @customer = @store.customers.find(params[:id])
  end

  def create
    @customer = @store.customers.new(customer_params)

    if @customer.save
      flash[:notice] = 'Customer was successfully created.'
      redirect_to @customer
    else
      render action: 'new'
    end
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = 'Customer was successfully updated.'
      redirect_to @customer
    else
      render action: 'edit'
    end
  end

  def destroy
    @customer.published = false
    @customer.save

    redirect_to customers_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = @store.customers.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:first_name,
                                     :store_id,
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
