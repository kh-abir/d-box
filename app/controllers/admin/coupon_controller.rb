class Admin::CouponController < ApplicationController

  load_and_authorize_resource

  def index
    @coupons = Coupon.all
  end
  def new
    @coupon = Coupon.new
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
