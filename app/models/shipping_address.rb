class ShippingAddress < ApplicationRecord
  belongs_to :user

  def self.user_shipping_address(current_order, session)
    current_order.ordered_items.each do |item|
      product_variant = ProductVariant.find(item.product_variant_id)
      product_variant.decrement(:in_stock, item.quantity)
      product_variant.save
    end
    order = Order.find(current_order.id)
    if session[:amount]
      order.coupon_discount = session[:amount]
      session[:amount] = nil
    end
    order.in_cart = false
    order.status = 0
    order.save
  end

end

