require 'rails_helper'
require_relative '../support/devise'

RSpec.describe ProductsController, type: :controller do

  category = FactoryBot.create(:category)
  subcategory = FactoryBot.create(:sub_category, :category_id => Category.last.id)
  product = FactoryBot.create(:product, :sub_category_id => SubCategory.last.id, category_id: Category.last.id)
  product_variant = FactoryBot.create(:product_variant, :product_id => Product.last.id)

  describe "index" do
    it 'should render the index page according to category' do
      get :index, params: {:category_id => category.id}
      expect(response).to render_template("index")
    end
    it 'should render the index page according to subcategory' do
      get :index, params: {:sub_category_id => subcategory.id}
      expect(response).to render_template("index")
    end
  end

  describe "search" do
    it 'should render the search result page' do
      get :search, params: {:search => product.title}
      expect(response).to render_template("search")
    end
  end
end