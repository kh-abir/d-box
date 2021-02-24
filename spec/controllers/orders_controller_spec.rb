require 'rails_helper'
require_relative '../support/devise'

RSpec.describe OrdersController, type: :controller do

  FactoryBot.create(:category)
  FactoryBot.create(:sub_category, :category_id => Category.last.id)
  FactoryBot.create(:product, :category_id => Category.last.id, :sub_category_id => SubCategory.last.id)
  FactoryBot.create(:product_variant, :product_id => Product.last.id)
  FactoryBot.create(:order)
  FactoryBot.create(:ordered_item, :order_id => Order.last.id, :product_variant_id => ProductVariant.last.id, :price => ProductVariant.last.price, :subtotal => ProductVariant.last.price * 1, :purchase_price => ProductVariant.last.purchase_price )

  context "new" do
    login_user
    it "should render new template" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "show" do
    it 'should render cart show page' do
      get :show, params: {:id => Order.last.id}
    end
  end

  describe "create" do
    login_user
    it 'should render show page ' do
      params = FactoryBot.attributes_for :ordered_item
      post :create, params: {:ordered_item => params, :order_id => Order.last.id, :product_variant_id => ProductVariant.last.id, :price => ProductVariant.last.price, :subtotal => ProductVariant.last.price * 1, :purchase_price => ProductVariant.last.purchase_price }
      expect(response).to redirect_to(cart_index_path)
    end
  end

end