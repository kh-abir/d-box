class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :show, :destroy, :get_subcategories]
  load_and_authorize_resource

  def index
    @categories = Category.all
  end

  def show
    @sub_categories = @category.sub_categories
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'Category successfully created.'
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def get_subcategories
    @subcategories = @category.sub_categories
    render json:@subcategories
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Category has been updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to admin_categories_path, notice: 'Category has been deleted successfully.'
    else
      redirect_to admin_categories_path, notice: 'Category can not be destroyed in this moment. Please try again'
    end
  end

  private
  def category_params
    params.require(:category).permit(:title, :category_icon)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
