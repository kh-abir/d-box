class HomeController < ApplicationController


  def index
    @categories = Category.all
    @products = Product.all
  end

end
