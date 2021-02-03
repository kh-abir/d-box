class ProductVariantsController < ApplicationController
  load_and_authorize_resource
  before_action :set_product

  def index
    @product_variants = @product.product_variants
    @ordered_item = current_order.ordered_items.new
  end

  def show
    @product_variant = ProductVariant.find(params[:id])
    @category = Category.find(@product_variant.product.category.id)
    @products = @category.products
    @ordered_item = OrderedItem.new
    @item_in_cart = current_order.ordered_items.find_by(product_variant_id: @product_variant.id)
    @notification = @product_variant.notifications.find_by(user_id: current_user.id) if current_user.present?
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

end