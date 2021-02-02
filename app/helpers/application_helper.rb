module ApplicationHelper
  def get_all_categories
    Category.all
  end

  def formatted_price(price)
    number_with_precision(price, precision: 2, delimiter: ',')
  end

  def current_order
    if user_signed_in?
      if current_user.orders.exists? and current_user.orders.last.pending
        order = current_user.orders.last
      else
        order = current_user.orders.create
      end
    else
      if session[:guest_cart]
        order = Order.find(session[:guest_cart])
      else
        order = Order.create
        session[:guest_cart] = order.id
      end
    end
    order
  end

  def transfer_guest_cart
    if session[:guest_cart]
      validate_saved_cart_item
      guest_order = Order.find(session[:guest_cart])
      guest_order.ordered_items.each do |item|
        already_in_cart = current_order.ordered_items.find_by(product_variant_id: item.product_variant_id)
        already_in_cart.destroy if already_in_cart
        item.order_id = current_order.id
        item.save
      end
      guest_order.destroy
      session[:guest_cart] = nil
    end
  end

  def validate_saved_cart_item
    current_order.ordered_items.each do |saved_cart_item|
      product_variant = saved_cart_item.product_variant
      if product_variant.in_stock < saved_cart_item.quantity
        #send notification that saved_cart_item is not enough in stock
        if product_variant.in_stock == 0
          saved_cart_item.destroy
        else
          saved_cart_item.quantity = product_variant.in_stock
          saved_cart_item.save
        end
      end
    end
  end

end
