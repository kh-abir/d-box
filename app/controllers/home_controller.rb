class HomeController < ApplicationController


  def index
  end

  def all_products
    @products = Product.all
  end

end
