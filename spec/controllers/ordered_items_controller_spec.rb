require 'rails_helper'
require_relative '../support/devise'

RSpec.describe OrderedItemsController, type: :controller do

  FactoryBot.create(:category)
  FactoryBot.create(:sub_category, :category_id => Category.last.id)
  FactoryBot.create(:product, :category_id => Category.last.id, :sub_category_id => SubCategory.last.id)
  FactoryBot.create(:product_variant, :product_id => Product.last.id)
  FactoryBot.create(:order)
  FactoryBot.create(:ordered_item, :order_id => Order.last.id, :product_variant_id => ProductVariant.last.id, :price => ProductVariant.last.price, :purchase_price => ProductVariant.last.purchase_price )

  # describe "create" do
  #   login_user
  #   it 'should redirect to carts index path' do
  #     params = FactoryBot.attributes_for :ordered_item
  #     post :create, params: {:ordered_item => params, :order_id => Order.last.id, :product_variant_id => ProductVariant.last.id, :price => ProductVariant.last.price, :purchase_price => ProductVariant.last.purchase_price }
  #     expect(response).to redirect_to(carts_path)
  #   end
  # end

end