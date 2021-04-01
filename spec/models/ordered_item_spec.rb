require 'rails_helper'

RSpec.describe OrderedItem, type: :model do

  category = FactoryBot.create(:category)
  subcategory = FactoryBot.create(:sub_category, :category_id => Category.last.id)
  product = FactoryBot.create(:product, :category_id => Category.last.id, :sub_category_id => SubCategory.last.id)
  product_variant = FactoryBot.create(:product_variant, :product_id => Product.last.id)
  order = FactoryBot.create(:order, :user_id => 1)
  order_items = FactoryBot.create(:ordered_item, :order_id => Order.last.id, :product_variant_id => ProductVariant.last.id, :price => ProductVariant.last.price, :subtotal => ProductVariant.last.price * 1, :purchase_price => ProductVariant.last.purchase_price )

  describe "creation" do
    it 'should be successful' do
      expect(order_items.product_variant_id).to_not be_nil
      expect(order_items.quantity).to_not be_nil
      expect(order_items.purchase_price).to_not be_nil
      expect(order_items.price).to_not be_nil
      expect(order_items.order_id).to_not eq(0)
    end
  end

  describe "update" do
    it 'should be successful' do
      order_items.quantity = 3
      expect(order_items.product_variant_id).to_not be_nil
      expect(order_items.quantity).to_not be_nil
      expect(order_items.purchase_price).to_not be_nil
      expect(order_items.price).to_not be_nil
      expect(order_items.order_id).to_not eq(0)
    end
  end
end