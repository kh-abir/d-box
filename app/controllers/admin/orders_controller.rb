class Admin::OrdersController < ApplicationController

  load_and_authorize_resource :except => [:edit]

  def index
    @orders = Order.where.not(user_id: nil, pending: true).paginate(page: params[:page], per_page: Order::PER_PAGE).order("created_at DESC")
  end

  def edit
    @order = Order.find(params[:id])
  end

  def show
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
end
