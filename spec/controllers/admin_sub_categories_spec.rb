require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Admin::SubCategoriesController, type: :controller do

  FactoryBot.create(:category)
  FactoryBot.create(:sub_category, :category_id => Category.last.id)

  describe "index" do
    login_admin
    it 'should render subcategory index page' do
      get :index, params: {category_id: SubCategory.last.category_id}
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

  describe "new" do
    login_admin
    it 'should render subcategory new page' do
      get :new, params: {category_id: SubCategory.last.category_id}
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "create" do
    login_admin
    it 'should redirect subcategory index page' do
      params = FactoryBot.attributes_for :sub_category
      post :create, params: {sub_category: params, :category_id => Category.last.id}
      expect(response).to redirect_to(admin_category_sub_categories_path)
    end
  end

  describe "edit" do
    login_admin
    it 'should render subcategory edit page' do
      get :edit, params: {id: SubCategory.last.id, category_id: SubCategory.last.category_id}
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe "update" do
    login_admin
    it 'should be successful' do
      params = FactoryBot.attributes_for :sub_category
      put :update, params: {id: SubCategory.last.id, category_id: SubCategory.last.category_id, :sub_category => params}
      SubCategory.last.reload
      expect(response).to redirect_to(admin_category_sub_categories_path)
    end
  end

  describe "destroy" do
    login_admin
    it 'should be successful' do
      delete :destroy, params: { id: SubCategory.last.id, category_id: SubCategory.last.category_id }
      expect(response).to redirect_to(admin_category_sub_categories_path)
    end
  end

end