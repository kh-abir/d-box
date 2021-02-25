require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Admin::CouponController, type: :controller do

  coupon = FactoryBot.create(:coupon)

  describe "index" do
    login_admin
    it 'should render the coupon index page' do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "new" do
    login_admin
    it 'should render new coupon page' do
      get :new
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "create" do
    login_admin
    it 'should ' do
      params = FactoryBot.attributes_for :coupon
      post :create, params: {coupon: params}
      expect(response).to redirect_to(admin_coupon_index_path)
    end
  end

  describe "edit" do
    login_admin
    it 'should render banner edit page' do
      get :edit, params: {id: Coupon.last.id}
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "update" do
    it 'should be successful' do
      put :update, params: {id: Coupon.last.id, :code => "Update coupon"}
      Coupon.last.reload
      expect(response).to be_successful
    end
  end

  describe "destroy" do
    login_admin
    it 'should be successful' do
      delete :destroy, params: { id: coupon.id }
      expect(response).to redirect_to(admin_coupon_index_path)
    end
  end

end