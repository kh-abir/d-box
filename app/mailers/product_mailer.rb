class ProductMailer < ApplicationMailer
  default from: 'd-box@example.com'

  def send_notification
    @user = User.find(params[:user])
    @url  = "http://localhost:3000/"
    @product = ProductVariant.find(params[:product])
    mail(to: @user.email, subject: 'Product back in stock')
  end
end
