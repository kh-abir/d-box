class ProductsController < ApplicationController
  load_and_authorize_resource

  def search
    if params[:search].blank?
      redirect_to root_path
    else
      @parameter = params[:search].downcase
      @results = Product.all.where("lower(title) LIKE :search", search: "%#{@parameter}%")
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
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
  end


  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      redirect_to products_path
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
      redirect_to products_path
    else
      render :edit, notice: 'try again'
    end
  end

  def destroy
    @product = Product.find(params[:id])
=begin
    @product_variants = @product.product_variants.all
    @product_variants.each do |variant|
      variant.destroy
    end
=end

    if @product.destroy
      redirect_to products_path, notice: 'Product Delete Successfully'
    else
      redirect_to products_path, notice: "Something went wrong can't delete now. Try again Please"
    end
  end

  private

  def product_params
    params.require(:product).permit( :title, :category_id, :sub_category_id, product_variants_attributes: [ :id, :details, :price, :in_stock, :purchase_price])
  end

end
