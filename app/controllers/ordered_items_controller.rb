class OrderedItemsController < ApplicationController

  def create
    #TODO
    # ordered_item = ordered_item_params
    # session[:ordered_items] << ordered_item
    @ordered_item = current_order.ordered_items.create(ordered_item_params)
    if @ordered_item.save
      redirect_to cart_index_path, notice: "Item added to cart"
    else
      flash[:added_to_cart] = "Could not add to cart. Please try again!"
      redirect_back(fallback_location: 'back')
    end
  end

  def update
    @ordered_item = current_order.ordered_items.find(params[:id])
    @ordered_item.update(ordered_item_params)
    @ordered_items = current_order.ordered_items
    total = @ordered_items.sum(:subtotal)
    respond_to do |format|
      format.html { redirect_to cart_index_path, notice: "Quantity updated" }
      format.json { render json: total }
    end
  end

  def destroy
    @ordered_item = current_order.ordered_items.find(params[:id])
    @ordered_item.destroy
    @ordered_items = current_order.ordered_items
    redirect_to cart_index_path, notice: "Item removed from the cart"
  end

  private

  def ordered_item_params
    params.require(:ordered_item).permit(:quantity, :product_variant_id, :price, :purchase_price)
  end

end
