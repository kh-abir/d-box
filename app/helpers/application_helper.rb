module ApplicationHelper
  def get_all_categories
    Category.all
  end

  def formatted_price(price)
    number_with_precision(price / 100.0, precision: 2, delimiter: ',')
  end

  def find_product_variant(id)
    ProductVariant.find_by(id: id)
  end

  def store_user_cart
    order = current_user.orders.create(
      in_cart: true,
      status: 0
    )
    session[:ordered_items]&.map { |item| order.ordered_items.create(item) unless find_product_variant(item['product_variant_id']).blank? }
    session[:ordered_items] = nil
  end

  def populate_saved_cart_items
    order = current_user.orders.last
    if order&.in_cart
      ordered_items = order.ordered_items
      session[:ordered_items]&.map do |cart_item|
        ordered_item = ordered_items.detect { |item| item.product_variant_id == cart_item['product_variant_id'].to_i }
        next if ordered_item&.update(cart_item)
        ordered_items.create(cart_item) unless find_product_variant(cart_item['product_variant_id']).blank?
      end
    else
      store_user_cart
    end
  end

  def validate_cart_items
    stock_changed = false
    current_cart_items.map do |cart_item|
      product_variant = find_product_variant(cart_item.product_variant_id)
      unless product_variant.blank?
        cart_item.price = product_variant.final_price
        if product_variant.in_stock < cart_item.quantity
          stock_changed = true
          cart_item.quantity = product_variant.in_stock
        end
      end
      current_cart_items.delete(cart_item) if product_variant.blank? || product_variant.in_stock.zero?
    end
    stock_changed
  end

  def current_cart_items
    store_user_cart if current_user&.orders&.last&.in_cart == false
    current_user&.orders&.last&.ordered_items || session[:ordered_items] || nil
  end

  def cart_total
    return current_cart_items.sum('subtotal') unless current_user.blank?
    session[:ordered_items]&.map { |item| (item['quantity'].to_d * item['price'].to_d) }&.sum.to_d
  end

  def total_cart_items
    return current_cart_items.count unless current_user.blank?
    session[:ordered_items]&.count
  end

end
