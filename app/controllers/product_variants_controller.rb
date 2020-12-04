class ProductVariantsController < ApplicationController

  def index
    @product_variants = ProductVariant.all
     # raise current_order.inspect
     @ordered_item = current_order.ordered_items.new
  end

  def new
    @product_variant = ProductVariant.new
  end

  def create
    @product_variant = ProductVariant.create(product_variant_params)
    if @product_variant.save
      redirect_to product_variant_path, notice: "Item added to cart!"
    else
      # redirect_to new_product_variant_path, alert: 'try again'
       render :new
    end
  end




  private
  def product_variant_params
    params.require(:product_variant).permit( :details, :price, :in_stock, :product_id )
  end

end
