class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :amount

  def show_invoice

    @order = current_user.orders.where(in_cart: false).last
    @ordered_items = @order.ordered_items
    @user = @order.user
    @user_address = @user.shipping_addresses.find_by(order_id: @order.id)
  end

  def new
    if validate_saved_cart_item === true
      redirect_to cart_index_path, notice: 'Cart changed according to stock availability'
    end
    @user_address = current_user.shipping_addresses.new
  end

  def process_payment
    @user_address = user_address(address_params)
    if @user_address.valid?
      begin
        if current_user.stripe_id.nil?
          customer = Payment.create_customer(current_user, params[:stripeToken])
        else
          customer = Payment.set_customer(current_user, params[:stripeToken])
        end
        transaction = Payment.create_transaction(customer, @amount.to_i)
        card = Payment.find_card(customer)
        @user_address.payment_option = card.brand

      rescue Stripe::CardError => e
        flash.now[:alert] = e.message
        render :new
      else
        @user_address.save
        save_order(transaction)
        redirect_to show_invoice_path, notice: 'Payment Successful!'
      end
    else
      flash.now[:alert] = 'Provide Valid address please!'
      render :new
    end
  end

  private

  def user_address(address_params)
    @user_address = current_user.shipping_addresses.new(address_params)
    @user_address.order_id = current_order.id
    @user_address
  end

  def save_order(transaction)
    current_order.ordered_items.each do |item|
      product_variant = ProductVariant.find(item.product_variant_id)
      product_variant.decrement(:in_stock, item.quantity)
      product_variant.save
    end
    order = Order.find(current_order.id)
    order.transaction_id = transaction.id
    if session[:coupon_amount]
      order.coupon_discount = session[:coupon_amount]
      session[:coupon_amount] = nil
    end
    order.in_cart = false
    order.status = 0
    order.save
  end

  def address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :email, :address, :phone, :city, :street, :country, :zip)
  end

  def amount
    @amount = session[:coupon_amount] ? current_order.total - session[:coupon_amount] : current_order.total
  end

end