class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  include ApplicationHelper



  rescue_from CanCan::AccessDenied do
    render "shared/_access_denied"
  end

  def after_sign_in_path_for(resource_or_scope)
    current_order
    transfer_guest_cart
    # raise  stored_location_for(resource).inspect
    stored_location_for(resource_or_scope) || root_path
  end



  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact])
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

end
