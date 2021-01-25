class Admin::DiscountController < ApplicationController

  before_action :delete, only: :create
  load_and_authorize_resource

  def index
    @discount = Discount.all
  end

  def new
    @discount = Discount.new
  end

  def create
    @discount = Discount.create(discount_params)
    if @discount.save
      redirect_to admin_discount_index_path, notice: 'Discount Created'
    else
      render :new, alert: 'try again'
    end
  end

  private

  def delete
    @id = Discount.where(
        discountable_type: params[:discount][:discountable_type],
        discountable_id: params[:discount][:discountable_id]
    )
    @id.delete_all unless @id.nil?
  end

  def discount_params
    params.require(:discount).permit(:discountable_id, :discountable_type, :discount_type, :amount, :discount_name, :valid_from, :valid_till)
  end
end
