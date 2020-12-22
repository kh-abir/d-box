class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include ApplicationHelper



  rescue_from CanCan::AccessDenied do
    render "shared/_access_denied"
  end


  def after_sign_in_path_for(resource)
    if current_user.admin? or current_user.super_admin?
      admin_admin_panels_path
    else
      current_order
      transfer_guest_cart
      stored_location_for(resource) || root_path
    end
  end

  # def after_sign_up_path_for(resource)
  #   current_order
  #   transfer_guest_cart
  #   stored_location_for(resource) || root_path
  # end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact])
  end

end
