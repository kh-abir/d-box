require 'rails_helper'

RSpec.describe SubCategory, type: :model do
  FactoryBot.create(:category)
  subcategory = FactoryBot.create(:sub_category, :category_id => Category.last.id)

  context "creation" do
    it "has been cancelled due to error" do
      expect(subcategory).not_to eq(0)
      expect(subcategory.title).not_to be_blank
      expect(subcategory.id).not_to eq(nil)
    end
  end

  context "update" do
    it "has been cancelled due to error" do
      subcategory.update(:title => "EditTestSubcategory", :category_id => Category.count > 1 ? Category.last.id-1 : Category.last.id)
      expect(subcategory.category_id).to eq(Category.count > 1 ? Category.last.id-1 : Category.last.id)
      expect(subcategory.title).not_to be_blank
      expect(subcategory.id).to be > (0)
    end
  end
end

