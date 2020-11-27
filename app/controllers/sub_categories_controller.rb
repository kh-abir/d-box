class SubCategoriesController < ApplicationController

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


  private

  def sub_category_params
    params.require(:sub_category).permit(:title, :category_id)
  end

end
