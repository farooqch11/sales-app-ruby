class ReportsController < ApplicationController
  def index
    @today_sales = current_company.sales.today_payments || []
    @total_sales = current_company.sales.joins(:payments).distinct.paginate(page: params[:page], per_page: 2).order(id: :desc) || []
    respond_to do |format|
      format.html
      format.csv { send_data @today_sales.to_csv, filename: "sale-#{Date.today}.csv" }
    end
  end

  def sales
    @sales = current_company.sales.joins(:payments).distinct.paginate(page: params[:page], per_page: 20).order(id: :desc) || []
    respond_to do |format|
      format.html
      format.xls
      format.csv { send_data Sale.all.to_csv, filename: "sale-#{Date.today}.csv" }
      format.pdf do
        render :pdf => "report", :layout => 'pdf.html.haml'
      end
    end
  end
   def get_employee_list_location

   end
end
