class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  include ApplicationHelper
  helper_method
  rescue_from CanCan::AccessDenied do
    render "shared/_access_denied"
  end

  def after_sign_in_path_for(resource_or_scope)
    if current_user.admin? or current_user.super_admin?
      admin_admin_panels_path
    else
      populate_saved_cart_items
      if session[:url]
        url = session[:url]
        session[:url] = nil
        url
      else
        stored_location_for(resource_or_scope) || root_path
      end
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact])
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

end
