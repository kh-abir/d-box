class ShoppingCart

  delegate :sub_total, to: :order

  def initialize(token:)
    @token = token
  end

  def order
    @order ||= Invoice.find_or_create_by(token: @token) do |order|
      order.sub_total = 0
    end
  end

  def items_count
    invoice.order.ordered_items.sum(:quantity)
  end

  def add_item(product_variant_id:, quantity: 1)
    product = ProductVariant.find(product_variant_id)

    order_item = order.ordered_items.find_or_initialize_by(
        product_variant_id: product_variant_id
    )


    order_item.price = product.price
    order_item.quantity = quantity

    ActiveRecord::Base.transaction do
      order_item.save
      update_sub_total!

    end
  end

  def remove_item(id:)
    order.ordered_items.destroy(id)
    ActiveRecord::Base.transaction do
      update_sub_total!
    end
  end

  private

  def update_sub_total!
    order.sub_total = order.ordered_items.sum( 'quantity * price' )
    order.save
  end

end
