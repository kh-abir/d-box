class ProductMailer < ApplicationMailer
  include ApplicationHelper
  helper :application
  default from: 'test@d-box.com'

  def send_product_back_in_stock_notification(user_id, product_variant_id)
    @user = User.find(user_id)
    @product_variant = ProductVariant.find(product_variant_id)
    @product = @product_variant.product
    @url  = product_product_variant_url(@product, @product_variant)
    mail(to: @user.email, subject: 'Product back in stock')
  end
end
