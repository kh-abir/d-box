class Admin::OrderedItemsController < ApplicationController

  load_and_authorize_resource

  def index
    @order = Order.find(params[:order_id])
    @ordered_items = @order.ordered_items
    @user = @order.user
    @user_address = @user.shipping_addresses.find_by(order_id: @order.id)
  end

end
