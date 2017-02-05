module ApplicationHelper

  def link_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def disable_spinning text
    return "<i class='fa fa-spinner fa-spin pull-left'></i> #{text}"
  end

  def raw_sales
    sales = current_company.sales || []
    total = 0.00
    for sale in sales
      unless sale.total_amount.blank?
        total += sale.total_amount
      end
    end
    return total
  end


  def payment_total
    payments = current_company.payments || []
    payment_total = 0.00
    for payment in payments
      payment_total += payment.amount.blank? ? 0.00 : payment.amount_after_change
    end
    return payment_total
  end


  def owed_balance
    raw_sales - payment_total
  end


  def sales_total_today
    total = 0.00
    sales = current_company.payments.where("payments.created_at >= ?", Time.zone.now.beginning_of_day) || []
    for sale in sales
      total += sale.amount
    end
    return total
  end

  def get_http(url)
    unless url.blank? || url.starts_with?("http://") || url.starts_with?("https://")
      url = "http://" + url
    end
    url
  end

  def active_class? controller
    params[:controller] == controller ? 'active' : ''
  end

  def is_active controller
    params[:controller] == controller ? 'active' : ''
  end

  def dashboard_active
    active_class? 'dashboard'
  end

  def users_active
    active_class? 'users'
  end

  def item_categories_active
    params[:controller] == 'item_categories' ||  params[:controller] == 'items' ? 'active' : ''
  end

  def is_setting_active
    params[:controller] == 'configuration' ||  params[:controller] == 'locations' ? 'active' : ''
  end

  def customers_active
    active_class? 'customers'
  end

  def reports_active
    active_class? 'reports'
  end

  def sales_active
    active_class? 'sales'
  end

  def config
    current_company
  end



end
