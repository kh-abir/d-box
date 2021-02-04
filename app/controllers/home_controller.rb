class HomeController < ApplicationController

  def index
    @categories = Category.all
    @banners = Banner.all
    @this_month_top_twenty_product = OrderedItem.this_month.top_twenty_product
  end

  def all_products
    @products = Product.all
  end

end
