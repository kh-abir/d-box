require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Admin::ProductsController, type: :controller do

  FactoryBot.create(:category)
  FactoryBot.create(:sub_category, :category_id => Category.last.id)
  FactoryBot.create(:product, :sub_category_id => SubCategory.last.id, category_id: Category.last.id)
  FactoryBot.create(:product_variant, :product_id => Product.last.id)

  describe "index" do
    login_admin
    it 'should render the product index page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template("index")
    end
  end

  describe "show" do
    login_admin
    it 'should render product show page' do
      get :show, params: {id: Product.last.id}
      expect(response).to render_template("show")
    end
  end

  describe "new" do
    login_admin
    it 'should render the new product page' do
      get :new
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "create" do
    login_admin
    it 'should be' do
      params = FactoryBot.attributes_for :product
      variant_params = FactoryBot.attributes_for :product_variant
      post :create, params: {product: params, sub_category_id: Product.last.sub_category_id, category_id: Product.last.category_id, product_variant: variant_params, product_id: ProductVariant.last.product_id}
      expect(response).to be_successful
    end
  end

  describe "edit" do
    login_admin
    it 'should render product edit page' do
      get :edit, params: {id: Product.last.id}
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "update" do
    it 'should be successful' do
      put :update, params: {id: Product.last.id, :title => ("update product")}
      Product.last.reload
      expect(response).to be_successful
    end
  end

end