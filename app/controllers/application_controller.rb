class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  helper FilepickerRails::Engine.helpers


  rescue_from Exception, with: :render_generic_exception if Rails.env.production?   #make sure the generic Exception handler is at the top
  rescue_from ActionController::RoutingError, with: :render_not_found if Rails.env.production?
  rescue_from ActionController::UnknownController, with: :render_not_found if Rails.env.production?
  rescue_from AbstractController::ActionNotFound, with: :render_not_found if Rails.env.production?
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found if Rails.env.production?

  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

  before_filter :authenticate_user!
  # before_filter :set_company
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to dashboard_index_path, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
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

  def has_access? permission
    if current_user.is_owner?
      true
    elsif current_user.has_access?(permission)
      true
    else
      redirect_to :dashboard_index_path , notice: "Access Denied"
    end
  end

  protected

  def layout_by_resource
     devise_controller? ? "base" : "application"
  end

  def render_not_found(exception = nil)
    render_exception(404, 'Not Found', exception)
  end

  def render_exception(status = 500, message = 'An Error Occurred', exception)
    # @status = status
    # @message = message
    # email = UserMailer.exception_notify(exception,exception.backtrace[0..25].join('\n'),params,request).deliver if Rails.env.production?
    render template: "template/404", formats: [:html], layout: false
  end

  def error_routing
    render template: "template/404", formats: [:html], layout: false
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
