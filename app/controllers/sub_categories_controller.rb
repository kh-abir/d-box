class SubCategoriesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_subcategory, only: [:edit, :update]
  load_and_authorize_resource

  def index
    @sub_categories = SubCategory.all
  end

  def new
    @sub_category = SubCategory.new
  end

  def create

    @sub_category = SubCategory.create(sub_category_params)

    if @sub_category.save
      redirect_to sub_categories_path, notice: 'Sub-category created!'
    else
      render :new
    end
  end

  def edit
    @sub_category = SubCategory.find(params[:id])
  end

  def update
    if @sub_category.update(sub_category_params)
      redirect_to sub_categories_path, notice: 'Subcategory was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @sub_category = SubCategory.find(params[:id])
    if @sub_category.destroy
      redirect_to sub_categories_path
    else
      redirect_to sub_categories_path
    end
  end


  private

  def sub_category_params
    params.require(:sub_category).permit(:title, :category_id)
  end

  def set_subcategory
    @aub_category = SubCategory.find(params[:id])
  end

end
