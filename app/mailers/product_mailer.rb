class ProductMailer < ApplicationMailer
  include ApplicationHelper
  helper :application
  default from: 'd-box@example.com'

  def send_notification
    @user = User.find(params[:user])
    @url  = params[:url]
    @product = ProductVariant.find(params[:product])
    mail(to: @user.email, subject: 'Product back in stock')
  end
end
