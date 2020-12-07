class OrderedItemsController < ApplicationController

  def create
    @order = current_order
    @order.save
    @ordered_item = @order.ordered_items.create(ordered_item_params)
    @ordered_item.subtotal = ordered_item_params[:price].to_i * ordered_item_params[:quantity].to_i
    @ordered_item.purchase_price = ordered_item_params[:purchase_price].to_i * ordered_item_params[:quantity].to_i

    if @ordered_item.save
      flash[:added_to_cart] = "Product has been added to cart"
      redirect_back(fallback_location: 'back')
    else
      flash[:added_to_cart] = "Could not add to cart. Please try again!"
      redirect_back(fallback_location: 'back')
    end
  end

  def update
    @order = current_order
    @ordered_item = @order.ordered_items.find(params[:id])
    @ordered_item.total = ordered_item_params[:price].to_i * ordered_item_params[:quantity].to_i
    @ordered_item.update(ordered_item_params)
    @ordered_items = current_order.ordered_items
  end

  def destroy
    @order = current_order
    @ordered_item = @order.ordered_items.find(params[:id])
    @ordered_item.destroy
    @ordered_items = current_order.ordered_items
  end


  private

  def ordered_item_params
    params.permit( :quantity, :product_variant_id, :price, :total, :purchase_price )
  end

  def set_order
    @order = current_order
  end
end
