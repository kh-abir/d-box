class Admin::OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:create]
  load_and_authorize_resource

  def index
    @final_orders = FinalOrder.paginate(page: params[:page], per_page: FinalOrder::PER_PAGE).order("created_at DESC")
  end

  def edit
    @final_order = FinalOrder.find(params[:id])
  end

  def show

  end

  def create
      if current_order.ordered_items.exists?
        @order = current_order
        @final_order = FinalOrder.new
        @final_order.user_id = @order.user_id
        @final_order.total = @order.ordered_items.sum(:subtotal)
        @final_order.purchase_price = @order.purchase_price
        @final_order.save

        @order.ordered_items.each do |item|
          @final_ordered_item = FinalOrderedItem.new
          @final_ordered_item.final_order_id = @final_order.id
          @final_ordered_item.product_variant_id = item.product_variant_id
          @final_ordered_item.quantity = item.quantity
          @final_ordered_item.price = item.price
          @final_ordered_item.subtotal = item.subtotal
          @final_ordered_item.purchase_price = item.purchase_price
          @final_ordered_item.save

          @product_variant = ProductVariant.find(@final_ordered_item.product_variant_id)
          ProductVariant.find(@product_variant.id).decrement!(:in_stock,@final_ordered_item.quantity)
          @product_variant.save
        end



        @order.destroy
        session[:guest_cart] = nil
        render :show
      else
        redirect_to cart_path, alert: 'Can not proceed your order now.'
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


  def checkout

  end


end
