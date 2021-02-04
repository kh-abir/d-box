class OrdersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, only: [:new, :create]

  def show
  end

  def new
    if validate_saved_cart_item === true
      redirect_to cart_index_path, notice: 'Cart changed according to stock availability'
    end
  end

  def create
    if current_order.ordered_items.exists?
      @user_address = current_user.shipping_addresses.new
      @user_address.attributes = address_params
      @user_address.order_id = current_order.id
      if @user_address.save
        ShippingAddress.user_shipping_address(current_order, session)
        render :show
      else
        render :new
      end
    else
      redirect_to cart_index_path, alert: 'Can not proceed your order now.'
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
  def address_params
    params.permit(  :full_name,:email, :phone, :city, :state, :zip, :payment_option)
  end

end
