class OrderedItemsController < ApplicationController

  def index
    @ordered_items = current_cart.order.ordered_items

  end

  def create
    current_cart.add_item(
        product_variant_id: params[:product_variant_id],
        quantity: params[:quantity]
    )

    redirect_to cart_path
  end

  def destroy
    current_cart.remove_item(id: params[:id])
    redirect_to cart_path
  end
end
