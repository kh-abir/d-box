require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Admin::BannersController, type: :controller do

  banner = FactoryBot.create(:banner)

  describe "index" do
    login_admin
    it 'should render banner index page' do
      get :index
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

  describe "new" do
    login_admin
    it 'should render banner new page' do
      get :new
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "create" do
    login_admin
    it 'should redirect banner index page' do
      params = FactoryBot.attributes_for :banner
      post :create, params: {banner: params}
      expect(response).to redirect_to(admin_banners_path)
    end
  end

  describe "edit" do
    login_admin
    it 'should render banner edit page' do
      get :edit, params: {id: Banner.last.id}
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "update" do
    it 'should be successful' do
      put :update, params: {id: Banner.last.id, :link_type => ("category_link")}
      Banner.last.reload
      expect(response).to be_successful
    end
  end

  describe "destroy" do
    it 'should be successful' do
      delete :destroy, params: { id: banner.id }
      expect(response).to be_successful
    end
  end

end