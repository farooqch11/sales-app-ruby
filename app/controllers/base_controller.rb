class BaseController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_company

  # before_filter :authenticate_user!
  # before_filter :set_configurations

  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_url, alert: exception.message
  # end

  private

  ##
  # set_configurations loads the global store companies.
  def set_company
    # companies = Company.where(sub_domain: request.subdomain)
    companies = Company.where(sub_domain: request.subdomain) || []
    if companies.count > 0
      @company = companies.first
    elsif request.subdomain != "www"
      redirect_to root_url(subdomain: 'www')
    end
  end
end
