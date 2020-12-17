class Admin::SubCategoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_category
  before_action :set_sub_category
  load_and_authorize_resource

  def index
    @sub_categories = @category.sub_categories
  end

  def show
    @products_under_sub = @sub_category.products
  end

  def new
    @sub_category = @category.sub_categories.new
  end

  def create
    @sub_category = @category.sub_categories.create(sub_category_params)
    if @sub_category.save
      redirect_to category_sub_categories_path, notice: 'Sub-category created!'
    else
      render :new
    end
  end

  def edit
    @sub_category = SubCategory.find(params[:id])
  end

  def update
    if @sub_category.update(sub_category_params)
      redirect_to category_sub_categories_path, notice: 'Subcategory was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @sub_category = SubCategory.find(params[:id])
    if @sub_category.destroy
      redirect_to category_sub_categories_path
    else
      redirect_to category_sub_categories_path
    end
  end


  private

  def sub_category_params
    params.require(:sub_category).permit(:title, :category_id)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_sub_category
    @sub_category = SubCategory.find(params[:id]) if params[:id].present?
  end

end