class HomeController < ApplicationController

  load_and_authorize_resource

  def index
    @categories = Category.all
  end

  def all_products
    @products = Product.all.order('title ASC')
  end

end
