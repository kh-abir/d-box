class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @categories = Category.all
  end

  def show
    @sub_categories = @category.sub_categories
  end

  def get_subcategories
    @subcategories = @category.sub_categories
    render json: @subcategories
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

end
