class Admin::OrdersController < ApplicationController

  load_and_authorize_resource :except => [:edit]

  def index
    @final_orders = FinalOrder.paginate(page: params[:page], per_page: FinalOrder::PER_PAGE).order("created_at DESC")
  end

  def edit
    @final_order = FinalOrder.find(params[:id])
  end

  def show
  end

  def destroy
    @final_order = FinalOrder.find(params[:id])
    if @final_order.destroy
      flash[:delete_order] = "Order has been deleted"
      redirect_back(fallback_location: 'back')
    else
      flash[:added_to_cart] = "Can't perform the operation now. Please try again"
      redirect_back(fallback_location: 'back')
    end
  end
end
