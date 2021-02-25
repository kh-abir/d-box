require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Admin::ProductVariantsController, type: :controller do

  FactoryBot.create(:category)
  FactoryBot.create(:sub_category, :category_id => Category.last.id)
  FactoryBot.create(:product, :sub_category_id => SubCategory.last.id, category_id: Category.last.id)
  FactoryBot.create(:product_variant, :product_id => Product.last.id)

  describe "index" do
    login_admin
    it 'should render index page' do
      get :index, params: {product_id: ProductVariant.last.product_id}
      expect(response).to be_successful
      expect(response).to render_template("index")
    end
  end

  describe "show" do
    login_admin
    it 'should render show page' do
      get :show, params: {id: ProductVariant.last.id, product_id: ProductVariant.last.product_id}
      expect(response).to render_template("show")
    end
  end

  describe "new" do
    login_admin
    it 'should render the product variant new page' do
      get :new, params: {product_id: ProductVariant.last.product_id}
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "create" do
    login_admin
    it 'should redirect product variant index page' do
      params = FactoryBot.attributes_for :product_variant
      post :create, params: {product_variant: params, product_id: ProductVariant.last.product_id}
      expect(response).to redirect_to(admin_product_product_variants_path)
    end
  end

  describe "edit" do
    login_admin
    it 'should render Product Variant edit page' do
      get :edit, params: {id: ProductVariant.last.id, product_id: ProductVariant.last.product_id}
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "update" do
    it 'should be successful' do
      put :update, params: {id: ProductVariant.last.id, product_id: ProductVariant.last.product_id, title: "Update ProductVariant"}
      ProductVariant.last.reload
      expect(response).to be_successful
    end
  end
end