class HomeController < ApplicationController

  def index
    @categories = Category.all
    @banners = Banner.all
  end

  def all_products
    @products = Product.all
  end

  def check_coupon
    @coupon = Coupon.find_by(code: params[:code])
    if @coupon.nil?
      response = ("Invalid").to_json
    else
      response = @coupon.has_valid_coupon ? Coupon.find_by(code: params[:code]) : false
      if response
        session[:amount] = response.amount
      end
    end
    render json: response
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
