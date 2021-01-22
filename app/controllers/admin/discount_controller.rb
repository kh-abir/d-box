class Admin::DiscountController < ApplicationController

  before_action :delete, only: :create
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
    if @product_variant.update(product_variant_params)
      redirect_to admin_product_product_variants_path(@product), notice: 'variant updated Successfully'
    else
      render :edit, notice: 'try again'
    end
  end

  def destroy
    @product_variant = ProductVariant.find(params[:id])
    # raise @product_variant.inspect
    if @product_variant.destroy
      redirect_to admin_product_product_variants_path(@product), notice: 'Product Variant Delete Successfully'
    else
      redirect_to admin_product_product_variants_path(@product), notice: "Something went wrong can't delete now. Try again Please"
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
