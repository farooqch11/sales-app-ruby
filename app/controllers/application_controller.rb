class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  before_filter :set_company
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def current_company
    @company  ||= current_user.company
  end

  helper_method :current_company

  protected

  def layout_by_resource
    if devise_controller?
      "base"
    else
      "application"
    end
  end

  private

  ##
  # set_store loads the global companies.
  def set_company
    @company  ||= Company.find_by_sub_domain request.subdomain
    # if request.subdomain.blank?
    #   redirect_to root_url(subdomain: 'www')
    # elsif request.subdomain != "www" && @company.nil?
    #   redirect_to root_url(subdomain: 'www')
    # end
  end
end
