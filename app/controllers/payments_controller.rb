class PaymentsController < ApplicationController
   before_action :set_sale , only: [:make_payment]

  def make_payment
    # amount = params[:payments][:amount].delete("^0-9.").to_d
    respond_to do |format|
    @payment = @sale.payments.new(payment_term: params[:payments][:payment_term] , payment_type: params[:payments][:payment_type], amount: @sale.remaining_balance)
      if @payment.save
        if params[:payments][:sent_customer_email] == "true" && @sale.customer.present? && @sale.customer.email_address.present?
          UserMailer.send_sale_invoice_to_customer(@sale).deliver
        end
        format.js {flash[:success] = "Success!"}
      else
        format.js {flash[:errors] = @payment.errors.full_messages}
      end
    end
  end

  private

   def set_sale
     @sale = current_company.sales.find_by_id(params[:sale_id]) || []
   end

  def payment_params
    params.require(:payment).permit(:payment_type, :payment_term , :print_invoice , :sent_customer_email , :amount)
  end
end
