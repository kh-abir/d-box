class CartsController < ApplicationController
  before_action :set_product_variant, only: :add_to_cart

  def index
    @ordered_items = session[:ordered_items] || nil
    @total = cart_total
  end

  def add_to_cart
    ordered_item = ordered_item_params
    @product_variant.attributes.map { |key, val| ordered_item[key] = val unless %w[id price created_at updated_at].include?(key) }
    (session[:ordered_items] ||= []) << ordered_item
    respond_to do |format|
      format.html { redirect_to carts_path, notice: "Item added to carts" }
    end
  end

  def update_cart
    session[:ordered_items]&.map { |item| break if (item['product_variant_id'] == ordered_item_params['product_variant_id'] ? (item['quantity'] = ordered_item_params['quantity']) : false) }
    total = session[:ordered_items]&.map { |item| (item['quantity'].to_d * item['price'].to_d) }.sum.to_d
    respond_to do |format|
      format.html { redirect_to carts_path, notice: "Quantity updated" }
      format.json { render json: total }
    end
  end

  def remove_cart_item
    session[:ordered_items].delete_if { |item| item['product_variant_id'] == params[:product_variant_id] }
    redirect_to carts_path, notice: "Item removed from the cart"
  end

  private

  def ordered_item_params
    params.require(:ordered_item).permit(:quantity, :product_variant_id, :price)
  end

  def set_product_variant
    @product_variant = ProductVariant.find(ordered_item_params[:product_variant_id])
  end

end
