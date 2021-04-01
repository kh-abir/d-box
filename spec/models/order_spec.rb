require 'rails_helper'

RSpec.describe Order, type: :model do

  category = FactoryBot.create(:category)
  subcategory = FactoryBot.create(:sub_category, :category_id => Category.last.id)
  product = FactoryBot.create(:product, :category_id => Category.last.id, :sub_category_id => SubCategory.last.id)
  product_variant = FactoryBot.create(:product_variant, :product_id => Product.last.id)
  order = FactoryBot.create(:order, :user_id => 1)
  order_items = FactoryBot.create(:ordered_item, :order_id => Order.last.id, :product_variant_id => ProductVariant.last.id, :price => ProductVariant.last.price, :subtotal => ProductVariant.last.price * 1, :purchase_price => ProductVariant.last.purchase_price )

  describe "creation" do
    it 'should be successful' do
      expect(order.user_id).to_not be_nil
      expect(order.status).to_not be_nil
      expect(order.total).to_not eq(0)
      expect(Order.new).to be_valid
    end
  end

  describe "update" do
    it 'should be successful' do
      order.user_id = 2
      expect(order.user_id).to_not be_nil
      expect(order.status).to_not be_nil
      expect(order.total).to_not be < 0
    end
  end

  describe "method" do
    it '(total) should be successful' do
      total_method = order.total()
      expect(total_method).to_not be < 0
    end
  end

end