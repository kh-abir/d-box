class ProductsController < ApplicationController

  load_and_authorize_resource

  def index
    if params[:cat_id].present?
      @category = Category.find(params[:cat_id])
      @products = @category.products
    elsif params[:sub_id].present?
      @sub_category = SubCategory.find(params[:sub_id])
      @products = @sub_category.products

    else
      @products = Product.all
    end
  end

  def show

  end


  def new
    @product = Product.new
    @product.product_variants.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render new_product_path, notice: 'try again'
    end
  end


  def search
    if params[:search].blank?
      redirect_to root_path
    else
      @parameter = params[:search].downcase
      @results = Product.all.where("lower(title) LIKE :search", search: "%#{@parameter}%")
    end
  end


  private

  def product_params
    params.require(:product).permit( :title, :category_id, :sub_category_id, product_variants_attributes: [ :details, :price, :in_stock])
  end

end
