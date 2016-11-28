class UserMailer < ApplicationMailer

  include ActionView::Helpers::NumberHelper
  default from: "from@example.com"
  layout 'mailer'

  def send_sale_invoice_to_customer sale
    @sale     = sale
    @company  = sale.company
    @customer = sale.customer
    mail(to: @customer.email_address, subject: 'Sample Email')
  end
end
