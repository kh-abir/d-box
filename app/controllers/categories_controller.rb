class CategoriesController < ApplicationController
  load_and_authorize_resource

  def get_subcategories
    @subcategories = @category.sub_categories
    render json: @subcategories
  end

end