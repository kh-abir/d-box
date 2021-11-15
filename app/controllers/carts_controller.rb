class CartsController < ApplicationController
  before_action :set_product_variant, only: :add_to_cart

  def index
    @ordered_items = current_cart_items
    @total = cart_total
  end

  def add_to_cart
    if current_user.present?
      current_cart_items.create(ordered_item_params)
    else
      (session[:ordered_items] ||= []) << ordered_item_params
    end
    respond_to do |format|
      format.html { redirect_to carts_path, notice: "Item added to carts" }
    end
  end

  def update_cart
    product_variant = find_product_variant(ordered_item_params['product_variant_id'])
    if current_user.present?
      ordered_item = current_cart_items.detect { |item| item.product_variant_id == product_variant.id }
      ordered_item&.update(ordered_item_params)
    else
      session[:ordered_items]&.map { |item| break if (item['product_variant_id'] == product_variant.id ? (item['quantity'] = ordered_item_params['quantity']) : false) }
    end

    total = cart_total
    unit = product_variant.unit.pluralize(ordered_item_params['quantity'])
    respond_to do |format|
      format.html { redirect_to carts_path, notice: "Quantity updated" }
      format.json { render json: {total: total, unit: unit} }
    end
  end

  def remove_cart_item
    if current_user.present?
      ordered_item = current_cart_items.detect { |item| item.product_variant_id == params[:product_variant_id].to_i }
      ordered_item.delete unless ordered_item.blank?
    else
      session[:ordered_items].delete_if { |item| item['product_variant_id'] == params[:product_variant_id] }
    end

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
