class OrderedItemsController < ApplicationController

  def create
    @order = current_order
    @order.save
    @ordered_item = @order.ordered_items.create(ordered_item_params)
    @ordered_item.total = ordered_item_params[:price].to_i * ordered_item_params[:quantity].to_i
    if @ordered_item.save
      render 'Item added successfully to the Cart'
    else
      render 'Error'
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
    params.require(:ordered_item).permit( :quantity, :product_variant_id, :price, :total )
  end

  def set_order
    @order = current_order
  end
end
