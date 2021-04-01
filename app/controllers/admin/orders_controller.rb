class Admin::OrdersController < ApplicationController

  load_and_authorize_resource :except => [:edit]

  def index
    @orders = Order.where.not(user_id: nil, in_cart: true).paginate(page: params[:page], per_page: Order::PER_PAGE).order("created_at DESC")
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @previous_order_status = @order.status
    if @order.update(order_params)
      if @order.status == 3
        OrderedItem.restore_ordered_items(@order.id)
      end
      redirect_to admin_orders_path, notice: 'Order updated successfully!'
    else
      render :edit, notice: 'Try again'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      flash[:delete_order] = "Order has been deleted"
      redirect_back(fallback_location: 'back')
    else
      flash[:added_to_cart] = "Can't perform the operation now. Please try again"
      redirect_back(fallback_location: 'back')
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
