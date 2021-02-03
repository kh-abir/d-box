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
        current_order.ordered_items.each do |item|
          product_variant = ProductVariant.find(item.product_variant_id)
          product_variant.decrement(:in_stock, item.quantity)
          product_variant.save
        end
        order = Order.find(current_order.id)
        if session[:amount]
          order.coupon_discount = session[:amount]
          session[:amount] = nil
        end
        order.pending = false
        order.status = 0
        order.save
      else
        render :new
      end
      render :show
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
