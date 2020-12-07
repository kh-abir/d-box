class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include ApplicationHelper


  rescue_from CanCan::AccessDenied do
    render "shared/_access_denied"
  end



  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact])
  end

end
