class Admin::CouponController < ApplicationController

  def index
    @coupons = Coupon.all
  end
  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.create(coupon_params)
    if @coupon.save
      redirect_to admin_coupon_index_path, notice: 'Coupon Created'
    else
      render :new, alert: 'try again'
    end
  end

  private
  def coupon_params
    params.require(:coupon).permit(:code, :amount, :valid_from, :valid_till)
  end

end
