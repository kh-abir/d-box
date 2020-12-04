module ApplicationHelper


  def get_all_categories
    Category.all
  end

  def current_order
    if current_user.orders.present?
      order = current_user.orders.last.pending ? current_user.orders.last : current_user.orders.new
    else
      order = current_user.orders.new
    end
  end

end
