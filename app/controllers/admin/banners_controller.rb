class Admin::BannersController < ApplicationController

  def index
    @banners = Banner.all
  end

  def new
    @banner = Banner.new
  end

  def create
    @banner = Banner.create(banner_params)
    if @banner.save
      redirect_to admin_banners_path, notice: 'Banner successfully created.'
    else
      render :new, notice: 'Can not create Banner. Please try Again.'
    end
  end

  private

  def banner_params
    params.require(:banner).permit(:name, :link_type, :link_id)
  end

end

