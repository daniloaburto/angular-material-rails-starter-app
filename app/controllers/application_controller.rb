#encoding: utf-8
class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :set_timezone

  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :set_locale

  def pundit_user
    # current_user
    nil
  end

  private
    # Set locale
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

  	# Set app timezone from browser
    def set_timezone
      default_timezone = Time.zone
      client_timezone  = cookies[:timezone]
      Time.zone = client_timezone if client_timezone.present?
      yield
    ensure
      Time.zone = default_timezone
    end

    # Redirect if user not authorized
    def user_not_authorized
      redirect_to request.referer || "/", flash: { error: t('not_authorized', scope: :pundit) }
    end

    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for resource_or_scope
      new_user_session_path
    end

    # # Overwriting the sign_in redirect path method
    # def after_sign_in_path_for resource
    #   authenticated_root_path
    # end

  protected
    # Strong parameters - works only if devise registration is enabled
    def configure_devise_permitted_parameters
      #registration_params = [:user_name, :role, :email, :password, :password_confirmation]
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password) }
    end

    def default_url_options
      { locale: I18n.locale }
    end
end
