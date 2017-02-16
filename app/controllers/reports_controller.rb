class ReportsController < ApplicationController

  add_breadcrumb "REPORTS", "#" , options: { title: "REPORTS"}

  has_scope :by_location

  def index
    @today_sales = current_company.sales.today_payments || []
    @total_sales = current_company.sales.joins(:payments).distinct.paginate(page: params[:page], per_page: 2).order(id: :desc) || []
    respond_to do |format|
      format.html
      format.csv { send_data @today_sales.to_csv, filename: "sale-#{Date.today}.csv" }
    end
  end

  def inventory

  end

  def dead_inventory
    add_breadcrumb "DEAD INVENTORY", "#" , options: { title: "DEAD INVENTORY"}

  end

  def sales
    add_breadcrumb "SALES", "#" , options: { title: "SALES"}
    # current_company.sales.joins(:payments).distinct.includes(:location , :payments , :customer).paginate(page: params[:page], per_page: 20).order(id: :desc) || []
    # @sales = current_company.sales.joins(:payments).distinct.includes(:location , :payments , :customer).where(nil)
    @search = current_company.sales.joins(:payments).distinct.includes(:location , :payments , :customer).search(params[:q])

    # @search.build_condition
    @search.build_sort if @search.sorts.empty?
    @file_name = params[:q].present? ? "Sales Report [#{params[:q][:created_at_gteq]}  - #{params[:q][:created_at_lteq]}]" : "Sales Report"
    respond_to do |format|
      format.html{
        @sales = @search.result(distinct: true).paginate(page: params[:page], per_page: 50)
      }
      format.xls{
        @sales = @search.result(distinct: true)
      }
      format.csv {
        @sales = @search.result(distinct: true)
        send_data  @sales.to_csv, filename: @file_name+".csv" }
      format.pdf do
        @sales = @search.result(distinct: true)
        render pdf: @file_name,
               orientation: 'Landscape', encoding: 'UTF-8',
               disposition: 'attachment',
               title: @file_name
      end
    end
    end
   def get_employee_list_location

   end

end
