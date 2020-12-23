class HomeController < ApplicationController

  def index
    @categories = Category.all
  end

  def all_products
    @products = Product.all
  end

end
