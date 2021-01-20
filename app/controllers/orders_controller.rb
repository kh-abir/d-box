class OrdersController < ApplicationController

  before_action :authenticate_user!
  def show
  end

  def new
  end

  def update_total
    session[:amount] = params[:amount]
  end

  def create
    if current_order.ordered_items.exists?
      @order = current_order
      @final_order = FinalOrder.new
      @final_order.user_id = @order.user_id
      @final_order.name = params[:full_name]
      @final_order.address = params[:address]
      @final_order.address += (", " + params[:city]) if params[:city].present?
      @final_order.address += (", " + params[:state]) if params[:state].present?
      @final_order.address += ("-" + params[:zip]) if params[:zip].present?
      @final_order.phone = params[:phone]
      @final_order.email = params[:email]
      @final_order.payment_method = params[:payment_option].capitalize
      @final_order.status = 0
      @final_order.total = @order.ordered_items.sum(:subtotal)
      @final_order.total -= session[:amount].to_d unless session[:amount].nil?
      @final_order.purchase_price = @order.purchase_price
      @final_order.save
      @order.ordered_items.each do |item|
        @final_ordered_item = FinalOrderedItem.new
        @final_ordered_item.final_order_id = @final_order.id
        @final_ordered_item.title = item.product_variant.product.title
        @final_ordered_item.product_variant_id = item.product_variant_id
        @final_ordered_item.quantity = item.quantity
        @final_ordered_item.price = item.price
        @final_ordered_item.subtotal = item.subtotal
        @final_ordered_item.purchase_price = item.purchase_price
        @final_ordered_item.save
        @product_variant = ProductVariant.find(@final_ordered_item.product_variant_id)
        ProductVariant.find(@product_variant.id).decrement!(:in_stock, @final_ordered_item.quantity)
        @product_variant.save
      end
      @order.destroy
      session[:guest_cart] = nil
      render :show
    else
      redirect_to cart_index_path, alert: 'Can not proceed your order now.'
    end
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
