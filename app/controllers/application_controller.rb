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

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :location, :phone, :gender, :birthday, :bio, :avatar, :password, :current_password) }
  end

  def current_user?
    current_user.id == @user.id
  end
end
