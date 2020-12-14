class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :set_sub_category, except: [:show, :index, :search, :search_suggestions]
  # before_action :set_product

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
    @search_text_result = Product.all.where("title iLIKE ?", "%#{search_text}%")
    respond_to do |format|
      format.html
      format.json {render json: @search_text_result}
    end

  end

  def index
    if params[:cat_id].present?
      @category = Category.find(params[:cat_id])
      @products = @category.products
    elsif params[:sub_id].present?
      @sub_category = SubCategory.find(params[:sub_id])
      @products = @sub_category.products
    else
      @sub_category = SubCategory.find(params[:sub_category_id])
      @products = @sub_category.products
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
    @product = @sub_category.products.create(product_params)
    @product.category_id = @sub_category.category_id
    if @product.save
      redirect_to category_sub_category_products_path
    else
      render :new, notice: 'try again'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
     # raise @product.inspect
    if @product.update(product_params)
      redirect_to category_sub_category_path(@sub_category.category, @sub_category), notice: 'Product updated successfully!'
    else
      render :edit, notice: 'try again'
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      redirect_to category_sub_category_path(@sub_category.category, @sub_category), notice: 'Product Deleted Successfully'
    else
      redirect_to category_sub_category_products_path, alert: "Something went wrong can't delete now. Try again Please"
    end
  end

  private

  def product_params
    params.require(:product).permit( :title, :category_id, :sub_category_id, product_variants_attributes: [ :id, :details, :price, :in_stock, :purchase_price, :_destroy])
  end


  def set_sub_category
    @sub_category = SubCategory.find(params[:sub_category_id])
  end

  # def set_product
  #   @product = Product.find(params[:id])
  # end

end
