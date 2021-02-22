class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def show
  end

  def new
    if validate_saved_cart_item === true
      redirect_to cart_index_path, notice: 'Cart changed according to stock availability'
    end
  end

  def process_payment
    if current_order.ordered_items.exists?
      @user_address = current_user.shipping_addresses.new
      @user_address.attributes = address_params
      @user_address.order_id = current_order.id
      if @user_address.save
        customer = Stripe::Customer.create({
           email: params[:stripeEmail],
           source: params[:stripeToken],
        })
        Stripe::Charge.create({
           customer: customer.id,
           amount: current_order.total.to_i,
           description: 'Stripe testing',
           currency: 'usd',
        })
        ShippingAddress.user_shipping_address(current_order, session)
        render :show
      else
        render :new
      end
    else
      redirect_to cart_index_path, alert: 'Can not proceed your order now.'
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :new

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
    params.permit(:full_name, :email, :phone, :city, :state, :zip)
  end

end