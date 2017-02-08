class DashboardController < ApplicationController

  # before_filter :is_authorize!

  def index
    @recent_sales  = current_company.sales.joins(:payments).order('sales.id DESC').limit(10) || []
    @popular_items = current_company.items.all.published.order('amount_sold DESC').limit(10) || []
    @recent_expenses =  current_company.expenses.all.order(id: :desc).limit(10) || []
    @low_stock_items = current_company.low_stock_items.limit(10) || []
  end

  def change_location
    location = current_user.locations.find_by_id(params[:change_location][:location_id]) || []
    if location.present?
    current_user.update_attributes(location_id: location.id)
      flash[:success] = "Location Successfully Changed."
    else
      flash[:error] = "Error!"
    end
    redirect_to :back
  end

  def finance
    @sales = current_company.sales.joins(:line_items , :payments).includes(:line_items , :payments).distinct || []
    @expenses = current_company.expenses || []
    # @payments = current_company.payments || []
    @monthly_sales = @sales.group_by { |t| t.created_at.beginning_of_month }
  end

  def financial_position
    @sales = current_company.sales.joins(:line_items , :payments).includes(:line_items , :payments).distinct || []
    @expenses = current_company.expenses || []
  end

  def create_sale_with_product
    @sale = current_company.sales.create
    item  = current_company.items.find_by_id(params[:item_id])

    LineItem.create(item_id: params[:item_id].to_i,
                    quantity: params[:quantity].to_i,
                    price: item.price,
                    total_price: item.price * params[:quantity].to_i,
                    sale_id: @sale.id)

    price = (item.price * params[:quantity].to_i)

    @sale.tax = price * get_tax_rate
    @sale.amount = price
    @sale.total_amount = price + (price * get_tax_rate)
    @sale.save

    redirect_to controller: 'sales', action: 'edit', id: @sale.id
  end

  def get_tax_rate
    current_company.tax_rate.blank? ? 0.00 : current_company.tax_rate.to_f * 0.01
  end
end
