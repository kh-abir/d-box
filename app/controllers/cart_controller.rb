class CartController < ApplicationController
  def index
    @ordered_items = current_order.ordered_items
  end

  def check_coupon
    @coupon = Coupon.find_by(code: params[:code])
    if @coupon.nil?
      result = ("Invalid").to_json
    else
      result = @coupon.has_valid_coupon ? Coupon.find_by(code: params[:code]) : false
    end
    render json: result
  end
end
