class Admin::DiscountController < ApplicationController

  def index

  end

  def new
    @discount = Discount.new
  end

  private

  def discount_params
    params.require(:discount).permit( :product_id )
  end
end
