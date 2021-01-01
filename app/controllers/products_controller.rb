class ProductsController < ApplicationController

  load_and_authorize_resource

  def search
    if params[:search].blank?
      redirect_to root_path, notice: "No result found!"
    else
      @parameter = params[:search]
      @products = Product.all.where("title iLIKE ?", "%#{@parameter}%")
      @sub_categories = SubCategory.all.where("title iLIKE ?", "%#{@parameter}%")
      @categories = Category.all.where("title iLIKE ?", "%#{@parameter}%")
    end
  end

  def search_suggestions
    search_text = params[:search_text]
    @products = Product.all.where("title iLIKE ?", "%#{search_text}%")
    @sub_categories = SubCategory.all.where("title iLIKE ?", "%#{search_text}%")
    @categories = Category.all.where("title iLIKE ?", "%#{search_text}%")
    response = {"products" => @products, "categories" => @categories, "sub_categories" => @sub_categories}
    respond_to do |format|
      format.html
      format.json { render json: response }
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
end
