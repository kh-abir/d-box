class Admin::OrderedItemsController < ApplicationController

  def index
    @final_order = FinalOrder.find(params[:order_id])
    @final_ordered_items = @final_order.final_ordered_items
  end

end
