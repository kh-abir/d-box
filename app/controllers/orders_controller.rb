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
        save_order(transaction)
        @user.order_id = current_user.orders.where(in_cart: false).last.id
        @user.save
        redirect_to show_invoice_path, notice: 'Payment Successful!'
      end
    else
      flash.now[:alert] = 'Provide Valid address please!'
      render :new
    end
  end

  private

  def save_order(transaction)
    coupon_discount = session[:coupon_amount] || nil
    current_cart_items.map { |item| find_product_variant(item.product_variant_id).decrement!('in_stock', item.quantity) }
    current_user.orders.last.update(
      transaction_id: transaction.id,
      coupon_discount: coupon_discount,
      in_cart: false,
      status: 0
    )
    session[:coupon_amount] = nil
  end

  def address_params
    params.require(:shipping_address).permit(:first_name, :last_name, :email, :address, :phone, :city, :street, :country, :zip)
  end

  def amount
    @amount = session[:coupon_amount] ? cart_total - session[:coupon_amount] : cart_total
  end

end