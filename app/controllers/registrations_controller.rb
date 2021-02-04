class RegistrationsController < Devise::RegistrationsController
  def new
    session[:url] = request.referrer
    super
  end
end
