class Admin::AdminPanelsController < ApplicationController

  load_and_authorize_resource :class => false

  def index
    @user = User.all
    @final_order = FinalOrder.all
  end

  def all_products
    @products = Product.paginate(page: params[:page], per_page: Product::PER_PAGE).order('title ASC')
  end

  def reports
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @user = User.all
    @final_ordered_items = FinalOrderedItem.all
    @today_top_twenty_product = FinalOrderedItem.to_day.top_twenty_product
    @this_week_top_twenty_product = FinalOrderedItem.this_week.top_twenty_product
    @this_month_top_twenty_product = FinalOrderedItem.this_month.top_twenty_product
  end

end