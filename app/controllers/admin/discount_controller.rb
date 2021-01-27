class Admin::DiscountController < ApplicationController

  before_action :delete_existing_discount, only: :create
  def index
    @discount = Discount.all
  end

  def new
    @discount = Discount.new
  end

  def create
    @discount = Discount.create(discount_params)
    if @discount.save
      redirect_to admin_discount_index_path, notice: 'Discount Created!'
    else
      render :new, alert: 'try again'
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    if @discount.update(discount_params)
      redirect_to admin_discount_index_path, notice: 'Discount Updated Successfully!'
    else
      render :edit, notice: 'try again'
    end
  end

  def destroy
    @discount = Discount.find(params[:id])
    if @discount.destroy
      redirect_to admin_discount_index_path, notice: 'Discount Deleted Successfully!'
    else
      redirect_to admin_discount_index_path, notice: 'try again'
    end
  end

  private
  def delete_existing_discount
    @current_discount = Discount.where(
        discountable_type: params[:discount][:discountable_type],
        discountable_id: params[:discount][:discountable_id]
    )
    @current_discount.delete_all unless @current_discount.nil?
  end

  def discount_params
    params.require(:discount).permit(:discountable_id, :discountable_type, :discount_type, :amount, :discount_name, :valid_from, :valid_till)
  end
end
