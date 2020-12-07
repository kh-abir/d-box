class ProductVariantsController < ApplicationController
  def show
    @product_variant = ProductVariant.find(params[:id])
    @ordered_item = OrderedItem.new
  end

  def index
    @product_variants = ProductVariant.all
    @ordered_item = current_order.ordered_items.new
  end

  def new
    @product_variant = ProductVariant.new
    @product = Product.find(params[:format])
  end

  def create
    @product_variant = ProductVariant.create(product_variant_params)
    if @product_variant.save
      redirect_to products_path, notice: "New variant added successfully!"
    else
      # redirect_to new_product_variant_path, alert: 'try again'
      render :new
    end
  end

  private

  def product_variant_params
    params.require(:product_variant).permit(:details, :price, :in_stock, :product_id, :purchase_price)
  end

end