class ProductVariantsController < ApplicationController
  load_and_authorize_resource
  before_action :set_product

  def show
    @product_variant = ProductVariant.find(params[:id])
    @price = @product_variant.price
    @final_price = @product_variant.final_price
    @products = @product_variant.product.category.products
    @product_in_cart = current_cart_items&.detect { |el| el.is_a?(Hash) ? (el['product_variant_id'].to_i == @product_variant.id) : (el.product_variant_id == @product_variant.id) }
    @notification = @product_variant.notifications.find_by(user_id: current_user.id) if current_user.present?
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

end