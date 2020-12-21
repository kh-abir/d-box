module ApplicationHelper


  def get_all_categories
    Category.all
  end

  def current_order
    if user_signed_in?
      if current_user.orders.exists?
        order = current_user.orders.last.pending ? current_user.orders.last : current_user.orders.create
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
      order
    end
  end

  def transfer_guest_cart
    if session[:guest_cart]
        guest_order = Order.find(session[:guest_cart])
        guest_order.ordered_items.each do |item|
          item.order_id = current_order.id
          item.save
        end
        guest_order.destroy
        session[:guest_cart] = nil
    end
  end

end
