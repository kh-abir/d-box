class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :amount

  def show_invoice
    @order = current_user.orders.where(in_cart: false).last
    @ordered_items = @order.ordered_items
    @user = current_user.shipping_addresses.find_by(order_id: @order.id)
  end

  def new
    if validate_cart_items === true
      redirect_to carts_path, alert: 'Cart changed according to stock availability'
    end
    @user = current_user.shipping_addresses.new
  end

  def process_payment
    @user = current_user.shipping_addresses.new(address_params)
    if @user.valid?
      begin
        if current_user.stripe_id.nil?
          customer = Payment.create_customer(current_user, params[:stripeToken])
        else
          customer = Payment.set_customer(current_user, params[:stripeToken])
        end
        transaction = Payment.create_transaction(customer, @amount.to_i)
        card = Payment.find_card(customer)
        @user.payment_option = card.brand

      rescue Stripe::CardError => e
        flash.now[:alert] = e.message
        render :new
      else
        order = save_order(transaction)
        @user.order_id = order.id
        @user.save
        redirect_to show_invoice_path, notice: 'Payment Successful!'
      end
    else
      flash.now[:alert] = 'Provide Valid address please!'
      render :new
    end
  end

  def store_user_cart
    order = current_user.orders.create(
      in_cart: true,
      status: 0
    )
    save_ordered_items(order)
  end

  private

  def save_order(transaction)
    save_ordered_items(create_order(transaction.id))
  end

  def create_order(transaction_id)
    orders = current_user.orders
    if orders.last&.in_cart
      order = orders.last.update(
        transaction_id: transaction_id
      )
    else
      order = orders.create(
        transaction_id: transaction_id
      )
    end

    unless session[:coupon_amount].blank?
      order.coupon_discount = session[:coupon_amount]
      session[:coupon_amount] = nil
    end
    order.update(in_cart: false, status: 0)
    order
  end

  def save_ordered_items(order)
    session[:ordered_items].map do |item|
      product_variant = find_product_variant(item['product_variant_id'])
      unless product_variant.blank?
        ordered_item = order.ordered_items.create(
          product_variant_id: product_variant.id,
          quantity: item['quantity'].to_i,
        )
        product_variant.decrement!(:in_stock, ordered_item.quantity.to_i) unless order.in_cart
      end
    end
    session[:ordered_items] = nil
    order
  end

  def address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :email, :address, :phone, :city, :street, :country, :zip)
  end

  def amount
    @amount = session[:coupon_amount] ? cart_total - session[:coupon_amount] : cart_total
  end

end