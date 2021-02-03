class Admin::ProductVariantsController < ApplicationController

  load_and_authorize_resource

  before_action :set_product, except: [:delete_image_attachment]

  def index
    @product_variants = @product.product_variants
    @ordered_item = current_order.ordered_items.new
  end

  def show
    @product_variant = ProductVariant.find(params[:id])
    @ordered_item = OrderedItem.new
  end

  def new
    @product_variant = ProductVariant.new
  end

  def create
    @product_variant = @product.product_variants.create(product_variant_params)
    if @product_variant.save
      redirect_to admin_product_product_variants_path, notice: "New variant added successfully!"
    else
      # redirect_to new_product_variant_path, alert: 'try again'
      render :new
    end
  end

  def edit
    @product_variant = @product.product_variants.find(params[:id])
  end

  def update
    previous_stock = @product_variant.in_stock
    current_stock = params[:product_variant][:in_stock]
    url = product_product_variant_url(@product, @product_variant)
    if @product_variant.update(product_variant_params)
      if previous_stock.to_i == 0 and current_stock.to_i > 0
        @product_variant.notifications.each do |item|
          ProductMailer.with(url: url, user: item.user_id, product: item.product_variant_id).send_notification.deliver_now
          item.destroy
        end
      end
      redirect_to admin_product_product_variants_path(@product), notice: 'variant updated Successfully'
    else
      render :edit, notice: 'try again'
    end
  end

  def destroy
    @product_variant = ProductVariant.find(params[:id])
    # raise @product_variant.inspect
    if @product_variant.destroy
      redirect_to admin_product_product_variants_path(@product), notice: 'Product Variant Delete Successfully'
    else
      redirect_to admin_product_product_variants_path(@product), notice: "Something went wrong can't delete now. Try again Please"
    end
  end

  private

  def product_variant_params
    params.require(:product_variant).permit( :details, :price, :in_stock, :product_id, :purchase_price, :featured, product_images: [])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

end