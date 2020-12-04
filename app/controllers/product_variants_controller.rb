class ProductVariantsController < ApplicationController
  def show

  end

  def new
    @product_variant = ProductVariant.new
    @product = Product.find(params[:format])
  end

end