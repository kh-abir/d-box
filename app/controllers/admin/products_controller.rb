class Admin::ProductsController < ApplicationController

  load_and_authorize_resource

  def search
    if params[:search].blank?
      redirect_to root_path, notice: "No result found!"
    else
      @parameter = params[:search]
      @products = Product.all.where("title iLIKE ?", "%#{@parameter}%")
    end
  end

  def search_suggestions
    search_text = params[:search_text]
    # @sub_categories = SubCategory.all.where("title iLIKE ?", "%#{search_text}%")
    # @categories = Category.all.where("title iLIKE ?", "%#{search_text}%")
    @search_text_result = Product.all.where("title iLIKE ?", "%#{search_text}%")
    respond_to do |format|
      format.html
      format.json {render json: @search_text_result }
    end

  end

  def index
    if params[:sub_category_id].present?
      @sub_category = SubCategory.find(params[:sub_category_id])
      @products = @sub_category.products
    else
      @category = Category.find(params[:category_id])
      @products = @category.products
    end
  end

  def show
    @product_variants = @product.product_variants
  end

  def new
    @product = Product.new
    @product.product_variants.build

  end

  def create
    @product = Product.create(product_params)
    if @product.save
      redirect_to admin_all_product_path, notice: 'Product Added successfully'
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
      redirect_to admin_all_product_path, notice: 'Product updated successfully!'
    else
      render :edit, notice: 'try again'
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      redirect_to admin_all_product_path, notice: 'Product Delete Successfully'
    else
      redirect_to admin_all_product_path, alert: "Something went wrong can't delete now. Try again Please"
    end
  end

  private

  def product_params
    params.require(:product).permit( :brand_image, :title, :category_id, :sub_category_id, product_variants_attributes: [:id, :details, :price, :in_stock, :purchase_price, :_destroy, :featured])
  end

  def set_sub_category
    @sub_category = SubCategory.find(params[:sub_category_id])
  end

end
