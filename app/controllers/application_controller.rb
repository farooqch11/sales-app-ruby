class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  helper FilepickerRails::Engine.helpers

  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

  before_filter :authenticate_user!
  # before_filter :set_company
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def current_company
    @company  ||= current_user.company if !current_user.nil? && user_signed_in?
  end
  helper_method :current_company

  def current_location
    @current_location  ||= current_user.active_location if !current_user.nil? && user_signed_in?
  end
  helper_method :current_location

  def after_sign_in_path_for(resource)
   if resource.class.name == 'User'
      return dashboard_index_path
    else
      super
    end
  end
  protected

  def layout_by_resource
     devise_controller? ? "base" : "application"
  end

  private

  ##
  # set_store loads the global companies.
  def set_company
    # @company  ||= Company.find_by_sub_domain request.subdomain
    # if request.subdomain.blank?
    #   redirect_to root_url(subdomain: 'www')
    # elsif request.subdomain != "www" && @company.nil?
    #   redirect_to root_url(subdomain: 'www')
    # end
  end
end
