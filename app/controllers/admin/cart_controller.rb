class Admin::CartController < ApplicationController
  def show
    @ordered_items = current_order.ordered_items
  end
end
