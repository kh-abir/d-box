module ApplicationHelper


  def get_all_categories
    Category.all
  end

  def current_order
    if user_signed_in?

      if current_user.orders.present?
        order = current_user.orders.last.pending ? current_user.orders.last : current_user.orders.new
      else
        order = current_user.orders.new
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

end
