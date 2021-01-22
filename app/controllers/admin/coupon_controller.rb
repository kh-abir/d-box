class Admin::CouponController < ApplicationController

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
      redirect_to admin_coupon_index_path, notice: 'Coupon Created!'
    else
      render :new, alert: 'try again'
    end
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    @coupon = Coupon.find(params[:id])
    if @coupon.update(coupon_params)
      redirect_to admin_coupon_index_path, notice: 'Coupon Updated Successfully!'
    else
      render :edit, notice: 'Try Again'
    end
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    if @coupon.destroy
      redirect_to admin_coupon_index_path, notice: 'Coupon Deleted Successfully!'
    else
      redirect_to admin_coupon_index_path, alert: 'Try Again'
    end
  end

  private
  def coupon_params
    params.require(:coupon).permit(:code, :amount, :valid_from, :valid_till)
  end

end
