class HomeController < ApplicationController

  def index
    @categories = Category.all
    @banners = Banner.all
  end

  def all_products
    @products = Product.all
  end

end
