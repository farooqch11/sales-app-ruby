class PaymentsController < ApplicationController
   before_action :set_sale , only: [:make_payment]

  def make_payment
    amount = params[:payments][:amount].delete("^0-9.").to_d
    @sale.payments.create(payment_type: params[:payments][:payment_type], amount: amount)
    respond_to do |format|
      format.js
    end
  end

  private

   def set_sale
     @sale = current_company.sales.find_by_id(params[:payments][:sale_id])
   end

  def payment_params
    params.require(:payment).permit(:payment_type, :amount, :sale_id)
  end
end
