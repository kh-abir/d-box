class HomeController < ApplicationController

  load_and_authorize_resource

  def index
    @categories = Category.all
  end

end
