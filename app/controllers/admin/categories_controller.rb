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
      redirect_to admin_categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end


  def edit
  end


  def get_subcategories
    @subcategories = @category.sub_categories
    render json:@subcategories
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: 'Category was successfully destroyed.'
  end



  private

  def category_params
    params.require(:category).permit(:title)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
