class Admin::ProductsController < ApplicationController

  load_and_authorize_resource

  def index
    @products = Product.paginate(page: params[:page], per_page: Product::PER_PAGE).order('title ASC')
  end

  def show
    @product_variants = @product.product_variants.paginate(page: params[:page], per_page: 10)
  end

  def new
    @product = Product.new
    @product.product_variants.build

  end

  def create
    @product = Product.create(product_params)
    if @product.save
      redirect_to admin_products_path, notice: 'Product Added successfully'
    else
      render :new, notice: 'try again'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path, notice: 'Product updated successfully!'
    else
      render :edit, notice: 'try again'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to admin_products_path, notice: 'Product Delete Successfully'
    else
      redirect_to admin_products_path, alert: "Something went wrong can't delete now. Try again Please"
    end
  end

  def search_products
      @products = Product.all.where("title iLIKE ?", "%#{params[:search_products]}%").paginate(page: params[:page], per_page: Product::PER_PAGE).order('title ASC')
  end

  def products_search_suggestion
    search_text = params[:search_text]
    @products = Product.all.where("title iLIKE ?", "%#{search_text}%")
    respond_to do |format|
      format.html
      format.json { render json: {products: @products} }
    end
  end

  private

  def product_params
    params.require(:product).permit(:brand_image, :title, :category_id, :sub_category_id, product_variants_attributes: [:id, :details, :price, :in_stock, :purchase_price, :_destroy, :featured, :unit, product_images: []])
  end

  def set_sub_category
    @sub_category = SubCategory.find(params[:sub_category_id])
  end

end
