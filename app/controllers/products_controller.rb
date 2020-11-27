class ProductsController < ApplicationController

  def index
    @products = Product.all
  end


  load_and_authorize_resource

  def index
    if params[:cat_id].present?
      @category = Category.find(params[:cat_id])
      @products = @category.products
    else
      @sub_category = SubCategory.find(params[:sub_id])
      @products = @sub_category.products
    end
  end

  def show

  end


  def new
    @product = Product.new
  end

  def create

    @product = Product.create(product_params)

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
    params.require(:product).permit( :title, :sub_category_id, :category_id)
  end

end
