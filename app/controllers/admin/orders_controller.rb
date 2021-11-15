class Admin::OrdersController < ApplicationController

  load_and_authorize_resource :except => [:edit]

  def search_orders
    customers = User.where("(last_name || first_name) iLIKE ?", "%#{params[:search_orders]}%")
    @orders = Order.where(in_cart: false, user: customers).paginate(page: params[:page], per_page: Order::PER_PAGE).order("created_at DESC")
  end

  def orders_search_suggestion
    customers = User.where("(last_name || first_name) iLIKE ?", "%#{params[:search_text]}%")
    @orders = Order.where(in_cart: false, user: customers).paginate(page: params[:page], per_page: Order::PER_PAGE).order("created_at DESC")

    orders = @orders.map do |order|
      {
        order_id: order.id,
        name: "#{order.user.first_name} #{order.user.last_name}"
      }
    end
    respond_to do |format|
      format.html
      format.json { render json: {orders: orders} }
    end
  end

  def index
    @orders = Order.where(in_cart: false).paginate(page: params[:page], per_page: Order::PER_PAGE).order("created_at DESC")
  end

  def show
    @order = Order.find(params[:id])
    @ordered_items = @order.ordered_items
    @user = @order.user.shipping_addresses.find_by(order_id: @order.id)
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
