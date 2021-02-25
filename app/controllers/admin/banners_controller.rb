class Admin::BannersController < ApplicationController

  load_and_authorize_resource

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

  def edit
    @banner = Banner.find(params[:id])
  end

  def update
    @banner = Banner.find(params[:id])
    if @banner.update(banner_params)
      redirect_to admin_banners_path, notice: 'Banner updated successfully!'
    else
      render :edit, notice: 'Try again'
    end
  end

  def destroy
    @banner = Banner.find(params[:id])
    if @banner.destroy
      redirect_to admin_banners_path, notice: 'Banner have been deleted successfully!'
    else
      redirect_to admin_banners_path, alert: "Something went wrong can't delete now. Try again Please."
    end
  end

  private

  def banner_params
    params.require(:banner).permit(:name, :link_type, :link_id, :banner_image)
  end
end

