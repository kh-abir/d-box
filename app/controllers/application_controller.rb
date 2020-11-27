class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    render "shared/_access_denied"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact ])
  end
end
