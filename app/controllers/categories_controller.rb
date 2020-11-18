class CategoriesController < ApplicationController
  before_action :authenticate_user!



  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    # @category.title = params[:title]
    # raise params.inspect
      if @category.save
        redirect_to categories_path, notice: 'Category was successfully created.'
      else
        render :new
      end
  end


  private

  def category_params
    params.require(:category).permit(:title)
  end

end
