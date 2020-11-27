class ApplicationController < ActionController::Base
  before_action :current_cart, :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  helper_method :current_cart

  rescue_from CanCan::AccessDenied do
    render "shared/_access_denied"
  end

  def current_cart
    @current_cart ||= ShoppingCart.new(token: cart_token)
  end


  private

  def cart_token
    return @cart_token unless @cart_token.nil?

    session[:cart_token] ||= SecureRandom.hex(8)
    @cart_token = session[:cart_token]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :first_name, :last_name, :email, :gender, :password, :contact ])
  end

end
