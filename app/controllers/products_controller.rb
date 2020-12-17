class ProductsController < ApplicationController
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


  private

  def product_params
    params.require(:product).permit( :title, :category_id, :sub_category_id, product_variants_attributes: [ :id, :details, :price, :in_stock, :purchase_price, :_destroy, :featured])
  end


  def set_sub_category
    @sub_category = SubCategory.find(params[:sub_category_id])
  end

  # def set_product
  #   @product = Product.find(params[:id])
  # end

end
