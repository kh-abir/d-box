require 'rails_helper'
require_relative '../support/devise'

RSpec.describe ProductVariantsController, type: :controller do

  category = FactoryBot.create(:category)
  subcategory = FactoryBot.create(:sub_category, :category_id => Category.last.id)
  product = FactoryBot.create(:product, :sub_category_id => SubCategory.last.id, category_id: Category.last.id)
  product_variant = FactoryBot.create(:product_variant, :product_id => Product.last.id)

  describe "index" do
    it 'should render the index page' do
      get :index, params: {:product_id => product.id}
      expect(response).to render_template("index")
    end
  end

  describe "show" do
    it 'should render the show page' do
      get :show, params: {:product_id => product.id, :id => product_variant.id}
      expect(response).to render_template("show")
    end
  end


end