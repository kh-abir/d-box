require 'rails_helper'
require_relative '../support/devise'

RSpec.describe HomeController, type: :controller do

  FactoryBot.create(:category)
  FactoryBot.create(:sub_category, :category_id => Category.last.id)
  FactoryBot.create(:product, :sub_category_id => SubCategory.last.id, category_id: Category.last.id)
  product_variant = FactoryBot.create(:product_variant, :product_id => Product.last.id)
  coupon = FactoryBot.create(:coupon)

  describe "index" do
    it 'should render home index page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template("index")
    end
  end

  describe "check_coupon" do
    it 'should be successful' do
      @expected = {
        :id  => coupon.id,
        :code => coupon.code,
        :amount => coupon.amount,
      }.to_json
      get :check_coupon, params: {code: coupon.code}
      response.body == @expected
    end
  end

  describe "save_user_to_notify" do
    login_user
    it 'should be successful' do
      notification = FactoryBot.create(:notification, :user_id => User.last.id, :product_variant_id => 1)
      @expected = {
        :id  => notification.id,
        :user_id => User.last.id,
        :product_variant_id => notification.product_variant_id,
      }.to_json
      get :save_user_to_notify,format: :json, params: {productId: notification.product_variant_id}
      expect(response).to be_successful
    end
  end

end
