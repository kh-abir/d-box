class Admin::OrderedItemsController < ApplicationController

  def create
    # ordered_item = ordered_item_params
    # session[:ordered_items] << ordered_item
    @ordered_item = current_order.ordered_items.create(ordered_item_params)
    @ordered_item.subtotal = ordered_item_params[:price].to_i * ordered_item_params[:quantity].to_i
    @ordered_item.purchase_price = ordered_item_params[:purchase_price].to_i * ordered_item_params[:quantity].to_i

    if @ordered_item.save
      redirect_to cart_path, notice: "Item added to cart"
    else
      flash[:added_to_cart] = "Could not add to cart. Please try again!"
      redirect_back(fallback_location: 'back')
    end
    # redirect_to cart_path
  end

  def update
    @ordered_item = current_order.ordered_items.find(params[:id])
    @ordered_item.subtotal = ordered_item_params[:price].to_i * ordered_item_params[:quantity].to_i
    @ordered_item.update(ordered_item_params)
    @ordered_items = current_order.ordered_items
    redirect_to cart_path, notice: "Cart updated"

  end

  def destroy
    @ordered_item = current_order.ordered_items.find(params[:id])
    @ordered_item.destroy
    @ordered_items = current_order.ordered_items
    redirect_to cart_path, notice: "Item removed from the cart"
  end

  def index
    @final_order = FinalOrder.find(params[:order_id])
    @final_ordered_items = @final_order.final_ordered_items
  end


  private

  def ordered_item_params
    params.require(:ordered_item).permit( :quantity, :product_variant_id, :price, :total, :purchase_price )
  end

end
