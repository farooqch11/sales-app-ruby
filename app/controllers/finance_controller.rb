class FinanceController < ApplicationController

  before_filter :authorize!

  def index
    @sales         = current_company.sales.joins(:line_items , :payments).includes(:line_items , :payments).distinct || []
    @expenses      = current_company.expenses || []
    @monthly_sales = @sales.group_by { |t| t.created_at.beginning_of_month }
  end

  def financial_position
    if params[:type] == 'year'
      @sales         = current_company.sales.by_year(params[:period]) || []
      @prev_sales     = current_company.sales.less_than_year(params[:period])|| []
      @expenses      = current_company.expenses.by_year(params[:period]) || []
      @prev_expenses = current_company.expenses.less_than_year(params[:period]) || []
    elsif params[:type] == 'month'
      @sales         = current_company.sales.by_month(params[:period].to_date) || []
      @prev_sales    = current_company.sales.less_than_month(params[:period].to_date) || []
      @expenses      = current_company.expenses.by_month(params[:period].to_date) || []
      @prev_expenses = current_company.expenses.less_than_month(params[:period].to_date) || []
    end

    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  private

  def authorize!
    redirect_to :back , notice: "Access Denied" if not current_user.has_access?('finance_dashbored')
  end
  def ajax_refresh
    render 'finance/ajax_reload'
  end

end
