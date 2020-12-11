class AdminPanelsController < ApplicationController

  def index
    @user = User.all
    @final_order = FinalOrder.all
  end

  def all_products
    @products = Product.paginate(page: params[:page], per_page: Product::PER_PAGE).order("created_at DESC")
  end

end
