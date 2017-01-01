module FinanceHelper

  # INCOME STATEMENT

  def total_earnings sales
    return 0.0 if sales.empty?
    sales.sum('payments.amount')
  end

  def other_income sales
    return 0.00
  end

  def total_cost_of_sale sales
    return 0.0 if sales.empty?
    sales.sum('line_items.total_cost_price')
  end

  def gross_profit sales
    return 0.0 if sales.empty?
    total_earnings(sales) + other_income(sales) - total_cost_of_sale(sales)
  end

  #EXPENSES

  def expenses(expenses)
    return 0.0 if expenses.empty?
    expenses.sum(:amount)
  end

  def expense_payment
    0.0
  end

  def total_expenses expenses
    return 0.0 if expenses.empty?
    expenses(expenses) + expense_payment
  end


  #TAX EXPENSES

  def total_tax sales
    return 0.0 if sales.empty?
    sales.sum(:tax)
  end

  # NET PROFIT
  def net_profit sales , expenses
    gross_profit(sales) - total_tax(sales) - total_expenses(expenses)
  end

  #BALANCE SHEET

  def pending_balance
    0.00
  end

  def account_receiveable
    0.00
  end

  def balance_sheet(sales ,expenses)
    net_profit(sales ,expenses)
  end

  #PENDING BALANCE

  #NET POSITION

  def net_position(sales,expenses)
    net_profit(sales , expenses)
  end

end
