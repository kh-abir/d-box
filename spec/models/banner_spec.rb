require 'rails_helper'

RSpec.describe Banner, type: :model do

  FactoryBot.create(:category)
  FactoryBot.create(:sub_category, :category_id => Category.last.id)
  FactoryBot.create(:product, :category_id => Category.last.id, :sub_category_id => SubCategory.last.id)

  describe "creation" do
    it "of without link type has created successfully" do
      banner = FactoryBot.create(:banner, :with_avatar, :without_link, :link_id => nil)
      expect(banner.name).to_not be_nil
      expect(banner.link_id).to be_nil
      expect(banner.link_type).to eq("without_link")
    end

    it "product type has created successfully" do
      banner = FactoryBot.create(:banner, :with_avatar, :product_banner, :link_id => Product.last.id)
      expect(banner.name).to_not be_nil
      expect(banner.link_id).to_not be_nil
      expect(banner.link_type).to eq("product")
    end

    it "subcategory type has created successfully" do
      banner = FactoryBot.create(:banner, :with_avatar, :subcategory_banner, :link_id => SubCategory.last.id)
      expect(banner.name).to_not be_nil
      expect(banner.link_id).to_not be_nil
      expect(banner.link_type).to eq("sub_category")
    end

    it "of category type has created successfully" do
      banner = FactoryBot.create(:banner, :with_avatar, :category_banner, :link_id => Category.last.id)
      expect(banner.name).to_not be_nil
      expect(banner.link_id).to_not be_nil
      expect(banner.link_type).to eq("category")
    end
  end

  describe "update of" do
    it 'without link should be successful' do
      banner = FactoryBot.create(:banner, :with_avatar, :without_link, :link_id => nil)
      banner.link_type = nil
      expect(banner.reload).to_not eq(true)
    end
    it 'product link should be successful' do
      banner = FactoryBot.create(:banner, :with_avatar, :product_banner, :link_id => nil)
      banner.link_type = nil
      expect(banner.reload).to_not eq(true)
    end
    it 'subcategory should be successful' do
      banner = FactoryBot.create(:banner, :with_avatar, :subcategory_banner, :link_id => nil)
      banner.link_type = nil
      expect(banner.reload).to_not eq(true)
    end
    it 'category should be successful' do
      banner = FactoryBot.create(:banner, :with_avatar, :category_banner, :link_id => nil)
      banner.link_type = nil
      expect(banner.reload).to_not eq(true)
    end
  end

end

