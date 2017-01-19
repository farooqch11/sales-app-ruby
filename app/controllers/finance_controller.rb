class FinanceController < ApplicationController

  before_filter :authorize!
  include ConfigurationHelper

  def index
    @sales         = Sale.all || []
    @expenses      = current_company.expenses || []
    @monthly_sales = @sales.group_by { |t| t.created_at.beginning_of_month }
    @charts = finance_chart_by_year(@sales , @expenses , 12.months.ago)
  end

  def financial_position
    if params[:type] == 'year'
      @sales         = current_company.sales.by_year(params[:period]) || []
      @prev_sales    = current_company.sales.less_than_year(params[:period])|| []
      @expenses      = current_company.expenses.by_year(params[:period]) || []
      @prev_expenses = current_company.expenses.less_than_year(params[:period]) || []
      @charts        = finance_chart_by_year(@sales , @expenses , Date.new(params[:period].to_i).beginning_of_year , Date.new(params[:period].to_i).end_of_year)
    elsif params[:type] == 'month'
      @sales         = current_company.sales.by_month(params[:period].to_date) || []
      @prev_sales    = current_company.sales.less_than_month(params[:period].to_date) || []
      @expenses      = current_company.expenses.by_month(params[:period].to_date) || []
      @prev_expenses = current_company.expenses.less_than_month(params[:period].to_date) || []
      @charts        = finance_chart_by_month(@sales , @expenses , params[:period].to_date)
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
