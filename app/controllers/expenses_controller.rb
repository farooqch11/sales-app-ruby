class ExpensesController < ApplicationController

  # before_filter :has_access?('expenses')

  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  add_breadcrumb 'EXPENSES', '#' , options: { title: 'EXPENSES' }


  # GET /expenses
  # GET /expenses.json
  def index
    @search = current_company.expenses.search(params[:q])
    @expenses = @search.result.paginate(page: params[:page], per_page: 20) || []
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  def new
    add_breadcrumb 'NEW EXPENSE', new_expense_path , options: { title: 'NEW EXPENSE' }
    @expense = current_company.expenses.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = current_company.expenses.new(expense_params)
    respond_to do |format|
      if @expense.save
        format.html { redirect_to :back , notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update

    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = current_company.expenses.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:attachment,:payment_method , :ref_no ,:start_date, :end_date, :purpose,:amount , :paid_time, :expense_type)
    end
end
