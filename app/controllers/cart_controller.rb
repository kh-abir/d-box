class CartController < ApplicationController
  def index
    @ordered_items = current_order.ordered_items
  end
end
