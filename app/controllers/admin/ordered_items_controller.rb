class Admin::OrderedItemsController < ApplicationController

  load_and_authorize_resource

  def index
    @final_order = FinalOrder.find(params[:order_id])
    @final_ordered_items = @final_order.final_ordered_items
  end

end
