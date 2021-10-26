module ApplicationHelper
  def get_all_categories
    Category.all
  end

  def formatted_price(price)
    number_with_precision(price/100.0, precision: 2, delimiter: ',')
  end

  def find_product_variant(id)
    ProductVariant.find_by(id: id)
  end

  def populate_saved_cart_items
    order = current_user.orders.last
    if order&.in_cart
      ordered_items = order.ordered_items
      ordered_items.map do |item|
        next if session[:ordered_items].any? { |element| element['product_variant_id'].to_i == item.product_variant_id }
        ordered_item = { product_variant_id: item.product_variant_id, price: item.final_price, quantity: item.quantity }
        item.attributes.map { |key, val| ordered_item[key] = val unless %w[id price created_at updated_at].include?(key) }
        (session[:ordered_items] ||= []) << ordered_item
      end
      ordered_items.delete_all
    end
  end

  def validate_cart_items
    stock_changed = false
    session[:ordered_items].reject! do |cart_item|
      product_variant = find_product_variant(cart_item['product_variant_id'])
      unless product_variant.blank?
        cart_item['price'] = product_variant.final_price
        if product_variant.in_stock < cart_item['quantity'].to_i
          stock_changed = true
          cart_item['quantity'] = product_variant.in_stock
        end
      end
      product_variant.blank? || product_variant.in_stock.zero?
    end

    stock_changed
  end

  def cart_total
    session[:cart_total] = session[:ordered_items]&.map { |item| (item['quantity'].to_d * item['price'].to_d) }&.sum.to_d
  end

  def total_cart_items
    session[:ordered_items]&.map { |item| item['quantity'].to_i }&.sum
  end

end
