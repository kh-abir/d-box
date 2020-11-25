class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create

    @product = Product.create(product_params)

    if @product.save
      redirect_to home_index_path
    else
      render new_product_path
    end
  end




  private
  def product_params
    params.require(:product).permit( :title, :sub_category_id, :category_id)
  end

end
