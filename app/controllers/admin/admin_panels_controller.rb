class Admin::AdminPanelsController < ApplicationController

  load_and_authorize_resource :class => false

  def index
    @user = User.all
    @order = Order.all.where(in_cart: false)
  end

  def reports
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @user = User.all
    @ordered_items = OrderedItem.all
    @today_top_twenty_product = OrderedItem.to_day.top_twenty_product
    @this_week_top_twenty_product = OrderedItem.this_week.top_twenty_product
    @this_month_top_twenty_product = OrderedItem.this_month.top_twenty_product
    revenue = Order.custom_date_revenue(@start_date, @end_date)

    respond_to do |format|
      format.html
      format.json { render json: revenue }
    end
  end

end