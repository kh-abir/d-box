class ProductVariantsController < ApplicationController
  load_and_authorize_resource
  before_action :set_product

  def index
    @product_variants = @product.product_variants
    @ordered_item = current_order.ordered_items.new
  end

  def show
    @product_variant = ProductVariant.find(params[:id])
    @ordered_item = OrderedItem.new
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

end