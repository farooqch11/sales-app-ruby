class FinanceController < ApplicationController

  def index
    @sales         = current_company.sales.by_year(Date.today.year) || []
    @expenses      = current_company.expenses.by_year(Date.today.year) || []
    @monthly_sales = @sales.group_by { |t| t.created_at.beginning_of_month }
    @prev_sales    = current_company.sales.less_than_year(Date.today.year)|| []
    @prev_expenses = current_company.expenses.less_than_year(Date.today.year) || []
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
    else
      @sales         = current_company.sales.joins(:line_items , :payments).includes(:line_items , :payments).distinct || []
      @expenses      = current_company.expenses || []
    end
    type = params[:type]
    period = params[:period]
                 # sale



    respond_to do |format|
      format.js { ajax_refresh }
    end
  end

  private
  def ajax_refresh
    render 'finance/ajax_reload'
  end

end
