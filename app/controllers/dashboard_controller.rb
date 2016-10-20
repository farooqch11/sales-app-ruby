class DashboardController < ApplicationController
  def index
    @recent_sales = Sale.all.order('id DESC').limit(10)
    @popular_items = Item.all.order('amount_sold DESC').limit(10)
  end

  def create_sale_with_product
    @sale = Sale.create
    item = Item.find(params[:item_id])

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
    if @store.tax_rate.blank?
      return 0.00
    else
      return @store.tax_rate.to_f * 0.01
    end
  end
end
