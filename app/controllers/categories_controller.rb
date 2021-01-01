class CategoriesController < ApplicationController
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

end