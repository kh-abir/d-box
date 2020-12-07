class AdminPanelsController < ApplicationController

  def index
    @user = User.all
    @final_order = FinalOrder.all
  end

end
