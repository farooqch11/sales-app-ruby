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

  def create
    @expense = current_company.expenses.new(expense_params)
    respond_to do |format|
      if @expense.save
        flash.now[:success] = "Expense was successfully created."
        format.html { redirect_to :back }
        # format.json { render :show, status: :created, location: @expense }
         format.js
      else
        flash.now[:errors] = @expense.errors.full_messages
        format.html { render :new }
        # format.json { render json: @expense.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        flash.now[:success] = "Expense was successfully updated."
        format.html { redirect_to expenses_path }
        format.js
        # format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        flash.now[:errors] = @expense.errors.full_messages
        format.js
        # format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
      format.js
    end

  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      # format.json { head :no_content }
      format.js
    end
  end

  private

    def ajax_refresh
      render 'template/ajax_reload' , url: expense_path
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = current_company.expenses.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:attachment,:payment_method , :ref_no ,:start_date, :end_date, :purpose,:amount , :paid_time, :expense_type)
    end
end
