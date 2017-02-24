class SalesController < ApplicationController

  load_and_authorize_resource
  # protect_from_forgery with: :null_session

  before_action :set_sale , except: [:index , :new , :issue_refund]
  before_action :populate_items , only: [:create_custom_customer , :create_custom_item , :empty_cart ,:add_item , :remove_item , :update_line_item_options , :edit , :create_line_item]

  def index
    @sales = current_location.sales.paginate(page: params[:page], per_page: 20).order(id: :desc)
  end

  def new
    sale = current_user.sales.where(location_id: current_location.id).present? && current_user.sales.where(location_id: current_location.id).last.payments.present?
    @sale =  sale ? current_user.sales.create(location_id: current_location.id) : current_user.sales.where(location_id: current_location.id).last
    redirect_to edit_sale_path(@sale)
  end

  def show
    @sale =  current_location.sales.joins(:payments).where('sales.id = ?' , params[:id]).first
    @sales = current_location.sales.joins(:payments).distinct.paginate(page: params[:page], per_page: 20).order(id: :desc)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "report",
               disposition: 'attachment',
               layout: 'pdf.html.erb'
      end
    end
  end

  def edit

    @sale.line_items.build
    @sale.payments.build

    @custom_item = current_location.items.new(company_id: current_company.id)
    @custom_customer = current_company.customers.new

  end

  def destroy
    # set_sale

    if current_user.can_update_items == true
      @sale.destroy
    else
      redirect_to @sale, notice: 'You do not have permission to delete sales.'
    end
    
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale has been deleted.' }
    end
  end

  def issue_refund
    @sale = current_location.sales.unscoped.where(company_id: current_company.id , status: 'paid' , id: params[:id]).first || []
    if @sale.refund!
      line_items = @sale.line_items.includes(:item) || []
      line_items.each do |line_item|
        line_item.item.stock_amount = line_item.item.stock_amount + line_item.quantity
        line_item.item.save
      end
      @sale.update(refund_by: current_user.id)
      flash[:sucess] = "Successfull Refunded"
      @sale = current_location.sales.joins(:payments).last
    else
      flash[:errors] = @sale.errors.full_messages
    end
    redirect_to @sale

  end
  # Generate Invoice
  def invoice
    size = 2
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "invoice-" + @sale.id.to_s,
               disposition: 'inline',
               layout: 'pdf.html.erb',
               margin:  {   top:        size,                     # default 10 (mm)
                     bottom:            size,
                     left:              size,
                     right:             size },
               print_media_type: true
      end
      format.js do

      end
    end
  end

  # searched Items
  def update_line_item_options
    if params[:search][:item_category].blank?
      @available_items = current_location.items.search_by_name(params[:search][:item_name]).published.recent || []
    elsif params[:search][:item_name].blank?
      @available_items = current_location.items.search_by_category(params[:search][:item_category]).recent || []
    else
      @available_items = current_location.items.recent.published.search_by_category(params[:search][:item_category]).search_by_name(params[:search][:item_name]) || []
    end

    respond_to do |format|
      format.js { }
    end
  end

  def update_customer_options
    @available_customers = params[:search][:customer_name] == "" ? current_company.customers.published.limit(5) : current_company.customers.search_all(params[:search][:customer_name]).published.limit(5) || []
    respond_to do |format|
      format.js { }
    end
  end

  # def create_customer_association
  #   # set_sale
  #
  #   unless @sale.blank? || params[:customer_id].blank?
  #     @sale.customer_id = params[:customer_id]
  #     @sale.save
  #   end
  #
  #   respond_to do |format|
  #     format.js { ajax_refresh }
  #   end
  # end

  # Add a searched Item
  def create_line_item
    # set_sale
    # populate_items

    existing_line_item = LineItem.where('item_id = ? AND sale_id = ?', params[:item_id], @sale.id).first

    if existing_line_item.blank?
      line_item = LineItem.new(item_id: params[:item_id], sale_id: params[:sale_id], quantity: params[:quantity])
      line_item.price = line_item.item.price
      line_item.save

      remove_item_from_stock(params[:item_id], 1)
      update_line_item_totals(line_item)
    else
      existing_line_item.quantity += 1
      existing_line_item.save

      remove_item_from_stock(params[:item_id], 1)
      update_line_item_totals(existing_line_item)
    end

    update_totals

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  #Empty Cart
  def empty_cart

    line_items = @sale.line_items.includes(:item) || []
    line_items.each do |line_item|
      line_item.item.stock_amount = line_item.item.stock_amount + line_item.quantity
      line_item.item.save
      line_item.destroy
    end
    # line_item = LineItem.where(sale_id: params[:sale_id], item_id: params[:item_id]).first
    update_totals
    respond_to do |format|
      format.js { ajax_refresh }
    end

  end
  # Remove Item
  def remove_item
    # set_sale
    # populate_items

    line_item = LineItem.where(sale_id: params[:sale_id], item_id: params[:item_id]).first
    line_item.quantity -= 1
    if line_item.quantity <= 0
      line_item.destroy
    else
      line_item.save
      update_line_item_totals(line_item)
    end

    return_item_to_stock(params[:item_id], 1)

    update_totals

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end
  # Remove Item from line item
  def remove_lineitem
    line_item = @sale.line_items.find_by_id(params[:line_item])
    respond_to do |format|
      if line_item.present?
        line_item.item.stock_amount = line_item.item.stock_amount + line_item.quantity
        line_item.item.save
        line_item.destroy
      end
      update_totals

      format.js { ajax_refresh }
    end
  end

  # Add one Item
  def add_item
    # set_sale
    # populate_items

    line_item = LineItem.where(sale_id: params[:sale_id], item_id: params[:item_id]).first
    line_item.quantity += 1
    line_item.save

    remove_item_from_stock(params[:item_id], 1)
    update_line_item_totals(line_item)

    update_totals

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  def create_custom_item
    # set_sale
    # populate_items

    custom_item = current_location.items.new(company_id: current_company.id)
    custom_item.sku = "CI#{(rand(5..30) + rand(5..30)) * 11}_#{(rand(5..30) + rand(5..30)) * 11}"
    custom_item.name = params[:custom_item][:name]
    custom_item.description = params[:custom_item][:description]
    custom_item.price = params[:custom_item][:price]
    custom_item.stock_amount = params[:custom_item][:stock_amount]
    custom_item.item_category_id = params[:custom_item][:item_category_id]

    custom_item.save

    custom_line_item = @sale.line_items.new(item_id: custom_item.id,
                                    quantity: custom_item.stock_amount,
                                    price: custom_item.price)
    custom_line_item.total_price = custom_item.price * custom_item.stock_amount
    custom_line_item.save

    update_totals

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  # update Total For Line Items
  def update_line_item_totals(line_item)
    line_item.total_price = line_item.price * line_item.quantity
    line_item.save
  end

  def override_price
    # @sale = current_company.sales.find(params[:override_price][:sale_id])
    item = current_location.items.where(id: params[:override_price][:item_id]).first
    # line_item = LineItem.where(sale_id: params[:override_price][:sale_id], item_id: item.id).first
    line_item = @sale.line_items.where(item_id: item.id).first
    line_item.price = params[:override_price][:price].gsub('$', '')
    line_item.save

    update_line_item_totals(line_item)
    update_totals

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  def sale_discount
      @sale.discount = params[:discount]
      @sale.save
      update_totals
      respond_to do |format|
        format.js { ajax_refresh }
      end
  end


  def destroy_line_item
    # set_sale
    update_totals

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  def update_totals
    tax_amount = get_tax_rate
    # set_sale

    @sale.amount = 0.00
    @sale.amount = @sale.line_items.sum(:total_price)

    # for line_item in @sale.line_items
    #   @sale.amount += line_item.total_price
    # end

    @sale.tax = @sale.amount * tax_amount
    total_amount = @sale.amount + (@sale.amount * tax_amount)

    @sale.total_amount = @sale.discount.blank? ? total_amount : (total_amount - (total_amount * @sale.discount))

    # if @sale.discount.blank?
    #   @sale.total_amount = total_amount
    # else
    #   discount_amount = total_amount * @sale.discount
    #   @sale.total_amount = total_amount - discount_amount
    # end

    @sale.save
  end

  def add_comment
    # set_sale
    @sale.comments = params[:sale_comments][:comments]
    @sale.save

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  private

  def ajax_refresh
    render 'sales/ajax_reload'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_sale
    @sale = current_location.sales.find_by_id(params[:id] || params[:sale_id] || params[:search][:sale_id] || params[:search][:id]) || []
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sale_params
    params.require(:sale).permit(:amount,
                                 :tax,
                                 :discount,
                                 :total_amount,
                                 :user_id,
                                 :company_id,
                                 :tax_paid,
                                 :amount_paid,
                                 :paid,
                                 :payment_type_id,
                                 :customer_id,
                                 :comments,
                                 :line_items_attributes,
                                 :items_attributes)
  end

  def populate_items
    @available_items = current_location.items.published || []
  end


  def remove_item_from_stock(item_id, quantity)
    item = current_location.items.find(item_id)
    item.stock_amount = item.stock_amount - quantity
    item.amount_sold += quantity
    item.save
  end

  def return_item_to_stock(item_id, quantity)
    item = current_location.items.find(item_id)
    item.stock_amount = item.stock_amount + quantity
    item.save
  end

  def get_tax_rate
    current_company.tax_rate.blank? ? 0.00 : current_company.tax_rate.to_f * 0.01
  end
end
