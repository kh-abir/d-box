class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create

    @product = Product.create(product_params)

    if @product.save
      redirect_to products_path
    else
      render new_product_path, notice: 'try again'
    end
  end




  private
  def product_params
    params.require(:product).permit( :title, :sub_category_id, :category_id)
  end

end
