require 'rails_helper'

RSpec.describe SubCategory, type: :model do
  subcategory = SubCategory.create(:title => "TestSubcategory", :category_id => Category.last.id ? Category.last.id : 0)

  context "creation" do
    it "has been cancelled due to error" do
      expect(subcategory).not_to eq(0)
      expect(subcategory.title).not_to be_blank
      expect(subcategory.id).not_to eq(nil)
      expect(SubCategory.last!).to eq(subcategory)
    end
  end

  context "update" do
    it "has been cancelled due to error" do
      subcategory.update(:title => "EditTestSubcategory", :category_id => Category.count > 1 ? Category.last.id-1 : Category.last.id)
      expect(subcategory.category_id).to eq(Category.count > 1 ? Category.last.id-1 : Category.last.id)
      expect(subcategory.title).not_to be_blank
      expect(SubCategory.all.where(:id => subcategory.id).count).not_to be > (1)
      expect(subcategory.id).to be > (0)
    end
  end
end

