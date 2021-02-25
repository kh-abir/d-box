require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Admin::DiscountController, type: :controller do

  discount = FactoryBot.create(:discount)
  category = FactoryBot.create(:category)
  subcategory = FactoryBot.create(:sub_category, :category_id => Category.last.id)
  product = FactoryBot.create(:product, :sub_category_id => SubCategory.last.id, category_id: Category.last.id)
  product_variant = FactoryBot.create(:product_variant, :product_id => Product.last.id)

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
    end
  end

  describe "create" do
    login_admin
    it 'should be' do
      params = FactoryBot.attributes_for :discount
      post :create, params: {discount: params}
      expect(response).to redirect_to(admin_discount_index_path)
    end
  end

  describe "edit" do
    login_admin
    it 'should render product edit page' do
      get :edit, params: {id: Discount.last.id}
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "update" do
    it 'should be successful' do
      put :update, params: {id: Discount.last.id, :discountable_type => ("Category")}
      Discount.last.reload
      expect(response).to be_successful
    end
  end

  describe "destroy" do
    login_admin
    it 'should be successful' do
      delete :destroy, params: { id: Discount.last.id }
      expect(response).to redirect_to(admin_discount_index_path)
    end
  end
end