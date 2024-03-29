class Admin::ProductVariantsController < ApplicationController

  load_and_authorize_resource

  before_action :set_product

  def show
    @product_variant = ProductVariant.find(params[:id])
  end

  def new
    @product_variant = ProductVariant.new
  end

  def create
    @product_variant = @product.product_variants.create(product_variant_params)
    if @product_variant.save
      redirect_to admin_product_path(@product), notice: "New variant added successfully!"
    else
      render :new, alert: 'try again'
    end
  end

  def edit
    @product_variant = @product.product_variants.find(params[:id])
  end

  def update
    if @product_variant.update(product_variant_params)
      redirect_to admin_product_path(@product), notice: 'variant updated Successfully'
    else
      render :edit, notice: 'try again'
    end
  end

  def destroy
    @product_variant = ProductVariant.find(params[:id])
    if @product_variant.destroy
      redirect_to admin_product_path(@product), notice: 'Product Variant Delete Successfully'
    else
      redirect_to admin_product_path(@product), notice: "Something went wrong can't delete now. Try again Please"
    end
  end

  def search_variants
    @product_variants = @product.product_variants.all.where("details iLIKE ?", "%#{params[:search_variants]}%").paginate(page: 1, per_page: 10).order('details ASC')
  end

  def variants_search_suggestion
    search_text = params[:search_text]
    @product_variants = @product.product_variants.all.where("details iLIKE ?", "%#{search_text}%")
    respond_to do |format|
      format.html
      format.json { render json: {product_variants: @product_variants} }
    end
  end

  private

  def product_variant_params
    params.require(:product_variant).permit(:details, :price, :in_stock, :product_id, :purchase_price, :featured, :unit, product_images: [])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

end