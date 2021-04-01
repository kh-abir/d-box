class HomeController < ApplicationController

  def index
    @categories = Category.all
    @banners = Banner.all
    @this_month_top_six_product = OrderedItem.this_month.top_six_product
  end

  def all_products
    @products = Product.all
  end

  def check_coupon
    @coupon = Coupon.find_by(code: params[:code])
    if @coupon.nil?
      response = false
    else
      response = @coupon.has_valid('Coupon') ? Coupon.find_by(code: params[:code]) : false
      if response and response.amount < current_order.total
        session[:coupon_amount] = response.amount.to_i
        session[:coupon_code] = response.code
      else
        response = false
      end
    end
    render json: response
  end

  def remove_coupon
    session[:coupon_amount] = nil
    session[:coupon_code] = nil
  end

  def save_user_to_notify
    response = current_user.present? ? true : false
    if response
      item = ProductVariant.find(params[:productId])
      item.notifications.create(user_id: current_user.id)
    end
    respond_to do |format|
      format.json { render json: response }
    end
  end

  def delete_user_notification
    item = ProductVariant.find(params[:productId])
    notification = item.notifications.find_by(user_id: current_user.id)
    notification.destroy
  end

end
