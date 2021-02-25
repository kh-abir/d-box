require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Admin::CategoriesController, type: :controller do

  category = FactoryBot.create(:category)
  subcategory = FactoryBot.create(:sub_category, :category_id => category.id)

  describe "index" do
    login_admin
    it 'should render categories index path' do
      get :index
      expect(response).to render_template("index")
      expect(response).to be_successful
    end
  end

  describe "show" do
    login_admin
    it 'should render category show page' do
      get :show, params: {id: Category.last.id}
      expect(response).to render_template("show")
      expect(response).to be_successful
    end
  end

  describe "new" do
    login_admin
    it 'should render category new page' do
      get :new
      expect(response).to render_template("new")
      expect(response).to be_successful
    end
  end

  describe "create" do
    login_admin
    it 'should redirect category index page' do
      params = FactoryBot.attributes_for :category
      post :create, params: {category: params}
      expect(response).to redirect_to(admin_categories_path)
    end
  end

  describe "edit" do
    login_admin
    it 'should render edit page' do
      get :edit, params: {id: Category.last.id}
      expect(response).to render_template("edit")
    end
  end

  describe "update" do
    login_admin
    it 'should be successful' do
      params = FactoryBot.attributes_for :category
      put :update, params: {:id => Category.last.id, category: params}
      Category.last.reload
      expect(response).to redirect_to(admin_categories_path)
    end
  end

  describe "get_subcategories" do
    it 'should be successful' do
      @expected = {
        :id  => subcategory.id,
        :title => subcategory.title,
      }.to_json
      get :get_subcategories, params: {id: subcategory.id, category_id: category.id}
      response.body == @expected
    end
  end

  describe "destroy" do
    login_admin
    it 'should be successful' do
      delete :destroy, params: { id: category.id }
      expect(response).to redirect_to(admin_categories_path)
    end
  end

end