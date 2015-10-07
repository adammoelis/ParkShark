class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :resource_name, :resource, :devise_mapping, :current_user?
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:error] = 'Resource not found.'
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :uid, :provider) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation, :uid, :provider) }
  end

  def current_user?
    current_user.id == @user.id
  end
end
